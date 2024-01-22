/*
 * @(#)MsgSendRvc.java
 *
 * Copyright 2001(c) Infobank Corp. All Rights Reserved.
 * e-FineSMS 3th Project. Developed by Messaging Biz. Development.
 */
package com.ibk.msg.web.message.model;

import lombok.Data;

/**
 * 메시지 수신 정보를 제공한다.
 *
 * @author www.infobank.net
 * @version 2005.01.17
 */
@Data
public class MsgSendRcv {
	/**
	 * 수신자 이름
	 */
	public String rcvName;



	/**
	 * 수신 휴대폰번호
	 */
	public String rcvPhone;


		/**
	 * 수신자 제목
	 */
	public String rcvSubject;

	/**
	 * 수신 메시지
	 */
	public String rcvMsg;


	/**
	 * 실명번호
	 */
	public String socialNo;

	public String tranCallback;



        /**
	 * 수신할 파일 갯수
	 */
	public String rcvFilect;
        
        /**
	 * 수신할 파일
	 */
	public String rcvFilename;
        /**
	 * 수신할 파일 사이즈
	 */
	public String rcvFilesize;
	
	public String callback;

	@Override
	public String toString() {
		return "MsgSendRcv [rcvName=" + rcvName + ", rcvPhone=" + rcvPhone + ", rcvSubject=" + rcvSubject + ", rcvMsg="
				+ rcvMsg + ", socialNo=" + socialNo + ", tranCallback=" + tranCallback + ", rcvFilect=" + rcvFilect
				+ ", rcvFilename=" + rcvFilename + ", rcvFilesize=" + rcvFilesize + ", callback=" + callback + "]";
	}
	
}
