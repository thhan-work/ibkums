package com.ibk.msg.web.loglist;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class LogList {
	
/***TSUMSSU21  ***/		
	
	private String  groupCoCd;		 	//그룹회사코드
	private String  groupUniqNo;	 	//그룹고유번호
	private String  batchTagtUniqNo; 	//배치대상고유번호
	private String  bzwkChnlCd;		 	//업무채널코드
	private String  bzwkIdnfr;		 	//발송업무선택(마케팅 or 비마케팅)
	private String  tmptUniqNo;		 	//템플릿고유번호
	private String  groupNm;		 	//그룹명(기안명)
	private String  msgDstic;		 	//메시지구분
	private String  approvalYn;		 	//승인여부
	private String  prcssStusDstic;	 	//처리상태구분
	private int  requestsNumber;	 	//요청건수
	private String  sendPrityDstic;	 	//발송우선순위구분
	private String  pengagYms;		 	//예약발송일시
	private String  expireScheduleYms;	//만료예정일시
	private String  sendStartYms; 	 	//발송시작일시
	private String  sendExpireYms; 	 	//발송만료일시
	private String  sendProgressNumber;	//발송진행건수
	private String  scheduleDstic; 	  	//스케줄구분
	private String  testYn; 	 	  	//테스트여부
	private String  inst; 	 	 	  	//설명
	private String  recvRefusalYn;	  	//수신거부적용여부
	private String  regYms;			  	//등록일시
	private String  regEmpNo;		  	//등록직원번호
	private String  sendEmpid;		  	//발송직원번호
	private String  sendBrncd;		  	//발송부점코드
	private String  sndrTelno;		  	//발신처전화번호
	private String  sndrNoAddress;	 	//발신번호주소
	private String  recvNoAddress;	 	//수신처전화번호
	private String  filterLimitYn;	 	//필터제한여부
	private String  testNo;			 	//테스트전화번호
	private String  recvNoVar;		 	//수신번호변수
	private String  replaceVariableVal; //메시지내용
	private String  billCode;           //수수료 코드
	
	private String censorId; //심의필번호
	private String budgetNm; //예산합의서명 
	private String modifyReason; // 수정사유
	private String stopReason; // 중지사유
	
	/*** GroupMessageFile ***/
	private MultipartFile uploadFile;   //업로드파일 
	
	/***TSUMSSU112  ***/		
	private String  deptCd;		 		//부서코드
	private String  deptNm;		 		//부서명
	private String userRole;
	
	
	/***TSUMSSU00 ***/
	private String cphnNo;
	private String sendYms;
	private String mobilCoDstic;
	private String rsultDstic;
	private String successCount;
	private String sendCount;
	private String failCount;
		
	/***TSUMSSU41 ***/
	private String tranDstic;
	
	/***검색 파라미터  ***/		
	private String stDate;   		 	//등록일시 
	private String endDate;		 		
	private String reStDate;		 	//예약발송일시
	private String reEndDate;		
	
	
	/***IBK 발송  ***/
	private String msgCtnt;				//lms 제목
	private String umsMsgCtnt; 			//sms, lms 내용
	
	/***TSUMSSU114  ***/		
	private int  usage;		 		//직원사용량
	private String usrCrdtUseYn;    //직원한도사용여부 
	private String emplCrdtInitYmd;    //직원한도초기화일자
	
	/***TSUMSSU115 ***/	
	private String chngYms;
	
	/***TSUMSSU28 ***/	
	private String T28Cnt;
	
	
	
}
