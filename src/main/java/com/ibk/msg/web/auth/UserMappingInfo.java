package com.ibk.msg.web.auth;

import lombok.Data;

@Data
public class UserMappingInfo {
	private String boCode;		//	부서코드
	private String emplId;		//	직원번호
	private String emplIp;		//	직원 IP
	private String emplLevel;		//	직원권한수준
	private String emplName;		//	직원명
	private String loginId;		//	로그인ID
	private String useIpCheck;		//	접속IP체크 여부
	private String useYn;		//	활성화 유무
}