package com.ibk.msg.web.smsreq;

import com.ibk.msg.common.dto.PaginationCondition;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class AlimTalkSearchCondition extends PaginationCondition {
	
	private String regYms;        // 등록일시
	private String searchWord;    // 검색어명
	private String kkoTmplCd;  //알림톡템플릿ID
}
