package com.ibk.msg.web.smsUnsubscribe;

import com.ibk.msg.config.database.KiupSmsRepository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@KiupSmsRepository
public interface SmsUnsubscribeDao {


    int findTotalCount(SmsUnsubscribeSearchCondition userInfoSearchCondition);
    
    List<SmsUnsubscribeInfo> findUser(SmsUnsubscribeSearchCondition userInfoSearchCondition);

    void remove(String phone);
    
    void add(SmsUnsubscribeInfo userInfo);
    
    void modify(SmsUnsubscribeInfo userInfo);

    SmsUnsubscribeInfo findDetail(String emplId);

    int findDetailCount(String emplId);
}
