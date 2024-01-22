package com.ibk.msg.web.manage;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class CodeGroupSearchCondition extends PaginationCondition {

	private String searchWordType;
	private String searchWord;
	private String useYn;
}
