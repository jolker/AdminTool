/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bliss.nplay.adminv3.payment.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.bliss.framework.util.ConvertUtils;
import com.bliss.nplay.adminv3.controller.BaseController;
import com.bliss.nplay.adminv3.model.UserOps;
import com.bliss.nplay.adminv3.utils.DateUtils;
import com.bliss.service.paymentv2.thrift.EStatus;
import com.bliss.service.paymentv2.thrift.TPromotionValue;
import com.bliss.service.paymentv2.thrift.client.TPaymentV2ThriftClient;
import com.bliss.service.thrift.EEventUserGroup;
import com.bliss.service.thrift.OpAuth;
import com.nct.game.framework.web.view.freemarker.FreeMarker;

/**
 *
 * @author anhlnt
 */
public class PromotionController extends BaseController {
	private static final long serialVersionUID = 1L;

	private static final String PROMOTION_PAGE = "pages/list_promotion";
	private static final String ADD_PROMOTION_PAGE = "pages/add_promotion";
	private static final String DETAIL_PROMOTION_PAGE = "pages/detail_promotion";

	private TPaymentV2ThriftClient paymentv2Service = TPaymentV2ThriftClient.getInstance("thrift_paymentv2_client");

	@Override
	protected void handle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String actionReq = req.getParameter(ACTION_REQUEST) == null ? SEARCH_REQUEST : req.getParameter(ACTION_REQUEST);
		switch (actionReq) {
		case GET_ID_REQUEST:
			doGetId(req, resp);
			break;
		case SEARCH_REQUEST:
			doSearch(req, resp);
			break;
		case ADD_REQUEST:
			doAdd(req, resp);
			break;
		case LOAD_ADD_PAGE:
			loadaddPage(req, resp);
			break;
		case UPDATE_REQUEST:
			doUpdate(req, resp);
			break;
		default:
			doSearch(req, resp);
			break;
		}
	}

	private void loadaddPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// result
		Map<String, Object> respMap = super.getSuccessRespMap();
                respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
		new FreeMarker(ADD_PROMOTION_PAGE, respMap).render(req, resp);
	}

	private void doGetId(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getParameter("promotionId") == null) {
			throw new IOException("promotionId not yet assign");
		}

		int promotionId = ConvertUtils.toInt(req.getParameter("promotionId"));
		TPromotionValue promotion = paymentv2Service.getPromotion(promotionId);
		if (promotion.getPromotionId() == 0) {
			throw new IOException("not found promotionId: " + promotionId);
		}

		// response
		Map<String, Object> respMap = super.getSuccessRespMap();
                respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
		respMap.put("promotion", promotion);
		new FreeMarker(DETAIL_PROMOTION_PAGE, respMap).render(req, resp);
	}

	private void doSearch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// paramsReq
		Date currentDate = new Date();
		Date fromDate = DateUtils.subtractDays(currentDate, SEVEN_DAYS_AGO);
		Date toDate = currentDate;
		if (!StringUtils.isBlank(req.getParameter("fromDate"))) {
			fromDate = DateUtils.getDateTime(req.getParameter("fromDate"));
		}
		if (!StringUtils.isBlank(req.getParameter("toDate"))) {
			toDate = DateUtils.getDateTime(req.getParameter("toDate"));
		}
		int pageNumber = ConvertUtils.toInt(req.getParameter("pageNumber"), FIRST_PAGE_REQUEST);

		// search
		List<TPromotionValue> promotions = paymentv2Service.listPromotion(fromDate.getTime(),
				toDate.getTime(), pageNumber, PAGE_SIZE_REQUEST);

		// response
		Map<String, Object> respMap = super.getSuccessRespMap();
		respMap.put("promotions", promotions);
		respMap.put("fromDate", req.getParameter("fromDate"));
		respMap.put("toDate", req.getParameter("toDate"));
		respMap.put("pageNumber", pageNumber);
		respMap.put("pageSize", PAGE_SIZE_REQUEST);
		respMap.put("totalPage", TOTAL_PAGE_DEFAULT);
                respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
		new FreeMarker(PROMOTION_PAGE, respMap).render(req, resp);
	}

	private void addParamsReq2Promotion(HttpServletRequest req, TPromotionValue promotion) throws IOException {
		promotion.setPromotionRateData(req.getParameter("rate_data")); // TODO: validation
		promotion.setPromotionUserGroup(EEventUserGroup.valueOf(req.getParameter("user_group")));
		promotion.setPromotionName(req.getParameter("name"));
		promotion.setPriority(Integer.parseInt(req.getParameter("priority")));
		promotion.setDescription(req.getParameter("description"));
		promotion.setStatus(EStatus.valueOf(req.getParameter("status")));
		promotion.setDateBegin(DateUtils.getDateTime(req.getParameter("date_begin")).getTime());
		promotion.setDateEnd(DateUtils.getDateTime(req.getParameter("date_end")).getTime());	
	}

	private void doAdd(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		OpAuth auth = new OpAuth();
		
		TPromotionValue promotion = new TPromotionValue();
		addParamsReq2Promotion(req, promotion);
		UserOps sessionInfo = getSessionInfo(req);
		promotion.setUserCreated(sessionInfo.getUserName());

		promotion = paymentv2Service.addPromotion(auth, promotion);
		if (promotion.getPromotionId() == 0) {
			throw new IOException("add promotion failed. promotion = " + promotion);
		}
		// response
		super.writeResponse(resp, super.getSuccessRespMap());
	}

	private void doUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getParameter("promotionId") == null) {
			throw new IOException("promotionId not yet assign");
		}
		// update
		OpAuth auth = new OpAuth();
		TPromotionValue promotion = new TPromotionValue();
		UserOps sessionInfo = getSessionInfo(req);
		promotion.setUserModified(sessionInfo.getUserName());
		promotion.setPromotionId(Integer.parseInt(req.getParameter("promotionId")));
		addParamsReq2Promotion(req, promotion);

		boolean result = paymentv2Service.updatePromotion(auth, promotion);
		if (!result) {
			throw new IOException("update promotion failed. promotionId = " + promotion.getPromotionId());
		}
		// response
		super.writeResponse(resp, super.getSuccessRespMap());
	}

}
