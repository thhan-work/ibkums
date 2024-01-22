/*
 * @(#)MsgSendRvc.java
 *
 * Copyright 2001(c) Infobank Corp. All Rights Reserved.
 * e-FineSMS 3th Project. Developed by Messaging Biz. Development.
 */
package com.ibk.msg.web.message.model;

import java.util.List;

import com.ibk.msg.web.mymessage.MyMessage;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 메시지 발송을 위한 DTO
 *
 * @author www.infobank.net
 * @version 2005.01.17
 */
@EqualsAndHashCode(callSuper=false)
@Data
public class MsgSend{
	
	//내가보낸메시지
	List<MsgSendInfo> mymsgResendList;
	List<MsgSendInfo> mymsgLogList;
	
	//발송 연락처 리스트
	List<MsgSendInfo> msgSendList;
	//로그 연락처 리스트
	List<MsgSendInfo> msgLogList;
	
	//발송 문자 타입
	String sendType;
	
	//업무코드 ( UNITCODE + 부서코드 + '_' + 회원ID )
	String tranId;
	//로그테이블 설정
	String logDate;
	
	//수신거부체크여부
	boolean checkUnsubscribe;	
	
	//수신거부 건수체크를 위한 pollkey
	String pollingkey;
}
