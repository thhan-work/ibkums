package com.ibk.msg.web.eventsend;

import com.ibk.msg.web.user.UserInfo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class PartInfo extends UserInfo{
	
	/** 부서 코드 */
	public String boCode;
	/** 부서 이름 */
	public String partName;
	/** 부서 지역코드 */
	public String partGrcd;
	/** 지역 명 */
	public String partGrcdSqua;
	/** 부서 전화 */
	public String partPNo;
	/** 메시지한도(사용하지 않음) */
	public String partSmsQua;
	/** 부서 비밀번호 */
	public String partPwd;
	/** 메시지 사용량(사용하지 않음) */
	public int partSmsUsequa = 0;
	/** 비밀번호 변경자(사원이름_사원번호) */
	public String pwdChangeUser;
	/** 비밀번호 힌트 질문 */
	public String pwdHintQ;
	/** 비밀번호 힌트 답변 */
	public String pwdHintA;
	/** 비밀번호 변경일 */
	public String pwdChangeDate;
	/** 삭제여부(1: 삭제, 0: 사용중) */
	public String dFlag;
	
	//직급코드
	String classCode;
	//직급명
	String className;
	
	//직위코드
	String positionCode;
	//직위명
	String positionCallname;
	
	//
	String emplHpNo;
}
