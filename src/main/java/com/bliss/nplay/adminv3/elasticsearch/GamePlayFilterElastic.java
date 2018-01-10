/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bliss.nplay.adminv3.elasticsearch;

import com.bliss.framework.util.ConvertUtils;
import com.bliss.nplay.adminv3.model.GamePlay;
import com.bliss.nplay.adminv3.model.GamePlayFilter;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.Operator;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import com.bliss.core.lib.PageView;
import com.bliss.core.lib.elasticsearch.ElasticSearchAccess;
import com.bliss.core.lib.exception.DataException;
import com.bliss.core.lib.utils.DateUtils;
import com.bliss.nplay.adminv3.model.DeckCards;
import com.bliss.nplay.adminv3.model.PlayerTurn;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import org.apache.commons.lang3.StringUtils;

/**
 *
 * @author anhlnt
 */
public class GamePlayFilterElastic extends ElasticSearchAccess<GamePlay, GamePlayFilter> {

    private static GamePlayFilterElastic instance = null;

    public static GamePlayFilterElastic getInstance() {
        if (instance == null) {
            synchronized (GamePlayFilterElastic.class) {
                instance = new GamePlayFilterElastic();
            }
        }
        return instance;
    }

    private static final String COMMA_DELIMITER = ",";

    public GamePlayFilterElastic() {
    }

    @Override
    protected String getIndexPattern() {
        return "nplay_game_play-*";
    }

    @Override
    protected void queryBuilder(GamePlayFilter filter, BoolQueryBuilder queryBuilder) throws IllegalArgumentException {
        if (!StringUtils.isBlank(filter.getElasticId())) {
            queryBuilder.must(QueryBuilders.matchQuery(DOCUMENT_ID, filter.getElasticId()));
        }
        if (filter.getGameId() > 0) {
            queryBuilder.must(QueryBuilders.matchQuery("game_id", filter.getGameId()));
        }
        if (filter.hasValue("fromStartDate")) {
            queryBuilder.must(QueryBuilders.rangeQuery("start_date")
                    .gte(DateUtils.getDateTime(filter.getDateValue("fromStartDate"))));
        }
        if (filter.hasValue("toStartDate")) {
            queryBuilder.must(QueryBuilders.rangeQuery("start_date")
                    .lt(DateUtils.getDateTime(filter.getDateValue("toStartDate"))));
        }
        if (filter.getLevelId() > -1) {
            queryBuilder.must(QueryBuilders.matchQuery("level_id", filter.getLevelId()));
        }
        if (!StringUtils.isBlank(filter.getUserIds())) {
            queryBuilder.must(QueryBuilders.matchQuery("player_ids", filter.getUserIds()).operator(Operator.AND));
            if (filter.getOwnerId() > 0) {
                queryBuilder.must(QueryBuilders.matchQuery("owner_id", filter.getOwnerId()));
            }
        }
        if (!StringUtils.isBlank(filter.getUserName())) {
            queryBuilder.must(QueryBuilders.matchQuery("players", filter.getUserName()));
        }
        if (!StringUtils.isBlank(filter.getDeviceID())) {
            queryBuilder.must(QueryBuilders.matchQuery("device", filter.getDeviceID()).operator(Operator.AND));
        }
        if (!StringUtils.isBlank(filter.getIp())) {
            queryBuilder.must(QueryBuilders.matchQuery("ip", filter.getIp()).operator(Operator.AND));
        }
        if (filter.getRoomId() > 0) {
            queryBuilder.must(QueryBuilders.matchQuery("room_id", filter.getRoomId()));
        }
        if (filter.getFromMoney() > 0) {
            queryBuilder.must(QueryBuilders.rangeQuery("bet_money").gte(filter.getFromMoney()));
        }
        if (filter.getToMoney() > 0) {
            queryBuilder.must(QueryBuilders.rangeQuery("bet_money").lte(filter.getToMoney()));
        }
        if (filter.getNumberUser() > 0) {
            queryBuilder.must(QueryBuilders.matchQuery("num_players", filter.getNumberUser()));
        }
        if (filter.getSpecialType() > 0) {
            queryBuilder.must(QueryBuilders.matchQuery("type_result", filter.getSpecialType()));
        }
        filter.setAsc(false);
        filter.setOrderBy("start_date");
    }

    public GamePlay get(String documentId) throws Exception {
        return super.doGet(documentId);
    }

    public PageView<GamePlay> search(GamePlayFilter filter) throws Exception {
        return super.doSearch(filter);
    }

