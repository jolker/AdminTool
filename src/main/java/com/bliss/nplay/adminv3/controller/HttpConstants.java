package com.bliss.nplay.adminv3.controller;

import com.bliss.framework.common.Config;

public interface HttpConstants {

	public static final String BASE_URL_KEY = "root_url";
	public static final String BASE_URL_VALUE = Config.getParam("jetty", "root_url");
	
	public static final String SESSION_INFO = "sessionInfo";

	public static final String ACTION_REQUEST = "action";
	public static final String LOGIN_REQUEST = "login";
	public static final String LOGOUT_REQUEST = "logout";
	public static final String ADD_REQUEST = "add";
	public static final String UPDATE_REQUEST = "update";
	public static final String GET_ID_REQUEST = "getId";
	public static final String SEARCH_REQUEST = "search";
	public static final String LOAD_ADD_PAGE = "add_page";

	public static final int SEVEN_DAYS_AGO = 7;
	public static final int FIRST_PAGE_REQUEST = 1;
	public static final int PAGE_SIZE_REQUEST = 10;
	public static final int TOTAL_PAGE_DEFAULT = 200;

	public static final String STATUS_RESPONSE = "code";
	public static final int STATUS_SUCCESSFULLY = 0;
	public static final int STATUS_ERROR = 1;
	public static final String MESSAGE_RESPONSE = "message";
	public static final String MESSAGE_RESPONSE_SUCCESSFULLY = "Successfully";

}
