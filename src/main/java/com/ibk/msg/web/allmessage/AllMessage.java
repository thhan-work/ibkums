package com.ibk.msg.web.allmessage;

import lombok.Data;

@Data
public class AllMessage {
	

	
	/***검색 파라미터  ***/		
	private String stDate;   		 	//등록일시 
	private String endDate;		 		
	private String reStDate;		 	//예약발송일시
	private String reEndDate;		
	
	
	
	
	/***DIST_SMS, DIST_MMS_MSG ***/
	private int msgkey; //시퀀스
	private String subject; //제목
	private String id; //거래구분코드
	private String phone; //발송핸드폰번호
	private String unitSystemName; //업무단위구분
	private String callback; // 회신전화번호
	private String status; // 결과코드
	private String rslt; // 이통사 처리결과
	private String reqDate; // 발송일시
	private String msg; // 메시지내용
	private String fvia; // 
	private String etc1; // 
	private String etc3; // 
	private String rsltDate; //통신사응답일시
	private String telcoInfo; // 통신사
	private String messageType; // SMS, LMS, MMS 구분
	private String tranStatus; // 발송상태(발송대기 SMS : 1, LMS : 0)
	private String lvia; //업무내용
	private String unitName; //업무구분
	private String unitPic; //담당자
	private String unitPicTelno; //담당자 연락처
	private String csGuide; //CS응대

	private String agentRslt;	// Agent 자체 결과코드
	private String refCtnt;		// 알림톡 전환발송 이유
	
	/*** count ***/
	private int successCount; // 성공 카운트
	private int totalCount; // 토탈카운트 
	
	/*** ETC ***/
	private int vsubCode; // 영업점 구분 코드 (영업점 : 1, 일반 : 0)
	
	private int seq1;
	private int seq2;
	private int seq3;
	private String tranRefkey;
	
	private String personalinfo1;
	private String personalinfo2;
	private String personalinfo3;
	
}
