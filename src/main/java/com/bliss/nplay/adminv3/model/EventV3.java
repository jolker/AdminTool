package com.bliss.nplay.adminv3.model;

import com.bliss.nplay.adminv3.utils.DateUtils;
import com.bliss.nplay.service.eventv3.thrift.EButtonAction;
import com.bliss.nplay.service.eventv3.thrift.EEventStatus;
import com.bliss.nplay.service.eventv3.thrift.EEventType;
import com.bliss.nplay.service.eventv3.thrift.EPaymentType;
import com.bliss.nplay.service.eventv3.thrift.TEventV3Value;
import com.bliss.service.thrift.EEventUserGroup;

public class EventV3 {
	int eventId; // required
	String title; // required
	String description; // required
	String imgUrl;
	EEventType eventType;
	EPaymentType paymentType;
	short frequency;
	byte priority; // required
	EButtonAction buttonAction; // required
	String buttonText; // required
	String buttonLink; // required
	String strDateBegin; // required
	String strDateEnd; // required
	String userCreated; // required
	String userUpdated; // required
	EEventStatus eventStatus; // required
	String strDateCreated; // required
	String strDateUpdated; // required
	EEventUserGroup eventUserGroup;
	public int getEventId() {
		return eventId;
	}

	public void setEventId(int eventId) {
		this.eventId = eventId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public byte getPriority() {
		return priority;
	}

	public void setPriority(byte priority) {
		this.priority = priority;
	}

	public String getUserCreated() {
		return userCreated;
	}

	public void setUserCreated(String userCreated) {
		this.userCreated = userCreated;
	}

	public String getUserUpdated() {
		return userUpdated;
	}

	public void setUserUpdated(String userUpdated) {
		this.userUpdated = userUpdated;
	}

	public EEventStatus getEventStatus() {
		return eventStatus;
	}

	public void setEventStatus(EEventStatus eventStatus) {
		this.eventStatus = eventStatus;
	}

	public String getStrDateCreated() {
		return strDateCreated;
	}

	public void setStrDateCreated(String strDateCreated) {
		this.strDateCreated = strDateCreated;
	}

	public String getStrDateUpdated() {
		return strDateUpdated;
	}

	public void setStrDateUpdated(String strDateUpdated) {
		this.strDateUpdated = strDateUpdated;
	}
	
	


	public String getStrDateBegin() {
		return strDateBegin;
	}

	public void setStrDateBegin(String strDateBegin) {
		this.strDateBegin = strDateBegin;
	}

	public String getStrDateEnd() {
		return strDateEnd;
	}

	public void setStrDateEnd(String strDateEnd) {
		this.strDateEnd = strDateEnd;
	}
	
	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public EEventType getEventType() {
		return eventType;
	}

	public void setEventType(EEventType eventType) {
		this.eventType = eventType;
	}

	public EPaymentType getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(EPaymentType paymentType) {
		this.paymentType = paymentType;
	}

	public short getFrequency() {
		return frequency;
	}

	public void setFrequency(short frequency) {
		this.frequency = frequency;
	}

	public EButtonAction getButtonAction() {
		return buttonAction;
	}

	public void setButtonAction(EButtonAction buttonAction) {
		this.buttonAction = buttonAction;
	}

	public String getButtonText() {
		return buttonText;
	}

	public void setButtonText(String buttonText) {
		this.buttonText = buttonText;
	}

	public String getButtonLink() {
		return buttonLink;
	}

	public void setButtonLink(String buttonLink) {
		this.buttonLink = buttonLink;
	}

	
	

	public EEventUserGroup getEventUserGroup() {
		return eventUserGroup;
	}

	public void setEventUserGroup(EEventUserGroup eventUserGroup) {
		this.eventUserGroup = eventUserGroup;
	}

	public EventV3(TEventV3Value value) {
		eventId = value.getEventId();
		title = value.getTitle();
		description = value.getDescription();
		priority = value.getPriority();
		userCreated = value.getUserCreated();
		userUpdated = value.getUserUpdated(); // required
		eventStatus = value.getEventStatus(); // required
		strDateCreated = DateUtils.getDateTime(value.getDateCreated()); // required
		strDateUpdated = DateUtils.getDateTime(value.getDateUpdated()); // required
		strDateBegin = DateUtils.getDateTime(value.getDateBegin()); // required
		strDateEnd = DateUtils.getDateTime(value.getDateEnd()); // required
		
		buttonAction=value.getButtonAction();
		buttonLink=value.getButtonLink();
		buttonText=value.getButtonText();
		eventType=value.getEventType();
		frequency=value.getFrequency();
		imgUrl=value.getImgUrl();
		paymentType=value.getPaymentType();
		eventUserGroup= value.getEventUserGroup();
	}

}
