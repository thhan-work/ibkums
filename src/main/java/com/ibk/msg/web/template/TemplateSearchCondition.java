package com.ibk.msg.web.template;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;

@Data
public class TemplateSearchCondition extends PaginationCondition  {
	
	private String searchType;
	private String searchCategory;
	private String searchTitle;
	private String searchUseYn;

	private String MMS_IMG_ID;
	private String IMG_CTGY_NM;
	private String IMG_NM;
	private byte[] IMG_CON;
	private String IMG_TYPE_CD;
	private String USE_YN;
	private String MMS_USER_DFNT_CON;
	private String DVCD;
	private String EMN;
	private String RGSN_TS;
	private String MDFC_TS;
	private String IMG_SQN;
	private String IMAGE_PATH;
}
