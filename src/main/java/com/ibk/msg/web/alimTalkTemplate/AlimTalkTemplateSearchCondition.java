package com.ibk.msg.web.alimTalkTemplate;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;

@Data
public class AlimTalkTemplateSearchCondition extends PaginationCondition {
	
	private String searchWordType;
	private String searchWord;
	
	private String orderType;
	private String orderName;
	
	private String statusType; // 상태
	
	private String kkoTmplCd;            /* 템플릿 코드*/
	
	private String emplId; // 직원번호

}
