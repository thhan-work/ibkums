package com.ibk.msg.web.email;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.web.loglist.LogListDao;

@Component
public class EmailService {
	
  private static final Logger logger = LoggerFactory.getLogger(EmailService.class);

  @Autowired
  private EmailDao dao;
  
  @Autowired
  private LogListDao logDao;

  public PaginationResponse findByPagination(EmailSearchCondition searchCondition)
      throws Exception {
    Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");
    
    int totalCount = dao.findTotalCount(searchCondition);
    List<Email> users = dao.findAllMessage(searchCondition);
    
    HashMap<String, String> pram = new HashMap<String, String>();
    String searchType = "";
    if(searchCondition.getSearchWordType().equals("email")){
    	searchType = "이메일주소:";
    }else if(searchCondition.getSearchWordType().equals("emplId")){
    	searchType = "고객번호:";
    }
    	
    String seachValue = "[EMAIL이력조회]"+ searchType + searchCondition.getSearchWord();
    
	pram.put("emplId", searchCondition.getEmplId());
	pram.put("seachValue", seachValue);
	pram.put("ipAdr", searchCondition.getEmplIp());
	logDao.msgHistoryLog(pram);
    
    return new PaginationResponse(searchCondition, totalCount, users);
  }

	public int modify(Email email) {
		return dao.resendUpdate(email);
	}

}
