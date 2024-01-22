package com.ibk.msg.web.email;

import lombok.Data;

@Data
public class Email {
	
	private String userId;
	private String idDomain;
	private String emplId;
	private String campaignNo;
	private String campaignNm;
	private String customerKey;
	private String listSeq;
	private String resultSeq;
	private String sid;
	private String status;
	
	private String customerNm;
	private String customerEmail;
	private String sendDt;
	private String sendTm;
	private String endDt;
	private String endTm;
	private String sendDomain;
	private String errorCd;
	private String errMsg;
	private String slot1;
	private String slot2;
	private String resendYn;
	private String ecareNm;
	private String ecareNo;

	// open date 추가
	private String openDate;
	private int startIdx;
	private int endIdx;

	private String sendDate;
	private String searchKey;
	private String searchValue;
	
	//20170919 ip주소추가
	private String ipAdr;
}
