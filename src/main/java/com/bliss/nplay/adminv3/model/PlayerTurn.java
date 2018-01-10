/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bliss.nplay.adminv3.model;

import java.io.Serializable;
import java.util.List;

/**
 *
 * @author anhlnt
 */
public class PlayerTurn implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long userId;
	
	private int chiTotal;
	
	private int moneyTransfer;

	List<String> cards1st;
	
	List<String> cards2nd;
	
	List<String> cards3rd;

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public int getChiTotal() {
		return chiTotal;
	}

	public void setChiTotal(int chiTotal) {
		this.chiTotal = chiTotal;
	}

	public int getMoneyTransfer() {
		return moneyTransfer;
	}

	public void setMoneyTransfer(int moneyTransfer) {
		this.moneyTransfer = moneyTransfer;
	}

	public List<String> getCards1st() {
		return cards1st;
	}

	public void setCards1st(List<String> cards1st) {
		this.cards1st = cards1st;
	}

	public List<String> getCards2nd() {
		return cards2nd;
	}

	public void setCards2nd(List<String> cards2nd) {
		this.cards2nd = cards2nd;
	}

	public List<String> getCards3rd() {
		return cards3rd;
	}

	public void setCards3rd(List<String> cards3rd) {
		this.cards3rd = cards3rd;
	}
	
}
