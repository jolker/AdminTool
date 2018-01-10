/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bliss.nplay.adminv3.model;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author anhlnt
 */
public class PassingDataUtil {

    private static Map<String, Object> mapData = new HashMap<>();

    public static Map<String, Object> generalPassing() {
        if (mapData.isEmpty()) {
            Map<String, Object> passingData = new HashMap<>();
            passingData.put(Constants.PASSING_ROOT_URL, Constants.ROOT_URL);
            return passingData;
        } else {
            return mapData;
        }
    }
}
