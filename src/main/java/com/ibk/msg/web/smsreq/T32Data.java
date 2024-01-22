package com.ibk.msg.web.smsreq;

import lombok.Data;

@Data
public class T32Data {

	private String groupUniqNo;		//그룹고유번호
	private String emplId;				//승인자ID
	private String agreeType;			//승인타입
	private String agreeStatus;		//승인상태
	private String requestsYms;		//요청일시
	private String confirmYms;		//완료일시
	private String drafterNm;			//기안자
	
	private String emplHpNo; // 승인자 핸드폰번호(승인자타입 : 4)
	
	private String positionCallname;		//직급
    private String partName;				// 부서명
    private String emplName;				//
    private String emplClass;				//
    private String viewDataYn;			//T32데이터 인지 아닌지 (Y:T32 존재, N:T32미존재) - 2차,3차 예상결재자 정보 VIEW
}
