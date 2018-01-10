package com.bliss.nplay.adminv3.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ErrorController extends BaseController {
    private static final long serialVersionUID = 1L;

    @Override
    protected void handle(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Throwable cause = (Throwable) req.getAttribute(RequestDispatcher.ERROR_EXCEPTION);
        if (cause == null) {
            cause = new RuntimeException("unknown error");
        }
        Map<String, Object> mapObj = new HashMap<String, Object>();
        mapObj.put(STATUS_RESPONSE, STATUS_ERROR);
        mapObj.put(MESSAGE_RESPONSE, cause.getMessage());
        // default status = 200
        res.setStatus(200);
        super.writeResponse(res, mapObj);
    }

}
