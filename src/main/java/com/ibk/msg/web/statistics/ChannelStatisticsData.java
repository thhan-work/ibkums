package com.ibk.msg.web.statistics;

import lombok.Data;

@Data
public class ChannelStatisticsData {
	
	private String rnum;
	private String msgDstic;
	private String jobName;
	private String jobCode;
	private int successNumber;
	private int requestsNumber;

}
