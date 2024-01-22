package com.ibk.msg.web.rcsBrand;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;

@Data
public class RcsBrandSearchCondition extends PaginationCondition {
	private String rnum;

	private String searchWordType;
	private String searchWord;
	
	private String brId;
	private String chatbotId;
}
