/*
 * @(#)MsgFormInfo.java
 *
 * Copyright 2001(c) Infobank Corp. All Rights Reserved.
 * e-FineSMS 3th Project. Developed by Messaging Biz. Development.
 */
package com.ibk.msg.web.msgform;

import com.ibk.msg.common.dto.PaginationCondition;

/**
 * 서식 정보를 제공한다.
 * MSG_FORM_*는 발송양식/베스트문자 필드, MY_MSG_*는 저장메시지 필드이다.
 *
 * @author www.infobank.net
 * @version 2005.01.17
 */
public class MsgForm extends PaginationCondition{



	/**
	 * 발송양식/베스트문자 일련번호
	 */
	public int msgFormNo = 0;



	/**
	 * 발송양식/베스트문자 구분(1: 발송양식, 2: 베스트문자)
	 */
	public String msgFormClcd;



	/**
	 * 발송양식/베스트문자 제목
	 */
	public String msgFormTit;



	/**
	 * 발송양식/베스트문자 메시지내용
	 */
	public String msgFormCts;



	/**
	 * 발송양식/베스트문자 카테고리(1: 사랑, 2: 코믹, 3: 축하, 4:특별한 날, 5: 기타, 6: 새해인사)
	 */
	public String msgFormCate;



	/**
	 * 저장 메시지 키(MY_MSG_DATE의 'YYYYMMDDHH24MISS' 형식)
	 */
	public String myMsgDateKey;



	/**
	 * 저장 메시지 등록일
	 */
	public String myMsgDate;



	/**
	 * 부서 코드
	 */
	public String boCode;



	/**
	 * 저장 메시지 제목
	 */
	public String myMsgTitle;



	/**
	 * 저장 메시지 내용
	 */
	public String myMsgCts;
	
	
	/**
	 * 직원번호 
	 */
	public String emplId;

	
	/**
	 * 서식번호  
	 */
	public String formCd;
	
	
	/**
	 * 시퀀스  
	 */
	public String seq;
        
        /**
	 * 파일이름
	 */
	public String msgFilePath;
        
        /**
	 * 파일사이즈
	 */
	public String msgFileSiz;

	
	
		public int getMsgFormNo() {
			return msgFormNo;
		}

		public void setMsgFormNo(int msgFormNo) {
			this.msgFormNo = msgFormNo;
		}

		public String getMsgFormClcd() {
			return msgFormClcd;
		}

		public void setMsgFormClcd(String msgFormClcd) {
			this.msgFormClcd = msgFormClcd;
		}

		public String getMsgFormTit() {
			return msgFormTit;
		}

		public void setMsgFormTit(String msgFormTit) {
			this.msgFormTit = msgFormTit;
		}

		public String getMsgFormCts() {
			return msgFormCts;
		}

		public void setMsgFormCts(String msgFormCts) {
			this.msgFormCts = msgFormCts;
		}

		public String getMsgFormCate() {
			return msgFormCate;
		}

		public void setMsgFormCate(String msgFormCate) {
			this.msgFormCate = msgFormCate;
		}

		public String getMyMsgDateKey() {
			return myMsgDateKey;
		}

		public void setMyMsgDateKey(String myMsgDateKey) {
			this.myMsgDateKey = myMsgDateKey;
		}

		public String getMyMsgDate() {
			return myMsgDate;
		}

		public void setMyMsgDate(String myMsgDate) {
			this.myMsgDate = myMsgDate;
		}

		public String getBoCode() {
			return boCode;
		}

		public void setBoCode(String boCode) {
			this.boCode = boCode;
		}

		public String getMyMsgTitle() {
			return myMsgTitle;
		}

		public void setMyMsgTitle(String myMsgTitle) {
			this.myMsgTitle = myMsgTitle;
		}

		public String getMyMsgCts() {
			return myMsgCts;
		}

		public void setMyMsgCts(String myMsgCts) {
			this.myMsgCts = myMsgCts;
		}

		public String getEmplId() {
			return emplId;
		}

		public void setEmplId(String emplId) {
			this.emplId = emplId;
		}

		public String getFormCd() {
			return formCd;
		}

		public void setFormCd(String formCd) {
			this.formCd = formCd;
		}

		public String getSeq() {
			return seq;
		}

		public void setSeq(String seq) {
			this.seq = seq;
		}

		public String getMsgFilePath() {
			return msgFilePath;
		}

		public void setMsgFilePath(String msgFilePath) {
			this.msgFilePath = msgFilePath;
		}

		public String getMsgFileSiz() {
			return msgFileSiz;
		}

		public void setMsgFileSiz(String msgFileSiz) {
			this.msgFileSiz = msgFileSiz;
		}

		@Override
		public String toString() {
			return "MsgForm [msgFormNo=" + msgFormNo + ", msgFormClcd=" + msgFormClcd + ", msgFormTit=" + msgFormTit
					+ ", msgFormCts=" + msgFormCts + ", msgFormCate=" + msgFormCate + ", myMsgDateKey=" + myMsgDateKey
					+ ", myMsgDate=" + myMsgDate + ", boCode=" + boCode + ", myMsgTitle=" + myMsgTitle + ", myMsgCts="
					+ myMsgCts + ", emplId=" + emplId + ", formCd=" + formCd + ", seq=" + seq + ", msgFilePath="
					+ msgFilePath + ", msgFileSiz=" + msgFileSiz + "]";
		}

	
	
	
	
}
