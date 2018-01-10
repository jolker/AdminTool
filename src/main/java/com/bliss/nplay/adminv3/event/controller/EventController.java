package com.bliss.nplay.adminv3.event.controller;

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
import com.bliss.nplay.service.eventv3.thrift.EButtonAction;
import com.bliss.nplay.service.eventv3.thrift.EEventStatus;
import com.bliss.nplay.service.eventv3.thrift.EEventType;
import com.bliss.nplay.service.eventv3.thrift.EPaymentType;
import com.bliss.nplay.service.eventv3.thrift.TEventV3Value;
import com.bliss.nplay.service.eventv3.thrift.client.TEventV3ThriftClient;
import com.bliss.service.thrift.EEventUserGroup;
import com.bliss.service.thrift.OpAuth;
import com.nct.game.framework.web.view.freemarker.FreeMarker;

public class EventController extends BaseController {
	private static final long serialVersionUID = 1L;

	private static final String LIST_EVENT_PAGE = "pages/list_event_v3";
	private static final String ADD_EVENT_PAGE = "pages/add_event_v3";
	private static final String DETAIL_EVENT_PAGE = "pages/detail_event_v3";

	private TEventV3ThriftClient eventV3Service = TEventV3ThriftClient.getInstance("thrift_eventv3_server");

	@Override
	protected void handle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String actionReq = req.getParameter(ACTION_REQUEST)==null?SEARCH_REQUEST:req.getParameter(ACTION_REQUEST);
		switch (actionReq) {
		case GET_ID_REQUEST:
			doGetId(req, resp);
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
		case SEARCH_REQUEST:
			doSearch(req, resp);
			break;
		default:
			doSearch(req, resp);
			break;
		}
	}

	private void addParamsReq2Event(HttpServletRequest req, TEventV3Value event) throws IOException {
		event.setTitle(req.getParameter("title"));
		event.setEventStatus(EEventStatus.valueOf(req.getParameter("status")));
		event.setDateBegin(DateUtils.getDateTime(req.getParameter("startDate")).getTime());
		event.setDateEnd(DateUtils.getDateTime(req.getParameter("endDate")).getTime());
		event.setDescription(req.getParameter("description"));
		event.setPriority(ConvertUtils.toByte(req.getParameter("priority")));
		event.setButtonAction(EButtonAction.valueOf(req.getParameter("buttonAction")));
		event.setButtonLink(req.getParameter("buttonLink"));
		event.setButtonText(req.getParameter("buttonText"));
		event.setEventType(EEventType.valueOf(req.getParameter("eventType")));
		event.setFrequency(ConvertUtils.toShort(req.getParameter("frequency")));
		event.setImgUrl(req.getParameter("imgUrl"));
		event.setPaymentType(EPaymentType.valueOf(req.getParameter("paymentType")));
		event.setEventUserGroup(EEventUserGroup.valueOf(req.getParameter("eventUserGroup")));
	}

	private void doSearch(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
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

		// search
		List<TEventV3Value> listEventV3Value = eventV3Service.getAllEvent(fromDate.getTime(), toDate.getTime(),
				(short) pageNumber, (short) PAGE_SIZE_REQUEST);

		// result
		Map<String, Object> respMap = super.getSuccessRespMap();
		respMap.put("list_data", listEventV3Value);
		respMap.put("fromDate", DateUtils.getDateTime(fromDate));
		respMap.put("toDate", DateUtils.getDateTime(toDate));
		respMap.put("pageNumber", pageNumber);
		respMap.put("pageSize", PAGE_SIZE_REQUEST);
		respMap.put("totalPage", TOTAL_PAGE_DEFAULT);
                respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
		new FreeMarker(LIST_EVENT_PAGE, respMap).render(req, resp);
	}

	private void doGetId(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getParameter("eventId") == null) {
			throw new IOException("eventId not yet assign");
		}

		int eventId = ConvertUtils.toInt(req.getParameter("eventId"));
		TEventV3Value event = eventV3Service.getEvent(eventId);
		if (event.getEventId() == 0) {
			throw new IOException("not found eventId: " + eventId);
		}

		// response
		Map<String, Object> respMap = super.getSuccessRespMap();
		respMap.put("fromDate", DateUtils.getDateTime(event.getDateBegin()));
		respMap.put("toDate", DateUtils.getDateTime(event.getDateEnd()));
		respMap.put("data", event);
                respMap.put(SESSION_INFO, req.getSession().getAttribute(SESSION_INFO));
		new FreeMarker(DETAIL_EVENT_PAGE, respMap).render(req, resp);
	}

	private void doUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int eventId = ConvertUtils.toInt(req.getParameter("eventId"), 1);
		OpAuth opAuth = new OpAuth();
		TEventV3Value event = eventV3Service.getEvent(eventId); // TODO: ??? 
		
		addParamsReq2Event(req, event);
		//get session data user
		UserOps sessionInfo = getSessionInfo(req);
		event.setUserUpdated(sessionInfo.getUserName());	
		boolean result = eventV3Service.updateEvent(opAuth, event);
		if (!result)
			throw new IOException("update event failed. eventId: " + eventId);
		// response
		super.writeResponse(resp, super.getSuccessRespMap());
	}

	private void doAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		TEventV3Value event = new TEventV3Value();
		OpAuth opAuth = new OpAuth();
		addParamsReq2Event(req, event);
		//get session data user
		UserOps sessionInfo = getSessionInfo(req);
		event.setUserCreated(sessionInfo.getUserName());
		event = eventV3Service.addEvent(opAuth, event);
		if (event.getEventId() == 0) {
			throw new IOException("add event failed.");
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
		new FreeMarker(ADD_EVENT_PAGE, respMap).render(req, resp);
	}
	
}
