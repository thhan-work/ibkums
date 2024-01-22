package com.ibk.msg.web.reservationStatus;

import lombok.Data;

@Data
public class ReservationStatus {
	private String rnum;
	
    private String groupNm;				//기안명
    private String sectionNumber;		//발송 건수
    private String msgDstic;				//메시지 타입
    private String pengagYms;			//발송 일시
    private String emplName;				//기안자
    private String partName;				//기안부서
}
