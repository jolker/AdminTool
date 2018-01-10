package com.bliss.nplay.adminv3.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.Map;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.eclipse.jetty.server.Request;

import com.bliss.framework.common.Config;
import com.bliss.nplay.adminv3.utils.SftpUtils;

public class UploadController extends BaseController {
	private static final long serialVersionUID = 1L;
	private static final MultipartConfigElement MULTI_PART_CONFIG = new MultipartConfigElement(
			System.getProperty("java.io.tmpdir"));

	@Override
	protected void handle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getContentType() != null && req.getContentType().startsWith("multipart/form-data")) {
			req.setAttribute(Request.__MULTIPART_CONFIG_ELEMENT, MULTI_PART_CONFIG);
		}
		Part partName = req.getPart("name");
		Part partImage = req.getPart("image");
		SftpUtils sftp = new SftpUtils();
		long getTime= new Date().getTime();
		String pathFileName="scr_"+ getTime+"_" +getValue(partName);
		sftp.uploadFileToFTP(pathFileName, partImage.getInputStream(), true);
		Map<String, Object> respResult = super.getSuccessRespMap();
		respResult.put("pathFile", Config.getParam("upload_server", "path_static_file") + "/" + sftp.getDestinationDir()
				+ "/"+pathFileName);
		super.writeResponse(resp, respResult);
	}

	private static String getValue(Part part) throws IOException {
		BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), "UTF-8"));
		StringBuilder value = new StringBuilder();
		char[] buffer = new char[1024];
		for (int length = 0; (length = reader.read(buffer)) > 0;) {
			value.append(buffer, 0, length);
		}
		return value.toString();
	}

}
