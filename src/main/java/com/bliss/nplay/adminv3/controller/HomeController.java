package com.bliss.nplay.adminv3.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nct.game.framework.web.view.freemarker.FreeMarker;

public class HomeController extends BaseController {
	private static final long serialVersionUID = 1L;

	private static final String HOME_PAGE = "pages/home";

	@Override
	protected void handle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> respMap = super.getSuccessRespMap();
                respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
		new FreeMarker(HOME_PAGE, respMap).render(req, resp);
	}

}
