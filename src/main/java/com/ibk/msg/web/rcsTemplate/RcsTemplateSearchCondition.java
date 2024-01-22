package com.ibk.msg.web.rcsTemplate;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;

@Data
public class RcsTemplateSearchCondition extends PaginationCondition {
	private String rnum;

	private String searchWordType;
	private String searchWord;
	
	private String orderType;
	private String orderName;
	
	private String bizServiceType; // 템플릿 속성
	private String cardType; // 템플릿 유형
	private String statusType; // 상태
	
	private String emplId; // 직원번호

	/* API 연동여부 (= 자동여부 _ 자동 <-> 수동) */
	private Boolean rcsApiCmnct;	
}
