package com.ibk.msg.web.smsreq;

import com.ibk.msg.common.dto.PaginationCondition;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class RcsTemplateSearchCondition extends PaginationCondition {
	
	private String regDt;     // 등록일시
	private String searchWord; // 검색어명
}
