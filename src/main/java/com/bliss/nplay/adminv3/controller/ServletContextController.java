package com.bliss.nplay.adminv3.controller;

import java.util.EnumSet;

import javax.servlet.DispatcherType;

import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.ServerConnector;
import org.eclipse.jetty.server.handler.HandlerList;
import org.eclipse.jetty.server.handler.ResourceHandler;
import org.eclipse.jetty.servlet.ErrorPageErrorHandler;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.util.thread.QueuedThreadPool;

import com.bliss.framework.common.Config;
import com.bliss.framework.util.ConvertUtils;
import com.bliss.nplay.adminv3.event.controller.EventController;
import com.bliss.nplay.adminv3.logger.controller.DetailGamePlayController;
import com.bliss.nplay.adminv3.logger.controller.GamePlayController;
import com.bliss.nplay.adminv3.payment.controller.InvoiceController;
import com.bliss.nplay.adminv3.payment.controller.PromotionController;
import com.bliss.nplay.adminv3.payment.controller.SpecialDealController;

public class ServletContextController {

	private Server server;
	private ServletContextHandler servletContextHandler;

	public ServletContextController() {
		initialize();
	}

	private void initialize() {
		this.servletContextHandler = new ServletContextHandler(ServletContextHandler.SESSIONS);
		QueuedThreadPool threadPool = new QueuedThreadPool();
		threadPool.setMaxThreads(ConvertUtils.toInt(Config.getParam("jetty", "max_thread"), 10));
		threadPool.setMinThreads(ConvertUtils.toInt(Config.getParam("jetty", "min_thread"), 200));
		this.server = new Server(threadPool);

		this.servletContextHandler.getSessionHandler().getSessionManager().setMaxInactiveInterval(
				ConvertUtils.toInt(Config.getParam("jetty", "session_timeout"), 60000));
		this.servletContextHandler.setContextPath(ConvertUtils.toString(Config.getParam("jetty", "context_path"), "/"));

		assignController();

		assignAuthentication();

		assignErrorHandler();

		HandlerList handlers = new HandlerList();
		handlers.addHandler(getResourceBase());
		handlers.addHandler(this.servletContextHandler);

		this.server.setConnectors(new Connector[]{getServerConnector()});
		this.server.setHandler(handlers);
		this.server.setStopAtShutdown(true);
	}

	private void assignController() {
		// authentication
		this.servletContextHandler.addServlet(AuthenticationController.class, "/authentication");
		// home
		this.servletContextHandler.addServlet(HomeController.class, "/home");
		// eventv3
		this.servletContextHandler.addServlet(EventController.class, "/eventv3");
		// paymentv3
		this.servletContextHandler.addServlet(InvoiceController.class, "/payment/invoice");
		this.servletContextHandler.addServlet(PromotionController.class, "/payment/promotion");
		this.servletContextHandler.addServlet(SpecialDealController.class, "/payment/special-deal");
		// user-operators 
		this.servletContextHandler.addServlet(UserOpsController.class, "/user-operators");
                // card-game
                this.servletContextHandler.addServlet(GamePlayController.class, "/log_card_game");
                this.servletContextHandler.addServlet(DetailGamePlayController.class, "/detail_card_game");
		// error
		this.servletContextHandler.addServlet(ErrorController.class, "/error");
		
		//upload file
		this.servletContextHandler.addServlet(UploadController.class, "/upload");
		
		
	}

	private void assignAuthentication() {
		// home
		this.servletContextHandler.addFilter(AuthorizationFilter.class, "/home", EnumSet.of(
				DispatcherType.REQUEST, DispatcherType.ASYNC));
		// eventv3
		this.servletContextHandler.addFilter(AuthorizationFilter.class, "/eventv3", EnumSet.of(
				DispatcherType.REQUEST, DispatcherType.ASYNC));
		// paymentv3
		this.servletContextHandler.addFilter(AuthorizationFilter.class, 
				"/payment/invoice", EnumSet.of(DispatcherType.REQUEST, DispatcherType.ASYNC));
		this.servletContextHandler.addFilter(AuthorizationFilter.class, 
				"/payment/promotion", EnumSet.of(DispatcherType.REQUEST, DispatcherType.ASYNC));
		this.servletContextHandler.addFilter(AuthorizationFilter.class, 
				"/payment/special-deal", EnumSet.of(DispatcherType.REQUEST, DispatcherType.ASYNC));
		// user-operators 
		this.servletContextHandler.addFilter(AuthorizationFilter.class, 
				"/user-operators", EnumSet.of(DispatcherType.REQUEST, DispatcherType.ASYNC));
                // card-game
		this.servletContextHandler.addFilter(AuthorizationFilter.class, 
				"/log_card_game", EnumSet.of(DispatcherType.REQUEST, DispatcherType.ASYNC));
                this.servletContextHandler.addFilter(AuthorizationFilter.class, 
				"/detail_card_game", EnumSet.of(DispatcherType.REQUEST, DispatcherType.ASYNC));
	}

	private ResourceHandler getResourceBase() {
		// TODO: ignore login page to development business
		ResourceHandler resourceHandler = new ResourceHandler();
		resourceHandler.setWelcomeFiles(new String[]{"login.html"});
		resourceHandler.setDirectoriesListed(false);
		String resouces = ConvertUtils.toString(Config.getParam("jetty", "resource_base"), ".");
		resourceHandler.setResourceBase(resouces);
		return resourceHandler;
	}

	private void assignErrorHandler() {	
		ErrorPageErrorHandler errorHandler = new ErrorPageErrorHandler();
		errorHandler.setShowMessageInTitle(false);
		errorHandler.addErrorPage("java.lang.Exception", "/error");
		this.servletContextHandler.setErrorHandler(errorHandler);
	}

	private ServerConnector getServerConnector() {
		ServerConnector connector = new ServerConnector(this.server);      
		connector.setHost(Config.getParam("jetty", "host"));
		connector.setPort(ConvertUtils.toInt(Config.getParam("jetty", "port"), 80));
		connector.setIdleTimeout(ConvertUtils.toInt(Config.getParam("jetty", "idle"), 5) * 1000);
		return connector;
	}

	public void start() throws Exception {
		this.server.start();
	}

	public void join() throws InterruptedException {
		this.server.join();
	}

	public void shutdown() throws Exception {
		if (server != null && server.isStarted())
			server.stop();
	}

	public String getState() {
		return server.getState();
	}

}
