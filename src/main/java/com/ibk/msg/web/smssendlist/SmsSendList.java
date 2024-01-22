package com.ibk.msg.web.smssendlist;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ibk.msg.web.smsreq.FileHeadData;
import com.ibk.msg.web.smsreq.T30Data;
import com.ibk.msg.web.smsreq.T32Data;

import lombok.Data;

@Data
public class SmsSendList extends FileHeadData{
	
	/***TSUMSSU21  ***/		
	private int rnum; //순번
	private String  groupCoCd;		 	                  // 그룹회사코드
	private String  batchTagtUniqNo; 	                  // 배치대상고유번호
	private String  bzwkChnlCd;		 	                  // 업무채널코드
	private String  bzwkIdnfr;		 	                  // 업무식별자(CC직원번호_부서코드)
	private String  tmptUniqNo;		 	                  // 템플릿고유번호
	private String  groupNm;		 	                  // 그룹명(기안명)
	private String  msgDstic;		 	                  // 메시지구분
	private String  approvalYn;		 	                  // 승인여부
	private String  prcssStusDstic;	 	                  // 처리상태구분
	private int  requestsNumber;	 	                  // 요청건수
	private String  sendPrityDstic;	 	                  // 발송우선순위구분
	private String  pengagYms;		 	                  // 예약발송일시
	private String  expireScheduleYms;	                  // 만료예정일시
	private String  sendStartYms; 	 	                  // 발송시작일시
	private String  sendExpireYms; 	 	                  // 발송만료일시
	private String  sendProgressNumber;	                  // 발송진행건수
	private String  scheduleDstic; 	  	                  // 스케줄구분
	private String  testYn; 	 	  	                  // 테스트여부
	private String  inst; 	 	 	  	                  // 설명
	private String  recvRefusalYn;	  	                  // 수신거부적용여부
	private String  regYms;			  	                  // 등록일시
	private String  regEmpNo;		  	                  // 등록직원번호
	private String  sendEmpid;		  	                  // 발송직원번호
	private String  sendBrncd;		  	                  // 발송부점코드
	private String  sndrTelno;		  	                  // 발신처전화번호
	private String  sndrNoAddress;	 	                  // 발신번호주소
	private String  recvNoAddress;	 	                  // 수신처전화번호
	private String  filterLimitYn;	 	                  // 필터제한여부
	private String  testNo;			 	                  // 테스트전화번호
	private String  recvNoVar;		 	                  // 수신번호변수
	private String  replaceVariableVal;                   // 메시지내용
	private String  billCode;                             // 수수료 코드
	private String  progressStep;                         // 단계
	
	private List<T30Data> sendDateInfo;
	private List<T32Data> confirmEmp;
	private List<T32Data> sendConfirmEmp;
	
	private String confirmMessage; // 기안정보(URL포함)
	
	private String tempSave; //임시저장 여부
	private String emplName; //이름
	private String emplPosition; //
	private String emplClass; //
	private String positionCallname; //직급
    private String partName; //부서명
    private String emplHpNo; //핸드폰 번호
    
    private String agreeType; // 승인타입 (1:1차, 2:2차, 3:3차, 4:발송승인)
    private String agreeStatus; // 승인여부(I : 승인대기 , G: 승인완료)
	
    // 신규컬럼 추가(2022-09-14)
    private String receiveAgreeCheckYn; // 수신동의체크
    private String duplicateCheckYn; // 중복체크여부
    
	/*** TSUMSSU21_INFO ***/
    private String censorId;			                 // 심의필번호
	private String budgetNm;			                 // 예산합의서명
	private String modifyReason;		                 // 수정사유
	private String stopReason;		                     // 중지사유
	private String EmplId;                               // 직원아이디
	private String BoCode;                               // 업무코드
	private String seq1;				                 // MMS 템플릿 SEQ1
	private String seq2;				                 // MMS 템플릿 SEQ2
	private String seq3;				                 // MMS 템플릿 SEQ3
	private String fileCnt;		                         // MMS 파일 개수
	private String successCountNumber;                   // 정상건수
	private String errorCountNumber;                     // 에러건수
	private String targetFilePath;	                     // 대상자파일명
	private String sendType;			                 // 발송업무 선택
	private String agreeExistenceYn;		             // 2차,3차 승인자 존재 여부 확인
	private String kkoTmplCd;                            // 알림톡템플릿ID
	private String channelTmplId;                        // 채널별템플릿ID
	private String channelMsgStandard;                   // 채널별전문규격
	private String channelMsgText;                       // 채널별전문내용
	private String channelButtonText;                    // 채널별버튼내용
	private String channelOptionText;                    // 채널별옵션내용
	private String altMsgDiv;                            // 대체메시지구분
	private String altMsgTitle;                          // 대체메시지제목
	private String altMsgText;                           // 대체메시지내용
	private String targetFileId;                         // 대상자fileId
	
	/*** TB_KKO_TMPL ***/
	private String tmplNm;				                 // 알림톡 템플릿명
	private String tmplMsg;				                 // 알림톡 템플릿메시지
	private String btnInfo;				                 // 알림톡 템플릿버튼정보
	
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
	
	/***TSUMSSU114  ***/		
	private int  usage;		 		//직원사용량
	private String usrCrdtUseYn;    //직원한도사용여부 
	private String emplCrdtInitYmd;    //직원한도초기화일자
	
	/***TSUMSSU115 ***/	
	private String chngYms;
	
	/***TSUMSSU28 ***/	
	private String T28Cnt;
	private String targetReplaceVal;
	
	/*** 기타 ***/
	private String changeHeadDataYn; // 헤더 데이터 변경 여부 (Y: 변경, N: 동일) @jys
	
}
