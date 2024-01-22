package com.ibk.msg.web.smsreq;

import com.ibk.msg.common.dto.PaginationCondition;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class SmsReqEmployeeInfoSearchCondition extends PaginationCondition {

    private String searchWordType;
    private String searchWord;
    
    private String searchBoCode;
    
    /** 직책명 */
    private String positionNm;
    /** 부서코드 */
    private String boCode;
}
