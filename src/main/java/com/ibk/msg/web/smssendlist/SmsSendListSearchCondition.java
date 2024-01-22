package com.ibk.msg.web.smssendlist;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;


@Data
public class SmsSendListSearchCondition extends PaginationCondition {

	private String dateType;
	private String searchStartDt;
	private String searchEndDt;
	private String regDt;
	private String messageType; 		//메시지 구분
	private String messageTypeDetail; //세부 메시지 구분
	private String draftStatus; //기안상태
	private String draftName; //기안명
	private String boCode; // 업무코드
	private String emplId; // 직원번호
	private String userClass; // 유저등급         관리자 : A, 일반 : N, 승인권자 : P, 직원용SMS : S
	
	// 발송현황 부서명, 등록자명 추가(2022-09-08)
	private String partNm;
	private String regNm;
	
}
