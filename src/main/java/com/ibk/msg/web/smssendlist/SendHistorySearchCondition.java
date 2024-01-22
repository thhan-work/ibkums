package com.ibk.msg.web.smssendlist;

import com.ibk.msg.common.dto.PaginationCondition;

import lombok.Data;


@Data
public class SendHistorySearchCondition extends PaginationCondition {

	private String messageType; 			//메시지 구분
	private String messageTypeDetail; 		//세부 메시지 구분
	private int groupUniqNo; 				//그룹고유번호
	private String rowMsgDstic; 			//메시지유형
	private String historyTableNm;			//테이블명
	private String result;					//결과
	private String tranPhone;				//수신번호
}
