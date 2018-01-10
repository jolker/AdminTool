package com.bliss.nplay.adminv3.controller;

import ga.log4j.GA;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.StringUtils;

import com.bliss.nplay.adminv3.model.UserOps;
import com.bliss.nplay.adminv3.model.UserOps.Status;

public class AuthorizationFilter extends BaseController implements Filter {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void handle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub	
	}

	@Override
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub	
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		UserOps sessionInfo = getSessionInfo(httpRequest);
		if (sessionInfo == null) {
			httpResponse.sendRedirect("/authentication");
			return;
		}
		// TODO: implement ERROR-403 page
		if (!StringUtils.equals(sessionInfo.getStatus().name(), Status.ACTIVED.name())) {
			httpResponse.sendRedirect("/error-403");
			return;
		}

		chain.doFilter(request, response);

		String requestURI = httpRequest.getRequestURI();
		GA.app.info("requested resource: " + requestURI);
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub	
	}
	
}
