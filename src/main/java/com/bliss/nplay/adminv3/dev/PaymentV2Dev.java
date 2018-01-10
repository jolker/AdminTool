package com.bliss.nplay.adminv3.dev;

import ga.log4j.GA;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.bliss.service.paymentv2.thrift.EStatus;
import com.bliss.service.paymentv2.thrift.TInvoiceValue;
import com.bliss.service.paymentv2.thrift.TPromotionValue;
import com.bliss.service.paymentv2.thrift.client.TPaymentV2ThriftClient;
import com.bliss.service.thrift.EEventUserGroup;
import com.bliss.service.thrift.OpAuth;

public class PaymentV2Dev {

	static TPaymentV2ThriftClient paymentv2Service = TPaymentV2ThriftClient.getInstance("thrift_paymentv2_client");

	public static void main(String[] args) {
		try {	
			// --------- PROMOTION --------------
			 addPromotion();
			// searchPromotion();

			// ---------- INVOICE ---------------
			// getInvoice();
//			getInvoices();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	static Date addDays(Date origDate, int days) {
		Calendar cal = Calendar.getInstance(); 	
		cal.setTime(origDate); 
		cal.add(Calendar.DATE, days);
		return cal.getTime();
	}

	// -----------------------------------------------------------------------------
	// -------------------------------TODO: PROMOTION ------------------------------
	// -----------------------------------------------------------------------------
	static TPromotionValue initPromotion() {
		TPromotionValue promotion = new TPromotionValue();
		promotion.setPromotionRateData(""); // TODO: REVIEW
		promotion.setPromotionUserGroup(EEventUserGroup.PAID_PAID);
		promotion.setPromotionName("PROMOTION-01");
		promotion.setPriority(1);
		promotion.setDescription("description");
		promotion.setStatus(EStatus.ACTIVE);
		promotion.setDateBegin(new Date().getTime());
		promotion.setDateEnd(new Date().getTime());
		promotion.setUserCreated("TUYEN.PHAM");
		promotion.setUserModified("HUY.NGUYEN");	
		return promotion;
	}

	static void addPromotion() {
		TPromotionValue promotion = initPromotion();
		OpAuth auth = new OpAuth();
		promotion= paymentv2Service.addPromotion(auth, promotion);
		String result  = promotion.getPromotionId() > 0?"successfully":"failed";
		GA.app.info("added promotion. result is " + result);
	}

	static void updatePromotion() throws Exception {
		OpAuth auth = new OpAuth();
		TPromotionValue promotion = getPromotion();
		promotion.setDescription("description-01");
		boolean result = paymentv2Service.updatePromotion(auth, promotion);
		GA.app.info("updated promotion. result is " + result);
	}

	static void updatePromotionStatus() throws Exception {
		OpAuth auth = new OpAuth();
		TPromotionValue promotion = getPromotion();
		promotion.setStatus(EStatus.INACTIVE);
		boolean result = paymentv2Service.updatePromotionStatus(auth,
				promotion.getPromotionId(), promotion.getStatus());
		GA.app.info("promotion changed status. result is " + result);
	}

	static TPromotionValue getPromotion() throws Exception {
		int pageNumber  = 1;
		int pageSize = 1;

		Date today = new Date();
		Date fromDate = addDays(today, -10);
		Date toDate = today;

		List<TPromotionValue> promotions = paymentv2Service.listPromotion(fromDate.getTime(),
				toDate.getTime(), pageNumber, pageSize);
		if (promotions.isEmpty())
			throw new Exception("not found any promotion activation");

		return promotions.get(0);
	}

	static void searchPromotion() {
		int pageNumber  = 1;
		int pageSize = 20;

		Date today = new Date();
		Date fromDate = addDays(today, -10);
		Date toDate = today;

		List<TPromotionValue> promotions = paymentv2Service.listPromotion(fromDate.getTime(),
				toDate.getTime(), pageNumber, pageSize);
		for (TPromotionValue obj : promotions)
			GA.app.info("obj: " + obj);
	}


	// -----------------------------------------------------------------------------
	// ------------------------------- TODO: INVOICE -------------------------------
	// -----------------------------------------------------------------------------
	// listInvoice, listInvoiceByProductType, listInvoiceByUser, reProcessInvoice
	static void getInvoice() {
		Long invoiceId = 1L;
		TInvoiceValue invoice = paymentv2Service.reProcessInvoice(invoiceId);
		GA.app.info("invoice: " + invoice);
	}

	static void getInvoices() {
		int pageNumber  = 1;
		int pageSize = 20;

		Date today = new Date();
		Date fromDate = addDays(today, -20);
		Date toDate = today;
		List<TInvoiceValue> invoices = paymentv2Service.listInvoice(fromDate.getTime(), toDate.getTime(), pageNumber, pageSize);
		for (TInvoiceValue inv:invoices)
			GA.app.info(inv);
	}


}
