package com.ibk.msg.web.smsreq;

import com.ibk.msg.common.dto.PaginationCondition;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * TABLE: T26(TB_CMC_DRF003M)
 */
@EqualsAndHashCode(callSuper=false)
@Data
public class SendTargetMasterInfo extends PaginationCondition {
	
	/** 그룹회사코드 */
	private String groupCoCd;
	/** 배치대상고유번호 */
	private int batchTagtUniqNo;
	/** 등록기준일 */
	private String regStandardYmd;
	/** 배치대상명 */
	private String batchTagtNm;
	/** 입력시스템구분 */
	private String inputSystemDstic;
	/** 처리상태구분 */
	private String prcssStusDstic;
	/** 입력소스구분 */
	private String inputSourceDstic;
	/** 총거수 */
	private int totNumber;
	/** 전처리구분 */
	private String bfPrcssDstic;
	/** 폴링키 */
	private int plngKey;
	/** 폴링시각 */
	private String plngHms;
	/** 등록일시 */
	private String regYms;
	/** 입력소스상세 */
	private String inputSourceDetail;
	/** 등록직원번호 */
	private String regEmpNo;
	/** 사용완료여부 */
	private String useFinishYn;
	/** 부점코드 */
	private String brncd;
	/** 업무채널코드 */
	private String bzwkChnlCd;
	/** 메시지구분 */
	private String msgDstic;
	/** 검증결과코드 */
	private String verifRsultCd;
	/** 검증결과설명 */
	private String verifRsultDetail;
	/** 치환변수값 */
	private String replaceVariableVal;
	/** 치환변수규격 */
	private String replaceVariableStandard;
	
	
	/** 배치대상고유번호(파라미터값) */
	private String targetId;
	/** 처리상태구분코드 포맷 */
	private String status;
	
	//-----------custom-------------                     
	private String targetFileId;     // 대상자fileId 
}
