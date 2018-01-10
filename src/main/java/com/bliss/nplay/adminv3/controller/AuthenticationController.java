package com.bliss.nplay.adminv3.controller;

import ga.log4j.GA;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.SerializationUtils;
import org.apache.commons.lang3.StringUtils;

import com.bliss.nplay.adminv3.business.UserOpsDA;
import com.bliss.nplay.adminv3.model.UserOps;
import com.nct.game.framework.web.view.freemarker.FreeMarker;

public class AuthenticationController extends BaseController {
	private static final long serialVersionUID = 1L;

	private static final String PASSING_USERNAME = "username";
	private static final String PASSING_PASSWORD = "password";

	private static final String LOGIN_PAGE = "pages/login";

	private static final int SESSION_EXPIRE_INTERVAL = 12000;

	@Override
	protected void handle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String actionReq = req.getParameter(ACTION_REQUEST) == null ? SEARCH_REQUEST : req.getParameter(ACTION_REQUEST);
		switch (actionReq) {
		case LOGIN_REQUEST:
			doLogin(req, resp);
			break;
		case LOGOUT_REQUEST:
			doLogout(req, resp);
			break;
		default:
			doLogin(req, resp);
			break;
		}
	}

	private void doLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userName = req.getParameter(PASSING_USERNAME);
		String password = req.getParameter(PASSING_PASSWORD);
		Map<String, Object> respMap = super.getSuccessRespMap();
		if (StringUtils.isBlank(userName) && StringUtils.isBlank(password)) {
			new FreeMarker(LOGIN_PAGE, respMap).render(req, resp);
			return;
		}
		
		UserOps userOps = UserOpsDA.find(userName, password);
		if (userOps.getId() == 0) { // account not found
			respMap.put(STATUS_RESPONSE, STATUS_ERROR);
			respMap.put(MESSAGE_RESPONSE, "userName or password invalid");
			new FreeMarker(LOGIN_PAGE, respMap).render(req, resp);
			return;
		}

		// assign sessionInfo
		UserOps sessionInfo = SerializationUtils.clone(userOps);
		sessionInfo.setPassWord(null);

		GA.app.info("sessionInfo: " + sessionInfo);

		HttpSession currentSession = req.getSession();
		currentSession.setAttribute(SESSION_INFO, sessionInfo);
		currentSession.setMaxInactiveInterval(SESSION_EXPIRE_INTERVAL);

		// redirect			    
		resp.sendRedirect("/home");		
	}

	private void doLogout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession currentSession = req.getSession();
		currentSession.setAttribute(SESSION_INFO, null);
		currentSession.invalidate();

		Map<String, Object> respMap = super.getSuccessRespMap();
		new FreeMarker(LOGIN_PAGE, respMap).render(req, resp);
	}
}
