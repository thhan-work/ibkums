package com.ibk.msg.web.auth;

import lombok.Data;

@Data
public class AuthMgmtList {
	
	/*** tb_auth_mgmt  ***/		
	private int rnum; 			// 순번
	private String authId; 	 	// 권한 ID
	private String authNm; 	 	// 권한명
	private String authInst;	// 설명
	private String regId;		// 등록자 id
	private String regYms;		// 등록일
	private String regNm;		// 등록자명
	
	//-----------custom------------- 
	private String authGrantYn; // 해당직원 권한부여 여부
}
