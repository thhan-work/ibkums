/*
 * @(#)MsgFormInfo.java
 *
 * Copyright 2001(c) Infobank Corp. All Rights Reserved.
 * e-FineSMS 3th Project. Developed by Messaging Biz. Development.
 */
package com.ibk.msg.web.msgform;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class MsgFormSearchCondition extends MsgForm{

	// 서식함 구분 값 (happy:해피콜, head:본부양식, personal:개인서식함, dept:부서서식함)
	String code;
	// 서식함 메시지 구분 값 ( sms, mms)
	String division; 
	
	
	// 개인서식함 저장 메시지 내용
	String msg;
	// 개인서식함 저장 제목
	String title;
}
