package com.ibk.msg.web.smsUnsubscribe;

import lombok.Data;

@Data
public class SmsUnsubscribeInfo {
	private String num;
	private String custBsno;
	private String custName;
	private String cutDate;
	private String cutMemo;    
	private String cutOption;  
	private String cutOptionAll; 
	private String cutOptionAd;  
	private String cutOptionCa;  
	private String cutOptionYc;  
	private String enlister;    
	private String emplName;        
	private String boCode;        
	private String phone;
}
