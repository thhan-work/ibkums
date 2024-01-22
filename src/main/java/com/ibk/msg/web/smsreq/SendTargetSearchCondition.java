package com.ibk.msg.web.smsreq;

import com.ibk.msg.common.dto.PaginationCondition;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class SendTargetSearchCondition extends PaginationCondition {
	
	private String custNm;           // 고객명
	private String custUniqNo;       // 고객번호
	private String cphnNo;           // 핸드폰번호
	private String duplicateCheckYn; // 중복체크여부
	private String batchTagtUniqNo;  // 배치대상고유번호
}
