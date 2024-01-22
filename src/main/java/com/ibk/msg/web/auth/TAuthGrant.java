package com.ibk.msg.web.auth;

import java.util.List;

import lombok.Data;

@Data
public class TAuthGrant {
	
	/*** TB_AUTH_GRANT  ***/		
	/** 권한ID */
	private String authId;
	/** 직원ID */
	private String emplId;
	/** 등록자 */
	private String regId;
	/** 등록일자 */
	private String regYms;
	/** 수정자 */
	private String modId;
	/** 수정일자 */
	private String modYms;
	
	//-----------custom------------- 
	private List<String> emplIdList; // 사용자 list   		
	private List<String> authIdList; // 권한 list	
}
