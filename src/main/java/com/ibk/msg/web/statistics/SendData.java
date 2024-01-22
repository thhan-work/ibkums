package com.ibk.msg.web.statistics;

import lombok.Data;

@Data
public class SendData {

	private String lvia;
	private String id;
	private String unitSystemItemName;
	private int waitSend;
	private int reqSend;
	private int waitRep;
	private int repSucc;
	private int repFail;
	
}
