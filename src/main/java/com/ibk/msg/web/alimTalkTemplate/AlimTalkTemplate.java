package com.ibk.msg.web.alimTalkTemplate;

import lombok.Data;

@Data
public class AlimTalkTemplate {
	private String rnum;	
	private String mode; // C, DTL, U
	
	private String kkoTmplCd;	      /** VARCHAR2(60 BYTE)			알림톡 템플릿코드  */
	private String sndPropkey;        /** CHAR(40 BYTE)				알림톡 발신프로필키  */
	private String bizCd;             /** VARCHAR2(10 BYTE)			업무코드  */
	private String bizTmplCd;         /** VARCHAR2(10 BYTE)			기업은행 템플릿코드(N개의 템플릿 대응)  */
	private String tmplNm;            /** VARCHAR2(400 BYTE)			템플릿 명  */
	private String tmplMsg;           /** VARCHAR2(2000 BYTE)		템플릿 내용  */
	private String btnInfo;           /** VARCHAR2(2000 BYTE)		버튼정보  */
	private String resndYn;           /** CHAR(1 BYTE)				재발송여부  */
	private String activeYn;          /** CHAR(1 BYTE)				활성여부  */
	private String regYms;            /** CHAR(14 BYTE)				등록일시  */
	private String updtYms;           /** CHAR(14 BYTE)				수정일시  */
	private String statusAd;          /** CHAR(1 BYTE)	NULL		광고표시여부  */
	private String blockNum;          /** VARCHAR2(15 BYTE)			수신거부번호  */
	private String typeGb;            /** VARCHAR2(3 BYTE)			RCS 템플릿 구분  */
	
	/* MTS 알림톡 확인결과  */
	//private String senderKey;				/* 발신 프로필 키 (senderKeyType 이 G 인경우발신 프로필그룹키)*/
	private String senderKeyType;           /* 발신 프로필 키 타입 (G:그룹 , S:발신프로필(default))*/
	//private String templateCode;            /* 템플릿 코드*/
	//private String templateName;            /* 템플릿 이름*/
	private String templateMessageType;     /* 템플릿 메시지 유형 (BA: 기본형, EX: 부가 정보형, AD: 광고 추가형, MI: 복*/
	private String templateEmphasizeType;   /* 템플릿 강조 유형 (NONE: 선택안함, TEXT: 강조표기형, IMAGE: 이미지형,*/
	private String templateContent;         /* 템플릿 내용*/
	private String templateExtra;           /* 부가 정보(템플릿 검수 가이드 참고)*/
	//private String templateAd;              /* 템플릿 내 수신 동의 요청 또는 간단 광고 문구 (템플릿 검수 가이드 참고)*/
	private String templateImageName;       /* 템플릿 이미지 파일명 (카카오 업로드 API 참조)*/
	private String templateImageUrl;        /* 템플릿 이미지 링크 (카카오 업로드 API 참조)*/
	private String templateTitle;           /* 템플릿 내용 중 강조 표기할 핵심 정보 (템플릿 검수 가이드 참고)*/
	private String templateSubtitle;        /* 강조 표기 보조 문구 (템플릿 검수 가이드 참고)*/
	private String templateHeader;          /* 헤더*/
	private String templateItemHighlight;   /* 아이템 하이라이트*/
	private String templateItem;            /* 아이템 리스트*/
	private String categoryCode;            /* 템플릿 카테고리 코드*/
	private String securityFlag;            /* 보안 템플릿 여부, OTP 등 보안 메시지 일 경우 설정. 발신 당시의 메인 디바이스를 제외한 모든 디바이스에 메시지 텍스트 미노출(디*/
	//private String buttons;                 /* 버튼 정보 (최대 5 개 등록 가능. 단, 바로연결과 함께 사용 시 2 개로 제한됨.)*/
	private String quickReplies;            /* 바로연결 정보 (최대 10 개 등록 가능)*/
	
	private String comment;			       	/* 의견 또는 문의사항  */
	private String attachment;              /* 업로드 할 파일의 절대 경로. 다수 파일 업로드 가능  */
	private String since;                   /* 기준시간 yyyyMMddHHmmss (default 는 요청한 시간부터 1 시간전)  */
	private String page;                    /* 페이지 (default : 1)  */
	private String count;                   /* 한 페이지에 조회할 건수(default: 1000)  */
	
	/* 화면에서 필요한 컬럼 추가 */
	private String regUserId;               /* 등록자  */
	private String updtUserId;               /* 수정자  */
	private String regUserNm;
	private String apprResult;        /**  APPR_RESULT;           */
	private String apprReqYmd;        /**  APPR_REQ_YMD;       승인요청일   */
	private String apprReqUserId;        /**  APPR_REQ_USER_ID;           */
	private String apprReqUserNm;        /**  APPR_REQ_USER_NM;           */
	private String apprYmd;           /**  APPR_YMD;            승인일  */	
    
	private String emplId; // 직원번호
}
