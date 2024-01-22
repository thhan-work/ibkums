package com.ibk.msg.web.sendstatistics;


import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class StatisticsSearchCondition extends PaginationCondition {

	private String sendType;
	private String dateType;
	private String partNm;
	private String regNm;
	private String searchStartDt;
	private String searchEndDt;
	private String messageType; 		//메시지 구분
	private String messageTypeDetail; 	//세부 메시지 구분
	private String statisticsType; 		//통계 구분

}
