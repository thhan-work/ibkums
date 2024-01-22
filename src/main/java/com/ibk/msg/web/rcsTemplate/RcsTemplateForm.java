package com.ibk.msg.web.rcsTemplate;

import lombok.Data;

/**
 * @author RYU
 *
 */
@Data
public class RcsTemplateForm {
	
	private String msgbaseFormId;             /** MSGBASE_FORM_ID;     */
	private String formName;                   /** FORM_NAME;           */
	private String productcode;                 /** PRODUCTCODE;         */
	private String spec;                        /** SPEC;                */
	private String cardType;                   /** CARD_TYPE;           */
	private String bizCcondition;               /** BIZ_CONDITION;       */
	private String bizCategory;                /** BIZ_CATEGORY;        */
	private String bizService;                 /** BIZ_SERVICE;         */
	private String policyInfo;                 /** POLICY_INFO;         */
	private String guideInfo;                  /** GUIDE_INFO;          */
	private String formParams;                 /** FORM_PARAMS;         */
	private String formattedString;            /** FORMATTED_STRING;    */
	private String mediaFileid;                /** MEDIA_FILEID;        */
	private String mediaUrl;                   /** MEDIA_URL;           */
	private String regDt;                      /** REG_DT;              */
	private String updateDt;                   /** UPDATE_DT;           */

}
