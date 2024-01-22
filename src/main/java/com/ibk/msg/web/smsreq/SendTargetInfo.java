package com.ibk.msg.web.smsreq;

import com.ibk.msg.common.dto.PaginationCondition;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * TABLE: T28(TB_CMC_DRF003D)
 */
@EqualsAndHashCode(callSuper = false)
@Data
public class SendTargetInfo extends PaginationCondition {

	/** 순번 */
	private int rnum;
	/** 그룹회사코드 */
	private String groupCoCd;
	/** 등록기준일 */
	private String regStandardYmd;
	/** 대상자고유번호 */
	private int tagtUniqNo;
	/** 배치대상고유번호 */
	private int batchTagtUniqNo;
	/** 발송상태구분 */
	private String sendStusDstic;
	/** 폴링키 */
	private int plngKey;
	/** 폴링시각 */
	private String plngHms;
	/** 등록일시 */
	private String regYms;
	/** 휴대폰번호 */
	private String cphnNo;
	/** 수신번호주소 */
	private String recvNoAddress;
	/** 고객고유번호 */
	private String custUniqNo;
	/** 고객식별자 */
	private String custIdnfr;
	/** UMSID */
	private String umsid;
	/** 고객명 */
	private String custNm;
	/** 검증결과코드 */
	private String verifRsultCd;
	/** 검증결과코드명 */
	private String verifRsultCdNm;
	/** 업무서버접수식별자 */
	private String bzwkSevrRceptIdnfr;
	/** 입력원본 */
	private String inputOrigin;
	/** 치환변수규격 */
	private String replaceVariableStandard;
	/** 치환변수값 */
	private String replaceVariableVal;
	/** 원본요약값 */
	private String originSummaryVal;
	/** 고객관리번호 */
	private String custMgtNo;
	/** 발송직원ID */
	private String sendEmpid;
	/** 발송부점코드 */
	private String sendBrncd;

	/** 변수1 */
	private String variable1;
	/** 변수2 */
	private String variable2;
	/** 변수3 */
	private String variable3;
	/** 변수4 */
	private String variable4;
	/** 변수5 */
	private String variable5;
	/** 변수6 */
	private String variable6;
	/** 변수7 */
	private String variable7;
	/** 변수8 */
	private String variable8;
	/** 변수9 */
	private String variable9;
	/** 변수10 */
	private String variable10;
	/** 포맷등록일시 */
	private String regYmsFmt;
	/** 성공건수 */
	private int succCnt;
	/** 에러건수 */
	private int errCnt;
	/** 중복건수 */
	private int duplCnt;
}
