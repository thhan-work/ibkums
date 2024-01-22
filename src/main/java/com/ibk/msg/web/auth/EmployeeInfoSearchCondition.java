package com.ibk.msg.web.auth;

import com.ibk.msg.common.dto.PaginationCondition;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class EmployeeInfoSearchCondition extends PaginationCondition {

    private String searchWordType;
    private String searchWord;
}
