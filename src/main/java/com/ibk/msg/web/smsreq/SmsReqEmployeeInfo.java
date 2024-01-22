package com.ibk.msg.web.smsreq;

import com.ibk.msg.web.auth.EmployeeInfo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class SmsReqEmployeeInfo extends EmployeeInfo{
    //EMPL_ID 이 사용자아이디인듯 싶으니, 이것으로 통일
    //EMPL_CLASS 확실하진 않지만, 이게 분류로 구분하는데 사용해도 되겠다.
    //0 : 일반사용자, 1: 직원용 SMS 발송 등록자, 2: 승인자, 9: 관리자   로 정의해두고 사용하자.
    //PW가 없다.

    private String positionCallname;
    private String partName;
    private int rnum;
}