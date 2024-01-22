package com.ibk.msg.web.auth;

import java.util.List;

import lombok.Data;

@Data
public class TAuthUser {
	
	/*** TB_AUTH_USER  ***/		
	/** 직원ID */
	private String emplId;
	/** 등록자 */
	private String regId;
	/** 등록일자 */
	private String regYms;
	
	//-----------custom------------- 
	private int rnum;                // 순번
	private String emplName;         // 직원명
	private String boCode;           // 부서코드
	private String partName;         // 부서명
	private String positionCallName; // 직책명
	private String regName;          // 등록자명
	private int authCnt;             // 권한 수
	private String authGrantRegName; // 권한부여자
	private String authGrantYms;     // 권한부여일
	private List<String> emplIdList; // 권한사용자 리스트
}
