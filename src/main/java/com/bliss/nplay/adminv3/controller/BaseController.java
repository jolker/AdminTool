package com.bliss.nplay.adminv3.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bliss.nplay.adminv3.model.UserOps;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public abstract class BaseController extends HttpServlet implements HttpConstants {
	private static final long serialVersionUID = 1L;

	protected final Gson GSON = buildGSON();

	protected Gson buildGSON() {
		GsonBuilder builder = new GsonBuilder();
		return builder.create();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		handle(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		handle(req, resp);
	}

	protected abstract void handle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;

	protected Map<String, Object> getSuccessRespMap() {
		Map<String, Object> respMap = new HashMap<String, Object>();
		respMap.put(BASE_URL_KEY, BASE_URL_VALUE);
		respMap.put(STATUS_RESPONSE, STATUS_SUCCESSFULLY);
		respMap.put(MESSAGE_RESPONSE, STATUS_SUCCESSFULLY);
		return respMap;
	}

	protected void writeResponse(HttpServletResponse resp, Object obj) throws IOException {
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		String json = GSON.toJson(obj);
		resp.getWriter().append(json);
	}

	protected UserOps getSessionInfo(HttpServletRequest req) throws IOException {
		HttpSession httpSession = req.getSession();
		if (httpSession.getAttribute(HttpConstants.SESSION_INFO) == null)
			return null;
		return (UserOps)httpSession.getAttribute(HttpConstants.SESSION_INFO);
	}

}