    @Override
    protected GamePlay deserializer(SearchHit hit) throws Exception {
        Map<String, Object> document = hit.getSourceAsMap();
        GamePlay gamePlay = new GamePlay();
        gamePlay.setElasticId(hit.getId());
        gamePlay.setGameId(ConvertUtils.toInt(document.get("game_id")));
        gamePlay.setLevelId(ConvertUtils.toInt(document.get("level_id")));
        gamePlay.setRoomId(ConvertUtils.toInt(document.get("room_id")));
        gamePlay.setPlayers(ConvertUtils.toString(document.get("players")));
        gamePlay.setPlayerIds(ConvertUtils.toString(document.get("player_ids")));
        gamePlay.setOwnerId(ConvertUtils.toInt(document.get("owner_id")));
        gamePlay.setBetMoney(ConvertUtils.toLong(document.get("bet_money")));
        gamePlay.setDuration(ConvertUtils.toInt(document.get("duration")));

        String dateGMT7 = getDateGMT7(ConvertUtils.toString(document.get("start_date")));
        gamePlay.setStartDate(dateGMT7);

        // assign playerTurn
        List<PlayerTurn> playerTurn = getPlayerTurn(document);
        gamePlay.setPlayerTurn(playerTurn);
        return gamePlay;
    }

    private String getDateGMT7(String stringDateGMT0) throws ParseException {
        DateFormat dfGMT0 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        dfGMT0.setTimeZone(TimeZone.getTimeZone("GMT+0"));
        Date dateGMT0 = dfGMT0.parse(stringDateGMT0);

        DateFormat dfGMT7 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        dfGMT7.setTimeZone(TimeZone.getTimeZone("GMT+7"));
        return dfGMT7.format(dateGMT0);
    }

    private List<PlayerTurn> getPlayerTurn(Map<String, Object> document) throws DataException {
        // assign playerTurn
        List<PlayerTurn> playerTurn = new ArrayList<PlayerTurn>();
        if (document.get("final_result") == null) {
            return playerTurn; // empty
        }
        String finalResult = (String) document.get("final_result");
        assignResult2Player(finalResult, playerTurn);

        String pTurnString = (String) document.get("player_turn");
        assignCardsResult2Player(pTurnString, playerTurn);

        return playerTurn;
    }

    private void assignCardsResult2Player(String origPlayerTurn, List<PlayerTurn> playerTurn) throws DataException {
        if (!StringUtils.isBlank(origPlayerTurn) && !StringUtils.equals(origPlayerTurn, "-")) {
            JsonParser parser = new JsonParser();
            JsonArray jsonArray = parser.parse(origPlayerTurn).getAsJsonArray();
            for (int index = 0; index < jsonArray.size(); index++) {
                JsonObject jsonObj = (JsonObject) jsonArray.get(index);

                long userId = jsonObj.get("user_id").getAsLong();
                if (jsonObj.get("cards_1st") == null
                        || jsonObj.get("cards_2nd") == null || jsonObj.get("cards_3rd") == null) {
                    continue;
                }

                String cards1st = jsonObj.get("cards_1st").getAsString();
                String cards2nd = jsonObj.get("cards_2nd").getAsString();
                String cards3rd = jsonObj.get("cards_3rd").getAsString();

                PlayerTurn pTurn = getPlayerTurn(userId, playerTurn);
                List<String> cards = getCards(cards1st);
                pTurn.setCards1st(cards);

                cards = getCards(cards2nd);
                pTurn.setCards2nd(cards);

                cards = getCards(cards3rd);
                pTurn.setCards3rd(cards);
            }
        }
    }

    private void assignResult2Player(String origResult, List<PlayerTurn> playerTurn) {
        if (!StringUtils.isBlank(origResult) && !StringUtils.equals(origResult, "-")) {
            JsonParser parser = new JsonParser();
            JsonArray jsonArray = parser.parse(origResult).getAsJsonArray();
            for (int index = 0; index < jsonArray.size(); index++) {
                JsonObject jsonObj = (JsonObject) jsonArray.get(index);
                if (jsonObj.get("user_id") == null
                        || jsonObj.get("total_chi") == null || jsonObj.get("total_money") == null) {
                    continue;
                }

                PlayerTurn pTurn = new PlayerTurn();
                pTurn.setUserId(jsonObj.get("user_id").getAsLong());
                pTurn.setChiTotal(jsonObj.get("total_chi").getAsInt());
                pTurn.setMoneyTransfer(jsonObj.get("total_money").getAsInt());
                playerTurn.add(pTurn);
            }
        }
    }

    private PlayerTurn getPlayerTurn(long userId, List<PlayerTurn> playerTurn) throws DataException {
        for (PlayerTurn pTurn : playerTurn) {
            if (pTurn.getUserId() == userId) {
                return pTurn;
            }
        }

        throw new DataException("not found userId in playerTurn. " + userId);
    }

    public List<String> getCards(String origCards) throws DataException {
        if (StringUtils.isBlank(origCards)) {
            throw new DataException("origCards invalid");
        }

        List<String> cards = new ArrayList<String>();
        String[] cardsSplit = origCards.split(COMMA_DELIMITER);
        for (int i = 0; i < cardsSplit.length; i++) {
            String cardsNumber = DeckCards.DECK_CARDS_MAPPING.get(Integer.parseInt(cardsSplit[i]));
            cards.add(cardsNumber);
        }
        return cards;
    }

}
