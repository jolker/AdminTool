/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bliss.nplay.adminv3.model;
import com.bliss.framework.common.Config;
import com.bliss.framework.util.ConvertUtils;

/**
 *
 * @author anhlnt
 */
public class Constants {

    public static final String BLISS_SERVICE_DOMAIN = ConvertUtils.toString(Config.getParam("bliss_service", "domain"), "https://api.nivi.vn");

    public static final String PAGE_SIZE = ConvertUtils.toString(Config.getParam("bliss_service", "page_size"));
    public static final String ADMIN = ConvertUtils.toString(Config.getParam("bliss_service", "admin"));
    public static final String PASSWORD = ConvertUtils.toString(Config.getParam("bliss_service", "password"));

    public static final String SLACK_URL = Config.getParam("web", "slack_url");
    public static final String ROOT_URL = ConvertUtils.toString(Config.getParam("jetty", "root_url"), "http://console.nivi.vn/");
    public static final String RESOURCE_PATH = Config.getParam("jetty", "resource_path");

    public static final String CONTEXT_PATH = ConvertUtils.toString(Config.getParam("jetty", "context_path"), "");
    public static final String CURRENT_DIR = new java.io.File(".").getAbsolutePath() + "/";

    public static final String DATE_FORMAT = "dd/MM/yyyy";
    public static final String TIME_FORMAT = "hh:mm:ss";
    public static final String DATETIME_FORMAT_DB = "yyyy-MM-dd";
    public static final String DATETIME_FORMAT_FOLDER = "yyyyMMdd";

    public static final String DATETIME_FORMAT_REPORT = "d/M";

    public static final String DATETIME_FORMAT_COPYRIGHT = "yyyy-MM-dd HH:mm";

    public static final String DATETIME_FORMAT_GAME = "yyyy-MM-dd hh:mm:ss";

    public static final String HOST = Config.getParam("web", "host");
    public static final int PORT = ConvertUtils.toInt(Config.getParam("web", "port"));
    public static final int MAX_THREADS = ConvertUtils.toInt(Config.getParam("web", "max_threads"));
    public static final int MIN_THREADS = ConvertUtils.toInt(Config.getParam("web", "min_threads"), 10);

    public static final String PAGE_HOME = "pages/homePage";
    public static final String PAGE_LOGIN = "pages/loginPage";
    public static final String PAGE_LOG_CARD_GAME = "pages/logCardGamePage";
    public static final String PAGE_DETAIL_CARD_GAME = "pages/detailCardGamePage";

    public static final String CONTENT_TYPE_JSON = "application/json; charset=UTF-8";
    public static final String CONTENT_TYPE_TEXT = "text/html; charset=UTF-8";

    public static final String PASSING_ROOT_URL = "root_url";

    public static final String PATH_TEMPLATE = Config.getParam("web_view_freemarker", "template_path");
    public static final String URL_LOGIN = "/login";

    public static final String ACTION = "action";

    public static final String ACTION_SEARCH = "search";
    public static final String TAB = "tab";
    public static final String DEFAULT_VALUE = "";
    public static final String ACTION_GET_INFO = "get_user_info";

    public static final String PASSING_MESSAGE_FROM_SERVER = "messageFromServer";

    public static final int SHOW = 1, NOT_SHOW = 0;
    public static final String SESSION_USER = "user";

    public static final String LOGIN_REQUIRED = "You must login first so you can use this function";

}
