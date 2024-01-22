package com.ibk.msg.web.smsreq;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class RcsTemplateInfo {
	
	/**  */
	private int seq;
	/**  */
	private String msgbaseId;
	/**  */
	private String msgbaseFormId;
	/**  */
	private String reqYmd;
	/**  */
	private String brId;
	/** 대행사ID */
	private String agencyId;
	/** product code emum: sms/lms/mms/tmplt */
	private String productcode;
	/** richcard, openrichcard */
	private String spec;
	/** - Standalone - Standalone horizontal - Carousel - Description - Cell - Free */
	private String cardType;
	/** 템플릿인 경우 템플릿에 대한 설명 */
	private String msgbaseDesc;
	/** ready : 사용 pause : 사용중지 */
	private String status;
	/** 통계용 속성. Messagebaseform의 [bizCondition, bizCategory,bizService] 배열  ["금융 및 보험업", "금융", "승인"] ["소매업", "유통/이커머스", "주문"] ... */
	private String msgbaseAttribute;
	/** 검증정보 */
	private String policyInfo;
	/** 파라미터 */
	private String params;
	/** TTA RCS 규격을 기본으로 변수부를 삽입하는 방식으로 생성함 */
	private String formattedString;
	/** 등록자 */
	private String regUserId;
	/** 등록일시 */
	private String regDt;
	/** 수정일시 */
	private String updateDt;
	/** 수정자 */
	private String updateUserId;
	/** 업태 */
	private String bizCondition;
	/** 유형그룹(Description/Cell인 경우만)  일반 금융 유통/커머스 교통 엔터테인먼트 IT서비스 공공  */
	private String bizCategory;
	/** 승인 입금 출금 출고 주문 배송 예약 회원가입 인증 */
	private String bizService;
	/** 중계사 가이드용으로 MaaP FE에서 validation하지 않는다. */
	private String guideInfo;
	/** 검수 파라미터 */
	private String formParams;
	/** 메시지베이스 명 */
	private String msgbaseNm;
	/**  */
	private String apprResult;
	/**  */
	private String apprReason;
	/**  */
	private String apprReqYmd;
	/**  */
	private String apprYmd;
	/** 승인요청자 */
	private String apprReqUserId;
	/** 순번 */
	private int rnum;
	/** 카드유형(description, cell) 포맷 */
	private String fmtCardType;     
}