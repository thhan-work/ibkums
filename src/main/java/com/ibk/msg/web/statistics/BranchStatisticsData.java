package com.ibk.msg.web.statistics;

import lombok.Data;

@Data
public class BranchStatisticsData {

	private String rnum;
	private String distHeader;
	private String branchCode;
	private String branchName;
	private int sms;
	private int lms;
	private int mms;
	
}
