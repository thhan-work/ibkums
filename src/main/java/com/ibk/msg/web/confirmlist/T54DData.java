package com.ibk.msg.web.confirmlist;

import lombok.Data;

@Data
public class T54DData {
	
	private String emn; // 직원번호
	private String sttgYmd; // 시작년월일
	private String fnshYmd; // 종료년월일
	private String dllzCdVl; // 근태코드값
	private String dllzCdNm; // 근태코드명
	private String vctnNdd; // 휴가일수
	private String sttgHms; // 시작시간
	private String fnshHms; // 종료시간
	private String wrpxEmn; // 대직자직원번호
	private String hltmDcd; // 반차구분코드
	
}
