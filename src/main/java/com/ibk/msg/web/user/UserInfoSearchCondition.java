package com.ibk.msg.web.user;

import com.ibk.msg.common.dto.PaginationCondition;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class UserInfoSearchCondition extends PaginationCondition {

    private String searchUserType;
    private String searchWordType;
    private String searchWord;
    private String searchUseYn;
    private String adminYn; // 관리자 관리 시 조회 될 컬럼 추가 @Bora
    
    private String requestType; 	// 요청 타입 (SMS 발송화면 : send, 승인자 : ack , 관리자 : admin)
}
