/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bliss.nplay.adminv3.model;

import com.bliss.core.lib.DataFilter;

/**
 *
 * @author anhlnt
 */
public class GamePlayFilter extends DataFilter {

    private static final long serialVersionUID = 1L;

    private String elasticId;
    private int gameId;
    private String userIds;
    private String userName;
    private int ownerId;
    private int levelId;
    private int numberUser;
    private int fromMoney;
    private int toMoney;
    private int roomId;
    private int specialType;
    private String fromDate;
    private String toDate;
    private String deviceID;
    private String ip;

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

    public String getUserIds() {
        return userIds;
    }

    public void setUserIds(String userIds) {
        this.userIds = userIds;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public int getLevelId() {
        return levelId;
    }

    public void setLevelId(int levelId) {
        this.levelId = levelId;
    }

    public int getNumberUser() {
        return numberUser;
    }

    public void setNumberUser(int numberUser) {
        this.numberUser = numberUser;
    }

    public int getFromMoney() {
        return fromMoney;
    }

    public void setFromMoney(int fromMoney) {
        this.fromMoney = fromMoney;
    }

    public int getToMoney() {
        return toMoney;
    }

    public void setToMoney(int toMoney) {
        this.toMoney = toMoney;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getSpecialType() {
        return specialType;
    }

    public void setSpecialType(int specialType) {
        this.specialType = specialType;
    }

    public String getFromDate() {
        return fromDate;
    }

    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    public String getToDate() {
        return toDate;
    }

    public void setToDate(String toDate) {
        this.toDate = toDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getDeviceID() {
        return deviceID;
    }

    public void setDeviceID(String deviceID) {
        this.deviceID = deviceID;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    @Override
    public String toString() {
        return "GamePlayFilter [elasticId=" + elasticId + ", gameId=" + gameId
                + ", userIds=" + userIds + ", ownerId=" + ownerId
                + ", levelId=" + levelId + ", numberUser=" + numberUser
                + ", fromMoney=" + fromMoney + ", toMoney=" + toMoney
                + ", roomId=" + roomId + ", specialType=" + specialType
                + ", fromDate=" + fromDate + ", toDate=" + toDate 
                + ", deviceID=" + deviceID + ", ip=" + ip + ", id="
                + id + ", properties=" + properties + ", forUpdate="
                + forUpdate + ", orderBy=" + orderBy + ", asc=" + asc
                + ", pageNumber=" + pageNumber + ", pageSize=" + pageSize + "]";
    }

}
