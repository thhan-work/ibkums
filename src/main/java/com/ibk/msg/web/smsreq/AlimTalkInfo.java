package com.ibk.msg.web.smsreq;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class AlimTalkInfo {
	
	/** 순번 */
	private int rnum;          
	/** 알림톡 템플릿코드 */
	private String kkoTmplCd;
	/** 알림톡 발신프로필키 */
	private String sndPropkey;
	/** 업무코드 */
	private String bizCd;
	/** 기업은행 템플릿코드(N개의 템플릿 대응) */
	private String bizTmplCd;
	/** 템플릿 명 */
	private String tmplNm;
	/** 템플릿 내용 */
	private String tmplMsg;
	/** 버튼정보 */
	private String btnInfo;
	/** 재발송여부 */
	private String resndYn;
	/** 활성 여부 */
	private String activeYn;
	/** 등록일시 */
	private String regYms;
	/** 수정일시 */
	private String updtYms;
	/** 광고표시여부 */
	private String statusAd;
	/** 수신거부번호 */
	private String blockNum;
	/** 알림톡 템플릿코드 */
	private String typeGb;
	/** 발신 프로필 키 타입 (G:그룹 , S:발신프로필(default)) */
	private String senderKeyType;
	/** 템플릿 메시지 유형 (BA: 기본형, EX: 부가 정보형, AD: 광고 추가형, MI: 복 */
	private String templateMessageType;
	/** 템플릿 강조 유형 (NONE: 선택안함, TEXT: 강조표기형, IMAGE: 이미지형, */
	private String templateEmphasizeType;
	/** 부가 정보(템플릿 검수 가이드 참고) */
	private String templateExtra;
	/** 템플릿 이미지 파일명 (카카오 업로드 API 참조) */
	private String templateImageName;
	/** 템플릿 이미지 링크 (카카오 업로드 API 참조) */
	private String templateImageUrl;
	/** 템플릿 내용 중 강조 표기할 핵심 정보 (템플릿 검수 가이드 참고) */
	private String templateTitle;
	/** 강조 표기 보조 문구 (템플릿 검수 가이드 참고) */
	private String templateSubtitle;
	/** 헤더 */
	private String templateHeader;
	/** 아이템 하이라이트 */
	private String templateItemHighlight;
	/** 아이템 리스트 */
	private String templateItem;
	/** 템플릿 카테고리 코드 */
	private String categoryCode;
	/** 보안 템플릿 여부, OTP 등 보안 메시지 일 경우 설정. 발신 당시의 메인 디바이스를 제외한 모든 디바이스에 메시지 텍스트 미노출(디폴트는 미설정(N), 노출하려면 (Y)) */
	private String securityFlag;
	/** 바로연결 정보 (최대 10 개 등록 가능) */
	private String quickReplies;
	/** 의견 또는 문의사항 */
	private String comment;
	/** 업로드 할 파일의 절대 경로. 다수 파일 업로드 가능 */
	private String attachment;
	/** 기준시간 yyyyMMddHHmmss (default 는 요청한 시간부터 1 시간전) */
	private String since;
	/** 페이지 (default : 1) */
	private int page;
	/** 한 페이지에 조회할 건수(default: 1000 */
	private int count;
	/** 등록자 */
	private String regUserId;
	/** 수정자 */
	private String updtUserId;
	/** 승인 결과 */
	private String apprResult;
	/** 승인요청일 */
	private String apprReqYmd;
	/** 승인일 */
	private String apprYmd;
	/** 승인요청자 */
	private String apprReqUserId;
}