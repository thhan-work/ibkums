package com.ibk.msg.web.auth;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;


@Data
public class AuthSearchCondition extends PaginationCondition {
	private String dateType;		 // 등록일,수정일 타입  
	private String searchStartDt;    // 시작일
	private String searchEndDt;    	 // 종료일
	private String useYn;            // 사용
	private String authNm;           // 권한명
	private String authId;   		 // 권한 ID
	private String authInst;   		 // 설명
	                                 
	private String searchAuthNm; 	 // 승인명 검색
	private String searchUseYn;      // 사용  검색
	private String searchEmplId;     // 직원번호(목록)
	private String infoEmplId;       // 직원번호(상세)
	private String emplId;           // 직원번호
	private String emplNm;   		 // 직원명
	
	/** 권한부여 */                  
	//private String authEmplId;		// 사용자
	//private String boCode;           // 업무코드
	//private String userClass;        // 유저등급         관리자 : A, 일반 : N, 승인권자 : P, 직원용SMS : S
}                                                           