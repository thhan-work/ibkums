package com.ibk.msg.web.fax;

import lombok.Data;

@Data
public class Fax {
	
	private int rnum; //순번
	private String keyId;
	private String mtsid;
	private String userId;
	private String faxno;
	private String result;
	private String sendTime;
	private String receiveTime;
	private String errorCode;
	private String deliverTime;
	private String page;
	private String tranEtc1;

}
