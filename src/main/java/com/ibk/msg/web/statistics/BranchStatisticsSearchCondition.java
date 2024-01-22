package com.ibk.msg.web.statistics;


import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class BranchStatisticsSearchCondition extends PaginationCondition {

	private String searchYear;
	private String searchMonth;
	private String branchCode;
	private String includeHead;
	
}
