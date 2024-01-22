package com.ibk.msg.web.manage;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class CodeSearchCondition extends PaginationCondition {

	private String cmmnCd;
	private String searchWord;
	private String useYn;
	
}
