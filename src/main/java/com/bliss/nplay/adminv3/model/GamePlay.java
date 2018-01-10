/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bliss.nplay.adminv3.model;

import com.bliss.core.lib.DataObject;
import java.util.List;

/**
 *
 * @author anhlnt
 */
public class GamePlay extends DataObject {
    private static final long serialVersionUID = 1L;
    
    private String elasticId;

    private int gameId;
    
    private int levelId;
    
    private int roomId;
    
    private int ownerId;
    
    private String playerIds;
    
    private String players;
    
    private long betMoney;
    
    private int duration;
    
    private String startDate;
    
    private List<PlayerTurn> playerTurn;
    
    public String getElasticId() {
		return elasticId;
	}
    
    public void setElasticId(String elasticId) {
		this.elasticId = elasticId;
	}

    public int getGameId() {
        return gameId;
    }

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }

    public int getLevelId() {
        return levelId;
    }

    public void setLevelId(int levelId) {
        this.levelId = levelId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getPlayers() {
        return players;
    }

    public void setPlayers(String players) {
        this.players = players;
    }

    public long getBetMoney() {
        return betMoney;
    }

    public void setBetMoney(long betMoney) {
        this.betMoney = betMoney;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public String getPlayerIds() {
        return playerIds;
    }

    public void setPlayerIds(String playerIds) {
        this.playerIds = playerIds;
    }
    
    public List<PlayerTurn> getPlayerTurn() {
		return playerTurn;
	}
    
    public void setPlayerTurn(List<PlayerTurn> playerTurn) {
		this.playerTurn = playerTurn;
	}

	@Override
	public String toString() {
		return "GamePlay [elasticId=" + elasticId + ", gameId=" + gameId
				+ ", levelId=" + levelId + ", roomId=" + roomId + ", ownerId="
				+ ownerId + ", playerIds=" + playerIds + ", players=" + players
				+ ", betMoney=" + betMoney + ", duration=" + duration
				+ ", startDate=" + startDate + ", playerTurn=" + playerTurn
				+ ", id=" + id + ", dateCreated=" + dateCreated
				+ ", dateUpdated=" + dateUpdated + ", properties=" + properties
				+ "]";
	}

}

