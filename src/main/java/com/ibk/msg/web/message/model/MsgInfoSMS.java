/*
 * @(#)MsgInfo.java
 *
 * Copyright 2001(c) Infobank Corp. All Rights Reserved.
 * e-FineSMS 3th Project. Developed by Messaging Biz. Development.
 */
package com.ibk.msg.web.message.model;

/**
 * SMS 정보를 제공한다.
 * 
 * @author www.infobank.net
 * @version 2005.01.17
 */
public class MsgInfoSMS {

	/**
	 * 메시지 키
	 */
	public String TRAN_PR;

	/**
	 * 실명번호
	 */
	public String TRAN_REFKEY;

	/**
	 * 마지막 발송시스템(UNIT_NAME)
	 */
	public String TRAN_LVIA;

	/**
	 * 처음 발송시스템
	 */
	public String TRAN_FVIA;

	/**
	 * 메시지 아이디
	 */
	public String TRAN_ID;

	/**
	 * 휴대폰 번호
	 */
	public String TRAN_PHONE;

	/**
	 * 회신 번호
	 */
	public String TRAN_CALLBACK;

	/**
	 * 전송 일자
	 */
	public String TRAN_DATE;

	/**
	 * 메시지 내용
	 */
	public String TRAN_MSG;

	/**
	 * 전송 상태
	 */
	public String TRAN_STATUS;

	/**
	 * 전송 결과
	 */
	public String TRAN_RSLT;

	/**
	 * 발송 시스템 이름
	 */
	public String UNIT_SYSTEM_NAME;

	/**
	 * 영업점 이름
	 */
	public String PART_NAME;

	/**
	 * 직원 이름
	 */
	public String EMPL_NAME;

	/**
	 * 고객 이름
	 */
	public String CUST_NAME;

	/**
	 * BLS 거래에 대한 계좌번호
	 */
	public String TRAN_ETC1;
	
	/**  
	 * 응답시간
	 */
	public String TRAN_RSLTDATE;
	
	/**
	 * 이통사 정보
	 */
	public String TRAN_NET;
	
	/**
	 * 업무명
	 */
	public String UNIT_NAME;
	
	/**
	 * 담당자/발송자 정보
	 */
	public String UNIT_PIC;
	
	/**
	 * 담당자 연락처 정보
	 */
	public String UNIT_PIC_TELNO;
	

	public String getTRAN_PR() {
		return TRAN_PR;
	}

	public void setTRAN_PR(String tRAN_PR) {
		TRAN_PR = tRAN_PR;
	}

	public String getTRAN_REFKEY() {
		return TRAN_REFKEY;
	}

	public void setTRAN_REFKEY(String tRAN_REFKEY) {
		TRAN_REFKEY = tRAN_REFKEY;
	}

	public String getTRAN_LVIA() {
		return TRAN_LVIA;
	}

	public void setTRAN_LVIA(String tRAN_LVIA) {
		TRAN_LVIA = tRAN_LVIA;
	}

	public String getTRAN_FVIA() {
		return TRAN_FVIA;
	}

	public void setTRAN_FVIA(String tRAN_FVIA) {
		TRAN_FVIA = tRAN_FVIA;
	}

	public String getTRAN_ID() {
		return TRAN_ID;
	}

	public void setTRAN_ID(String tRAN_ID) {
		TRAN_ID = tRAN_ID;
	}

	public String getTRAN_PHONE() {
		return TRAN_PHONE;
	}

	public void setTRAN_PHONE(String tRAN_PHONE) {
		TRAN_PHONE = tRAN_PHONE;
	}

	public String getTRAN_CALLBACK() {
		return TRAN_CALLBACK;
	}

	public void setTRAN_CALLBACK(String tRAN_CALLBACK) {
		TRAN_CALLBACK = tRAN_CALLBACK;
	}

	public String getTRAN_DATE() {
		return TRAN_DATE;
	}

	public void setTRAN_DATE(String tRAN_DATE) {
		TRAN_DATE = tRAN_DATE;
	}

