package com.bliss.nplay.adminv3.payment.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bliss.framework.util.ConvertUtils;
import com.bliss.nplay.adminv3.controller.BaseController;
import com.bliss.nplay.adminv3.model.UserOps;
import com.bliss.nplay.adminv3.utils.DateUtils;
import com.bliss.service.paymentv2.thrift.EStatus;
import com.bliss.service.paymentv2.thrift.TSpecialDealValue;
import com.bliss.service.paymentv2.thrift.client.TPaymentV2ThriftClient;
import com.bliss.service.thrift.OpAuth;
import com.nct.game.framework.web.view.freemarker.FreeMarker;

public class SpecialDealController extends BaseController {

    private static final long serialVersionUID = 1L;

    private static final String LIST_SPECIAL_DEAL_PAGE = "pages/list_special_deal";
    private static final String DETAIL_SPECIAL_DEAL_PAGE = "pages/detail_special_deal";
    private static final String ADD_SPECIAL_DEAL_PAGE = "pages/add_special_deal";

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
            case UPDATE_REQUEST:
                doUpdate(req, resp);
                break;
            case LOAD_ADD_PAGE:
    			loadaddPage(req, resp);
    			break;    
            default:
                doSearch(req, resp);
                break;
        }
    }

    private void doGetId(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getParameter("specialDealId") == null) {
            throw new IOException("specialDealId not yet assign");
        }

        long specialDealId = ConvertUtils.toLong(req.getParameter("specialDealId"));
        TSpecialDealValue specialDeal = paymentv2Service.getSpecialDeal(specialDealId);
        if (specialDeal.getSpecialDealId() == 0) {
            throw new IOException("not found SpecialDealId: " + specialDealId);
        }

        // response
        Map<String, Object> respMap = super.getSuccessRespMap();
		respMap.put("fromDate", DateUtils.getDateTime(specialDeal.getDateBegin()));
		respMap.put("toDate", DateUtils.getDateTime(specialDeal.getDateEnd()));
        respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
        respMap.put("specialDeal", specialDeal);
        new FreeMarker(DETAIL_SPECIAL_DEAL_PAGE, respMap).render(req, resp);
    }

    private void doSearch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // paramsReq
        Date currentDate = new Date();
        Date fromDate = DateUtils.subtractDays(currentDate, SEVEN_DAYS_AGO);
        Date toDate = currentDate;
        if (req.getParameter("fromDate") != null) {
            fromDate = DateUtils.getDateTime(req.getParameter("fromDate"));
        }
        if (req.getParameter("toDate") != null) {
            toDate = DateUtils.getDateTime(req.getParameter("toDate"));
        }

        int pageNumber = ConvertUtils.toInt(req.getParameter("pageNumber"), FIRST_PAGE_REQUEST);
        // filter
        List<TSpecialDealValue> specialDeals = null;
        long userId = 0;
        EStatus status = EStatus.ACTIVE;
        String stStatus = req.getParameter("status");
        if (req.getParameter("userId") != null) { // filter userId
            userId = Long.valueOf(req.getParameter("userId"));
            specialDeals = paymentv2Service.listSpecialDealByUser(userId, fromDate.getTime(), toDate.getTime(),
                    pageNumber, PAGE_SIZE_REQUEST);
        } else if (req.getParameter("status") != null&&!req.getParameter("status").equals("ALL")) { // filter status 
            status = EStatus.valueOf(req.getParameter("status"));
            specialDeals = paymentv2Service.listSpecialDealByStatus(fromDate.getTime(), toDate.getTime(),
                    pageNumber, PAGE_SIZE_REQUEST, status);
        } else {
            specialDeals = paymentv2Service.listSpecialDeal(fromDate.getTime(), toDate.getTime(), pageNumber, PAGE_SIZE_REQUEST);
        }

        // result
        Map<String, Object> respMap = super.getSuccessRespMap();
        respMap.put("specialDeals", specialDeals);
        respMap.put("fromDate", DateUtils.getDateTime(fromDate));
        respMap.put("toDate", DateUtils.getDateTime(toDate));
        respMap.put("userId", req.getParameter("userId"));
        respMap.put("status", (userId == 0) ? stStatus : "ALL");
        respMap.put("pageNumber", pageNumber);
        respMap.put("pageSize", PAGE_SIZE_REQUEST);
        respMap.put("totalPage", TOTAL_PAGE_DEFAULT);
        respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
        new FreeMarker(LIST_SPECIAL_DEAL_PAGE, respMap).render(req, resp);
    }

    private void addParamsReq2SpecialDeal(HttpServletRequest req, TSpecialDealValue specialDeal) throws IOException {
        specialDeal.setUserId(Long.valueOf(req.getParameter("userId")));
        specialDeal.setUserName(req.getParameter("userName"));

        specialDeal.setPromotionRateData(req.getParameter("promotionRateData")); // TODO: assign data
        specialDeal.setCampaignName(req.getParameter("campaignName"));
        specialDeal.setCurrentNCoin(Long.valueOf(req.getParameter("currentNCoin")));

        specialDeal.setDescription(req.getParameter("description"));
        specialDeal.setStatus(EStatus.valueOf(req.getParameter("status")));
        specialDeal.setPurchased(Byte.valueOf(req.getParameter("purchased")));

        specialDeal.setDateBegin(DateUtils.getDateTime(req.getParameter("date_begin")).getTime());
        specialDeal.setDateEnd(DateUtils.getDateTime(req.getParameter("date_end")).getTime());
    }

    private void doAdd(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	UserOps sessionInfo = getSessionInfo(req);
    	OpAuth auth = new OpAuth();
        TSpecialDealValue specialDeal = new TSpecialDealValue();
        specialDeal.setUserCreated(sessionInfo.getUserName()); 
        addParamsReq2SpecialDeal(req, specialDeal);

        specialDeal = paymentv2Service.addSpecialDeal(auth, specialDeal);

        if (specialDeal.getSpecialDealId() == 0) {
            throw new IOException("add specialDeal failed");
        }
        // response
        super.writeResponse(resp, super.getSuccessRespMap());
    }

    private void doUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	UserOps sessionInfo = getSessionInfo(req);
    	OpAuth auth = new OpAuth();
        TSpecialDealValue specialDeal = paymentv2Service.getSpecialDeal(Long.valueOf(req.getParameter("specialDealId")));

//		specialDeal.setSpecialDealId(Long.valueOf(req.getParameter("specialDealId")));
        specialDeal.setUserModified(sessionInfo.getUserName());
        addParamsReq2SpecialDeal(req, specialDeal);

        boolean result = paymentv2Service.updateSpecialDeal(auth, specialDeal);
        if (!result) {
            throw new IOException("update specialDeal failed");
        }
        // response
        super.writeResponse(resp, super.getSuccessRespMap());
    }
    
    private void loadaddPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> respMap = super.getSuccessRespMap();
		respMap.put("fromDate", DateUtils.getDateTime(new Date()));
		respMap.put("toDate", DateUtils.getDateTime(new Date()));
                respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
		// response
		new FreeMarker(ADD_SPECIAL_DEAL_PAGE, respMap).render(req, resp);
	}
}
