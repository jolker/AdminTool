package com.bliss.nplay.adminv3.payment.controller;

import ga.log4j.GA;

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
import com.bliss.service.paymentv2.thrift.EProductType;
import com.bliss.service.paymentv2.thrift.TInvoiceValue;
import com.bliss.service.paymentv2.thrift.client.TPaymentV2ThriftClient;
import com.nct.game.framework.web.view.freemarker.FreeMarker;

public class InvoiceController extends BaseController {
	private static final long serialVersionUID = 1L;
	// action request
	private static final String REFUND_REQUEST = "refund";
	private static final String RE_PROCESS_REQUEST = "re_process";
	// location page
	private static final String INVOICE_PAGE = "pages/list_invoice";
	private static final String DETAIL_INVOICE_PAGE = "pages/detail_invoice";

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
		case RE_PROCESS_REQUEST:
			doReProcess(req, resp);
			break;
		case REFUND_REQUEST:
			doRefund(req, resp);
			break;
		default:
			doSearch(req, resp);
			break;
		}
	}

	private void doGetId(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getParameter("invoiceId") == null) {
			throw new IOException("invoiceId not yet assign");
		}

		long invoiceId = ConvertUtils.toLong(req.getParameter("invoiceId"));
		TInvoiceValue invoice = paymentv2Service.getInvoice(invoiceId);
		if (invoice.getInvoiceId() == 0) {
			throw new IOException("not found invoiceId: " + invoiceId);
		}

		// response
		Map<String, Object> respMap = super.getSuccessRespMap();
		respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
		respMap.put("invoice", invoice);
		new FreeMarker(DETAIL_INVOICE_PAGE, respMap).render(req, resp);
	}

	private void doSearch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// paramsReq
		Date currentDate = new Date();
		Date fromDate = DateUtils.subtractDays(currentDate, SEVEN_DAYS_AGO);
		Date toDate = currentDate;
		if (req.getParameter("fromDate") != null && !req.getParameter("fromDate").equals("")) {
			fromDate = DateUtils.getDateTime(req.getParameter("fromDate"));
		}
		if (req.getParameter("toDate") != null && !req.getParameter("toDate").equals("")) {
			toDate = DateUtils.getDateTime(req.getParameter("toDate"));
		}
		int pageNumber = ConvertUtils.toInt(req.getParameter("pageNumber"), FIRST_PAGE_REQUEST);

		// filter
		List<TInvoiceValue> invoices = null;
		if (!StringUtils.isBlank(req.getParameter("productType"))) { // filter productType
			EProductType productType = EProductType.valueOf(req.getParameter("productType"));
			invoices = paymentv2Service.listInvoiceByProductType(productType, fromDate.getTime(),
					toDate.getTime(), pageNumber, PAGE_SIZE_REQUEST);
		} else if (!StringUtils.isBlank(req.getParameter("userId"))) { // filter userId
			long userId = Long.valueOf(req.getParameter("userId"));
			invoices = paymentv2Service.listInvoiceByUser(userId, fromDate.getTime(), toDate.getTime(),
					pageNumber, PAGE_SIZE_REQUEST);
		} else { // default filter
			invoices = paymentv2Service.listInvoice(fromDate.getTime(), toDate.getTime(),
					pageNumber, PAGE_SIZE_REQUEST);
		}

		// response
		Map<String, Object> respMap = super.getSuccessRespMap();
		respMap.put("invoices", invoices);
		respMap.put("fromDate", req.getParameter("fromDate"));
		respMap.put("toDate", req.getParameter("toDate"));
		respMap.put("productType", req.getParameter("productType"));
		respMap.put("userId", req.getParameter("userId"));
		respMap.put("pageNumber", pageNumber);
		respMap.put("pageSize", PAGE_SIZE_REQUEST);
		respMap.put("totalPage", TOTAL_PAGE_DEFAULT);
		respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
		new FreeMarker(INVOICE_PAGE, respMap).render(req, resp);
	}

	private void doRefund(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getParameter("invoiceId") == null) {
			throw new IOException("invoiceId not yet assign");
		}
		// update
		long invoiceId = ConvertUtils.toLong(req.getParameter("invoiceId"));
		TInvoiceValue invoice = paymentv2Service.updateRefund(invoiceId);
		if (invoice.getInvoiceId() == 0) {
			throw new IOException("refund invoice failed. invoiceId = " + invoiceId);
		}

		// revision invoice
		UserOps sessionInfo = getSessionInfo(req);
		GA.app.info("userName: " + sessionInfo.getUserName() + " refunded invoiceId: " + invoiceId); 

		// response
		super.writeResponse(resp, super.getSuccessRespMap());
	}

	private void doReProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getParameter("invoiceId") == null) {
			throw new IOException("invoiceId not yet assign");
		}
		// update
		long invoiceId = ConvertUtils.toLong(req.getParameter("invoiceId"));
		TInvoiceValue invoice = paymentv2Service.reProcessInvoice(invoiceId);
		if (invoice.getInvoiceId() == 0) {
			throw new IOException("reprocess invoice failed. invoiceId = " + invoiceId);
		}

		// revision invoice
		UserOps sessionInfo = getSessionInfo(req);
		GA.app.info("userName: " + sessionInfo.getUserName() + " reprocess invoiceId: " + invoiceId); 

		// response
		super.writeResponse(resp, super.getSuccessRespMap());
	}

}
