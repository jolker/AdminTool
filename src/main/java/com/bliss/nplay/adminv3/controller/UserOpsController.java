/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bliss.nplay.adminv3.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bliss.framework.util.ConvertUtils;
import com.bliss.nplay.adminv3.business.UserOpsDA;
import com.bliss.nplay.adminv3.model.UserOps;
import com.nct.game.framework.web.view.freemarker.FreeMarker;

/**
 *
 * @author anhlnt
 */
public class UserOpsController extends BaseController {
	private static final long serialVersionUID = 1L;
	
	private static final String ADD_USER_OPERATORS_PAGE = "pages/add_account";
	private static final String LIST_USER_OPERATORS_PAGE = "pages/luser_operators";
	private static final String DETAIL_USER_OPERATORS_PAGE = "pages/detail_userOperators";

	@Override
	protected void handle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String actionReq = req.getParameter(ACTION_REQUEST) == null ? SEARCH_REQUEST : req.getParameter(ACTION_REQUEST);
		switch (actionReq) {
		case LOAD_ADD_PAGE:
			loadaddPage(req, resp);
			break;
		case ADD_REQUEST:
			doAdd(req, resp);
			break;
		case UPDATE_REQUEST:
			doUpdate(req, resp); 
			break;
		case GET_ID_REQUEST:
			doGetId(req, resp);
			break;
		default:
			doSearch(req, resp);
			break;
		}
	}

	private void doGetId(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		if (req.getParameter("userName") == null) {
			throw new IOException("userName not yet assign");
		}

		String userName = req.getParameter("userName");
		UserOps userOps = UserOpsDA.find(userName);
		if (userOps.getId() == 0) {
			throw new IOException("not found userName: " + userName);
		}

		// response
		Map<String, Object> respMap = super.getSuccessRespMap();
		respMap.put("userOps", userOps);
		respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
		new FreeMarker(DETAIL_USER_OPERATORS_PAGE, respMap).render(req, resp);
	}

	private void doUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserOps account = new UserOps();
		addParamsReq2Account(req, account);
		boolean result = UserOpsDA.update(account);
		if (!result) {
			throw new IOException("update account failed");
		}
		// response
		super.writeResponse(resp, super.getSuccessRespMap());
	}

	private void doSearch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int pageNumber = ConvertUtils.toInt(req.getParameter("pageNumber"), FIRST_PAGE_REQUEST);
		List<UserOps> userOpsList = UserOpsDA.find((short)pageNumber, (short)PAGE_SIZE_REQUEST);
		// response
		Map<String, Object> respMap = super.getSuccessRespMap();
		respMap.put("userOpsList", userOpsList);
		respMap.put("pageNumber", pageNumber);
		respMap.put("pageSize", PAGE_SIZE_REQUEST);
		respMap.put("totalPage", TOTAL_PAGE_DEFAULT);
		respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
		new FreeMarker(LIST_USER_OPERATORS_PAGE, respMap).render(req, resp);
	}

	private void loadaddPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> respMap = super.getSuccessRespMap();
		respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
		new FreeMarker(ADD_USER_OPERATORS_PAGE, respMap).render(req, resp);
	}

	private void addParamsReq2Account(HttpServletRequest req, UserOps account) throws IOException {
		account.setUserName(req.getParameter("user_name"));
		account.setPassWord(req.getParameter("password"));
		account.setRole(UserOps.Role.valueOf(req.getParameter("role")));
		account.setStatus(UserOps.Status.valueOf(req.getParameter("status")));
	}

	private void doAdd(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		UserOps account = new UserOps();
		addParamsReq2Account(req, account);
		int result = UserOpsDA.add(account);
		if (result == -1) {
			throw new IOException("add account failed. account = " + account);
		}
		// response
		super.writeResponse(resp, super.getSuccessRespMap());
	}

}
