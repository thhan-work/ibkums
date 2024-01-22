package com.ibk.msg.web.rcsTemplate;

import java.util.Map;

import lombok.Data;

@Data
public class RcsTemplate {
	private String rnum;
	
	/*  22.06.08 RCS_MSGBASE_REQ 컬럼*/
	private String seq;               /**  SEQ;                   */
	private String msgbaseId;         /**  MSGBASE_ID;            */
	private String msgbaseFormId;     /**  MSGBASE_FORM_ID;       */
	private String reqYmd;            /**  REQ_YMD;               */
	private String brId;              /**  BR_ID;                 */
	private String brNm;              /**  BR_NM;                 */
	private String agencyId;          /**  AGENCY_ID;             */
	private String productcode;       /**  PRODUCTCODE;           */
	private String spec;              /**  SPEC;                  */
	private String cardType;          /**  CARD_TYPE;             */
	private String msgbaseDesc;       /**  MSGBASE_DESC;          */
	private String status;            /**  STATUS;                */
	private String msgbaseAttribute;  /**  MSGBASE_ATTRIBUTE;     */
	private String policyInfo;        /**  POLICY_INFO;           */
	private String params;            /**  PARAMS;                */
	private String formattedString;   /**  FORMATTED_STRING;      */
	private String regUserId;         /**  REG_USER_ID;           */
	
	private String regUserNm;         /**  REG_USER_NM;     등록자 이름      */
	
	private String regDt;             /**  REG_DT;                */
	private String updateDt;          /**  UPDATE_DT;             */
	private String updateUserId;      /**  UPDATE_USER_ID;        */
	
	private String updateUserNm;      /**  UPDATE_USER_NM;  수정자 이름      */
	
	private String bizCondition;      /**  BIZ_CONDITION;         */
	private String bizCategory;       /**  BIZ_CATEGORY;          */
	private String bizService;        /**  BIZ_SERVICE;           */
	private String guideInfo;         /**  GUIDE_INFO;            */
	private String formParams;        /**  FORM_PARAMS;           */
	private String msgbaseNm;         /**  MSGBASE_NM;            */
	private String apprResult;        /**  APPR_RESULT;           */
	private String apprReason;        /**  APPR_REASON;           */
	private String apprReqYmd;        /**  APPR_REQ_YMD;       승인요청일   */
	
	private String apprReqUserId;        /**  APPR_REQ_USER_ID;           */
	private String apprReqUserNm;        /**  APPR_REQ_USER_NM;           */
	
	private String apprYmd;           /**  APPR_YMD;            승인일  */
	
	private String rcsBtnInfo; 			/* 버튼 노출 정보 */
	private String imageUrl;
	
	private String contentCell;		/* 스타일(cell) 내용 정보 JSON */
	
	/* RCS_MSGBASE */
	private String apprDt;           /**  APPR_DT;            승인일  */	
	
	private String emplId; // 직원번호
	
	/* TB_RCS_TMPL 컬럼*/
//	private String rcsTmplCd;	/** RCS_TMPL_CD    VARCHAR2(60 BYTE)           NULL,    RCS 템플릿코드     */
//	private String bizCd;       /** BIZ_CD         VARCHAR2(10 BYTE)           NULL,    업무코드     */
//	private String tmplNm;      /** TMPL_NM        VARCHAR2(400 BYTE)          NULL,    템플릿 명     */
//	private String tmplMsg;     /** TMPL_MSG       VARCHAR2(2000 BYTE)         NULL,    템플릿 내용     */
//	private String btnInfo;     /** BTN_INFO       VARCHAR2(2000 BYTE)         NULL,    버튼정보     */
//	private String resndYn;     /** RESND_YN       CHAR(1 BYTE)                NULL,    재발송여부     */
	//private String activeYn;    /** ACTIVE_YN      CHAR(1 BYTE)                NULL,    활성여부     */
//	private String regYms;      /** REG_YMS        CHAR(14 BYTE)               NULL,    등록일시     */
//	private String updtYms;     /** UPDT_YMS       CHAR(14 BYTE)               NULL,    수정일시     */
//	private String statusAd;    /** STATUS_AD      CHAR(1 BYTE)           DEFAULT NULL  광고표시여부     */
//	private String blockNum;    /** BLOCK_NUM      VARCHAR2(15 BYTE)           NULL,    수신거부번호     */
//	private String typeGb;      /** TYPE_GB        VARCHAR2(3 BYTE)            NULL     RCS 템플릿 구분     */

	public void setData(Map<String, Object> map) {
		this.seq                     =   (String) map.get("seq");
		this.msgbaseId               =   (String) map.get("msgbaseId");
		this.msgbaseFormId           =   (String) map.get("msgbaseFormId");
		this.reqYmd                  =   (String) map.get("reqYmd");
		this.brId                    =   (String) map.get("brId");
		this.agencyId                =   (String) map.get("agencyId");
		this.productcode             =   (String) map.get("productcode");
		this.spec                    =   (String) map.get("spec");
		this.cardType                =   (String) map.get("cardType");
		this.msgbaseDesc             =   (String) map.get("msgbaseDesc");
		this.status                  =   (String) map.get("status");
		this.msgbaseAttribute        =   (String) map.get("msgbaseAttribute");
		this.policyInfo              =   (String) map.get("policyInfo");
		this.params                  =   (String) map.get("params");
		this.formattedString         =   (String) map.get("formattedString");
		this.regUserId               =   (String) map.get("regUserId");
		this.regUserNm               =   (String) map.get("regUserNm");
		this.regDt                   =   (String) map.get("regDt");
		this.updateDt                =   (String) map.get("updateDt");
		this.updateUserId            =   (String) map.get("updateUserId");
		this.updateUserNm            =   (String) map.get("updateUserNm");
		this.bizCondition            =   (String) map.get("bizCondition");
		this.bizCategory             =   (String) map.get("bizCategory");
		this.bizService              =   (String) map.get("bizService");
		this.guideInfo               =   (String) map.get("guideInfo");
		this.formParams              =   (String) map.get("formParams");
		this.msgbaseNm               =   (String) map.get("msgbaseNm");
		this.apprResult              =   (String) map.get("apprResult");
		this.apprReason              =   (String) map.get("apprReason");
		this.apprReqYmd              =   (String) map.get("apprReqYmd");
		this.apprReqUserId           =   (String) map.get("apprReqUserId");
		this.apprReqUserNm           =   (String) map.get("apprReqUserNm");
		this.apprYmd                 =   (String) map.get("apprYmd");
		this.rcsBtnInfo 		     =   (String) map.get("rcsBtnInfo");
		this.imageUrl                =   (String) map.get("imageUrl");
		this.contentCell		     =   (String) map.get("contentCell");
		this.apprDt                  =   (String) map.get("apprDt");
	}
}

