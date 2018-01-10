/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bliss.nplay.adminv3.logger.controller;

import com.bliss.core.lib.PageView;
import com.bliss.core.lib.utils.DateUtils;
import com.bliss.nplay.adminv3.controller.BaseController;
import com.bliss.nplay.adminv3.elasticsearch.GamePlayFilterElastic;
import com.bliss.nplay.adminv3.model.Constants;
import com.bliss.nplay.adminv3.model.GamePlay;
import com.bliss.nplay.adminv3.model.GamePlayFilter;
import com.bliss.nplay.adminv3.model.PassingDataUtil;
import com.bliss.framework.common.Config;
import com.bliss.framework.util.ConvertUtils;
import com.nct.game.framework.web.view.freemarker.FreeMarker;
import ga.log4j.GA;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;

/**
 *
 * @author anhlnt
 */
public class GamePlayController extends BaseController {

    private static final long serialVersionUID = 1L;
    private final int PAGE_SIZE = ConvertUtils.toInt(Config.getParam("bliss_service", "page_size"));
    private final int TIME_INTERVAL = ConvertUtils.toInt(Config.getParam("bliss_service", "time_interval"));

    @Override
    protected void handle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            Map<String, Object> data = new HashMap<>();
            data.putAll(PassingDataUtil.generalPassing());

//            String admin = (String) req.getSession().getAttribute(Constants.SESSION_USER);
//            if (admin == null) {
//                super.showLoginPage(req, resp, data, Constants.LOGIN_REQUIRED);
//                return;
//            }

            String action = req.getParameter(Constants.ACTION);
            switch (StringUtils.isBlank(action) ? Constants.DEFAULT_VALUE : action) {
                case Constants.DEFAULT_VALUE:
                    initPage(data, req, resp);
                    break;
                case Constants.ACTION_SEARCH:
                    searchPage(data, req, resp);
                    break;
            }

        } catch (Exception ex) {
            GA.app.error("LogCardGameController error: " + ex.getMessage());
        }
    }

    private void initPage(Map<String, Object> data, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        data.put("time_interval", TIME_INTERVAL);
        data.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
        new FreeMarker(Constants.PAGE_LOG_CARD_GAME, data).render(req, resp);

    }

    private void searchPage(Map<String, Object> data, HttpServletRequest req, HttpServletResponse resp) {

        try {
            String userIds = ConvertUtils.toString(req.getParameter("user_ids"), "");
            String userName = ConvertUtils.toString(req.getParameter("user_name"), "");
            int ownerId = ConvertUtils.toInt(req.getParameter("owner_id"), -1);
            int gameId = ConvertUtils.toInt(req.getParameter("game_id"), -1);
            int levelId = ConvertUtils.toInt(req.getParameter("level_id"), -1);
            int numberUser = ConvertUtils.toInt(req.getParameter("number_user"), -1);
            int fromMoney = ConvertUtils.toInt(req.getParameter("from_money"), -1);
            int toMoney = ConvertUtils.toInt(req.getParameter("to_money"), -1);
            int roomId = ConvertUtils.toInt(req.getParameter("room_id"), -1);
            int specialType = ConvertUtils.toInt(req.getParameter("special_type"), -1);
            String fromDate = ConvertUtils.toString(req.getParameter("from_date"), "");
            String toDate = ConvertUtils.toString(req.getParameter("to_date"), "");
            String deviceId = ConvertUtils.toString(req.getParameter("device_id"), "");
            String ip = ConvertUtils.toString(req.getParameter("ip"), "");
            int pageNumber = ConvertUtils.toInt(req.getParameter("page"), 1);

            data.put("userIds", userIds);
            data.put("userName", userName);
            data.put("ownerId", ownerId);
            data.put("gameId", gameId);
            data.put("levelId", levelId);
            data.put("numberUser", numberUser);
            data.put("fromMoney", fromMoney);
            data.put("toMoney", toMoney);
            data.put("roomId", roomId);
            data.put("specialType", specialType);
            data.put("fromDate", fromDate);
            data.put("toDate", toDate);
            data.put("deviceId", deviceId);
            data.put("ip", ip);
            data.put("time_interval", TIME_INTERVAL);

            GA.app.info("front-end data: " + data);

            GamePlayFilter filter = new GamePlayFilter();
            filter.setUserIds(userIds);
            filter.setUserName(userName);
            filter.setGameId(gameId);
            filter.setOwnerId(ownerId);
            filter.setLevelId(levelId);
            filter.setNumberUser(numberUser);
            filter.setFromMoney(fromMoney);
            filter.setToMoney(toMoney);
            filter.setRoomId(roomId);
            filter.setSpecialType(specialType);
            filter.setDeviceID(deviceId);
            filter.setIp(ip);
            if (!fromDate.equals("")) {
                filter.setValue("fromStartDate", DateUtils.getDateTime(fromDate));
            }
            if (!toDate.equals("")) {
                filter.setValue("toStartDate", DateUtils.getDateTime(toDate));
            }
            filter.setPageNumber(pageNumber);
            filter.setPageSize(PAGE_SIZE);

            GA.app.info("filter: " + filter.toString());

            PageView<GamePlay> pv = GamePlayFilterElastic.getInstance().search(filter);

            if (pv.getItems().size() > 0 || pv.getItems() != null) {
                data.put("total_data", pv.getTotalItems());
                data.put("page_size", pv.getItems().size());
                data.put("list_data", pv.getItems());
            }

            data.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
            new FreeMarker(Constants.PAGE_LOG_CARD_GAME, data).render(req, resp);
        } catch (Exception e) {
            GA.app.error("GamePlayController error: " + e.getMessage());
        }

    }

}
