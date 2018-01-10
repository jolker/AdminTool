package com.bliss.nplay.adminv3.launcher;

import ga.log4j.GA;

import java.io.File;

import com.bliss.nplay.adminv3.controller.ServletContextController;

public class Console {
	
	private static final String PID_FILE_NAME = "pidfile";

	public static void main(String[] args) {
		try {
			ServletContextController webserver = new ServletContextController();
			String pidFile = System.getProperty(PID_FILE_NAME);
			if (pidFile != null) 
				new File(pidFile).deleteOnExit();
			
			GA.app.info("THE SERVICE IS STARTTING ...");
			
			webserver.start();
			
			GA.app.info(" THE SERVICE STATE: " + webserver.getState());
			
			webserver.join();

		} catch (Exception e) {
			GA.app.error("THE SERVICE START FAILED. " + e.getMessage(), e);
			System.exit(1);
		}
	}

}
