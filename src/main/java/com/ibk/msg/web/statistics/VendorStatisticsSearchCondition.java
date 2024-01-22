package com.ibk.msg.web.statistics;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class VendorStatisticsSearchCondition {

	private String searchYear;
	private String searchMonth;
	private String vendor;
}
