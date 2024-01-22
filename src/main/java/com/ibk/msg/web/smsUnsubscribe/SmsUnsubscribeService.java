package com.ibk.msg.web.smsUnsubscribe;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;

@Component
public class SmsUnsubscribeService {

    @Autowired
    private SmsUnsubscribeDao dao;


    public PaginationResponse findByPagination(SmsUnsubscribeSearchCondition searchCondition)
            throws Exception {
        Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
        Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

        int totalCount = dao.findTotalCount(searchCondition);
        List<SmsUnsubscribeInfo> users = dao.findUser(searchCondition);
        return new PaginationResponse(searchCondition, totalCount, users);
    }

    @Transactional(transactionManager = "ibkSmsTxManager")
    public Set remove(String[] phoneArr, HttpSession session) {
    	Preconditions.checkArgument(StringUtils.isNoneBlank(phoneArr), "phoneArr is empty");
    	
        Set resultSet = new HashSet();
        for (String phone : phoneArr) {
            dao.remove(phone);
            resultSet.add(phone);
        }
        return resultSet;
    }
    
    
    public String add(SmsUnsubscribeInfo smsUnsubscribeInfo) {
        Preconditions.checkArgument(StringUtils.isNoneBlank(smsUnsubscribeInfo.getEnlister()), "Enlister is empty");

        dao.add(smsUnsubscribeInfo);
        return smsUnsubscribeInfo.getEnlister();
    }


    public Object modify(SmsUnsubscribeInfo smsUnsubscribeInfo) {
        Preconditions.checkArgument(StringUtils.isNoneBlank(smsUnsubscribeInfo.getEnlister()), "Enlister is empty");

        dao.modify(smsUnsubscribeInfo);
        return smsUnsubscribeInfo.getEnlister();
    }

    public SmsUnsubscribeInfo findDetail(String phone) {
        return dao.findDetail(phone);
    }

    public int findDetailCount(String phone) {
        return dao.findDetailCount(phone);
    }
}
