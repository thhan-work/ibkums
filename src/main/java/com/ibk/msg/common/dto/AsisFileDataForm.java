package com.ibk.msg.common.dto;

import lombok.Data;

@Data
public class AsisFileDataForm {
	private Integer cno;
	private String uniquekey;  
	private String name; 
	private String msg1; 
	private String msg2; 
	private String msg3; 
	private String mobile;
	private String fax;
	private String email;

	// 추가
	private String emplId;
	private String grpSeq;
	private String department;	

}