	public String getTRAN_MSG() {
		return TRAN_MSG;
	}

	public void setTRAN_MSG(String tRAN_MSG) {
		TRAN_MSG = tRAN_MSG;
	}

	public String getTRAN_STATUS() {
		return TRAN_STATUS;
	}

	public void setTRAN_STATUS(String tRAN_STATUS) {
		TRAN_STATUS = tRAN_STATUS;
	}

	public String getTRAN_RSLT() {
		return TRAN_RSLT;
	}

	public void setTRAN_RSLT(String tRAN_RSLT) {
		TRAN_RSLT = tRAN_RSLT;
	}

	public String getUNIT_SYSTEM_NAME() {
		return UNIT_SYSTEM_NAME;
	}

	public void setUNIT_SYSTEM_NAME(String uNIT_SYSTEM_NAME) {
		UNIT_SYSTEM_NAME = uNIT_SYSTEM_NAME;
	}

	public String getPART_NAME() {
		return PART_NAME;
	}

	public void setPART_NAME(String pART_NAME) {
		PART_NAME = pART_NAME;
	}

	public String getEMPL_NAME() {
		return EMPL_NAME;
	}

	public void setEMPL_NAME(String eMPL_NAME) {
		EMPL_NAME = eMPL_NAME;
	}

	public String getCUST_NAME() {
		return CUST_NAME;
	}

	public void setCUST_NAME(String cUST_NAME) {
		CUST_NAME = cUST_NAME;
	}

	public String getTRAN_ETC1() {
		return TRAN_ETC1;
	}

	public void setTRAN_ETC1(String tRAN_ETC1) {
		TRAN_ETC1 = tRAN_ETC1;
	}
	
	public String getTRAN_RSLTDATE() {
		return TRAN_RSLTDATE;
	}

	public void setTRAN_RSLTDATE(String tRAN_RSLTDATE) {
		TRAN_RSLTDATE = tRAN_RSLTDATE;
	}
	

	public String getTRAN_NET() {
		return TRAN_NET;
	}

	public void setTRAN_NET(String tRAN_NET) {
		TRAN_NET = tRAN_NET;
	}

	public String getUNIT_NAME() {
		return UNIT_NAME;
	}

	public void setUNIT_NAME(String uNIT_NAME) {
		UNIT_NAME = uNIT_NAME;
	}

	public String getUNIT_PIC() {
		return UNIT_PIC;
	}

	public void setUNIT_PIC(String uNIT_PIC) {
		UNIT_PIC = uNIT_PIC;
	}

	public String getUNIT_PIC_TELNO() {
		return UNIT_PIC_TELNO;
	}

	public void setUNIT_PIC_TELNO(String uNIT_PIC_TELNO) {
		UNIT_PIC_TELNO = uNIT_PIC_TELNO;
	}
	
	

	@Override
	public String toString() {
		return "MsgInfo [TRAN_PR=" + TRAN_PR + ", TRAN_REFKEY=" + TRAN_REFKEY
				+ ", TRAN_LVIA=" + TRAN_LVIA + ", TRAN_FVIA=" + TRAN_FVIA
				+ ", TRAN_ID=" + TRAN_ID + ", TRAN_PHONE=" + TRAN_PHONE
				+ ", TRAN_CALLBACK=" + TRAN_CALLBACK + ", TRAN_DATE="
				+ TRAN_DATE + ", TRAN_MSG=" + TRAN_MSG + ", TRAN_STATUS="
				+ TRAN_STATUS + ", TRAN_RSLT=" + TRAN_RSLT
				+ ", UNIT_SYSTEM_NAME=" + UNIT_SYSTEM_NAME + ", PART_NAME="
				+ PART_NAME + ", EMPL_NAME=" + EMPL_NAME + ", CUST_NAME="
				+ CUST_NAME + ", TRAN_ETC1=" + TRAN_ETC1 + "]";
	}
	
	
}