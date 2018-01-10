/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bliss.nplay.adminv3.logger.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.bliss.framework.util.ConvertUtils;
import com.bliss.nplay.adminv3.controller.BaseController;
import com.bliss.nplay.adminv3.elasticsearch.GamePlayFilterElastic;
import com.bliss.nplay.adminv3.model.Constants;
import com.bliss.nplay.adminv3.model.GamePlay;
import com.bliss.nplay.adminv3.model.PassingDataUtil;
import com.google.gson.JsonObject;
import com.nct.game.framework.web.view.freemarker.FreeMarker;

import ga.log4j.GA;
import vn.nct.cardgame.profile.thrift.TProfile;
import vn.nct.cardgame.profile.thriftclient.TProfileClient;

/**
 *
 * @author anhlnt
 */
public class DetailGamePlayController extends BaseController {

    private static final long serialVersionUID = 1L;
    private static final String PASSING_RESULT = "result";

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
                case Constants.ACTION_GET_INFO:
                    getUserInfoById(req, resp);
                    break;
            }

        } catch (Exception ex) {
            GA.app.error("DetailGamePlayController error: " + ex.getMessage());
        }
    }

    private void initPage(Map<String, Object> data, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            String elasticId = ConvertUtils.toString(req.getParameter("ela_id"), "");
            GamePlay objGamePlay = GamePlayFilterElastic.getInstance().get(elasticId);

            data.put("game_play", objGamePlay);

        } catch (Exception e) {
            data.put("error", "Không thể tìm thấy thông tin");
            GA.app.error("DetailGamePlayController error: " + e.getMessage());
        }

        data.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
        new FreeMarker(Constants.PAGE_DETAIL_CARD_GAME, data).render(req, resp);

    }

    private void getUserInfoById(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType(Constants.CONTENT_TYPE_JSON);
        try (PrintWriter out = resp.getWriter()) {
            JsonObject obj = new JsonObject();
            try {
                int userId = ConvertUtils.toInt(req.getParameter("user_id"), 0);

                TProfile profile = TProfileClient.getInstance("thrift_profile_server").getByUserId(userId, true);

                obj.addProperty(PASSING_RESULT, false);
                if (profile != null) {
                    obj.addProperty(PASSING_RESULT, true);
                    obj.addProperty("displayName", profile.displayName);
                    obj.addProperty("lastLogin", profile.lastLogin);
                    obj.addProperty("userId", profile.userId);
                    obj.addProperty("money", profile.money);
                    obj.addProperty("avata", profile.avatarPath);
                    obj.addProperty("status", profile.status);
                }

            } catch (Exception ex) {
                obj.addProperty(PASSING_RESULT, ex.getMessage());
                GA.app.error(DetailGamePlayController.class.getName() + " - " + ex.getMessage(), ex);
            } finally {
                if (out != null) {
                    out.print(obj);
                    out.flush();
                }
            }
        }
    }
}
