package com.ibk.msg.web.statistics;

import lombok.Data;

@Data
public class FailureStatisticsData {

	private String msgDstic;
	private String failureDesc;
	private String failureCode;
	private String vendor;
	private int failureNumber;
	
}
