/*
 * @(#)MsgSendInfo.java
 *
 * Copyright 2001(c) Infobank Corp. All Rights Reserved.
 * e-FineSMS 3th Project. Developed by Messaging Biz. Development.
 */
package com.ibk.msg.web.message.model;

import lombok.Data;

/**
 * 메시지 전송 정보를 제공한다.
 *
 * @author www.infobank.net
 * @version 2005.01.17
 */
@Data
public class MsgSendInfo extends MsgSendRcv{



	/**
	 * 회신번호
	 */
	public String tranCallback;



	/**
	 * 전송일자(즉시전송: SYSDATE, 예약전송: YYYYMMDDHH24MISS, 경조사 경우 즉시/예약 모두 YYYYMMDDHH24MISS)
	 */
	public String tranDate;



	/**
	 * 메시지 내용
	 */
	public String tranMsg;



	/**
	 * SMS 업무시스템 코드(e-FineSMS는 "CC")
	 */
	public String unitCode;



	/**
	 * SMS 업무시스템 세부 코드 또는 영업점 코드
	 */
	public String desCode;



	/**
	 * 직원 아이디
	 */
	public String emplId;



	/**
	 * 부서 이름
	 */
	public String partName;



	/**
	 * 광고 여부(일반 메시지: 0, 광고 메시지: 1)
	 */
	public String isAD;

	 

	/**
	 * 서비스 품질보증서 신청고객 여부(미신청자: 0, 신청자: 1)
	 */
	public String userAD;



	/**
	 * 직급 코드(전체: ALL)
	 */
	public String emplClass;



	/**
	 * 직위 이름(전체: ALL)
	 */
	public String emplPositionName;


	/**
	 * 전송할 파일이름
	 */
	public String fileCt;
	public String fileName;

	public String fileSize;

	
	/**
	 * 메세지 타입 (SMS, MMS)
	 */
	private String sendType;
	
	/**
	 * 발송 상태 값
	 */
	private String tranStatus;
	
	/**
	 * 발송 결과 값 
	 */
	private String tranRslt;
	
	
	@Override
	public String toString() {
		return "MsgSendInfo [tranCallback=" + tranCallback + ", tranDate=" + tranDate + ", tranMsg=" + tranMsg
				+ ", unitCode=" + unitCode + ", desCode=" + desCode + ", emplId=" + emplId + ", partName=" + partName
				+ ", isAD=" + isAD + ", userAD=" + userAD + ", emplClass=" + emplClass + ", emplPositionName="
				+ emplPositionName + ", fileCt=" + fileCt + ", fileName=" + fileName + ", fileSize=" + fileSize + "]";
	}
	
	
	public void setMsgSendInfo(MsgSendInfo msgSendInfo){
		
		this.setDesCode(msgSendInfo.getDesCode());
		this.setUnitCode(msgSendInfo.getUnitCode());
		this.setEmplId(msgSendInfo.getEmplId());
		this.setIsAD(msgSendInfo.getIsAD());
		this.setPartName(msgSendInfo.getPartName());
		this.setTranCallback(msgSendInfo.getTranCallback());
		this.setTranMsg(msgSendInfo.getTranMsg());
		this.setTranDate(msgSendInfo.getTranDate());
		this.setUserAD(msgSendInfo.getUserAD());
		this.setFileCt(msgSendInfo.getFileCt());
		this.setSendType(msgSendInfo.getSendType());
	}

}
