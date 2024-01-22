package com.ibk.msg.web.statistics;

import lombok.Data;

@Data
public class SendGroupData {

	private String groupNm;
	private String groupUniqNo;
	private String id;
	private String unitSystemItemName;
	private int waitSend;
	private int reqSend;
	private int waitRep;
	private int repSucc;
	private int repFail;
	private String prcssStusDstic;
	
}
