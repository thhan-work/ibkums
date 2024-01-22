package com.ibk.msg.web.loglist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;

@Component
public class LogListService {
	
//  private static final Logger logger = LoggerFactory.getLogger(MessageService.class);

  @Autowired
  private LogListDao dao;

  public PaginationResponse findByPagination(LogListSearchCondition searchCondition)
      throws Exception {
    Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");
    
	searchCondition.setSearchStartDt(searchCondition.getSearchStartDt());
	searchCondition.setSearchEndDt(searchCondition.getSearchEndDt());
	
    String boCode = searchCondition.getBoCode();
    String emplId = searchCondition.getEmplId();
    String tranId = "CC" + boCode + "_" + emplId; 
    
    searchCondition.setBoCode(tranId);

    int totalCount = dao.findTotalCount(searchCondition);
    List<LogList> users = dao.findLogList(searchCondition);
    
    return new PaginationResponse(searchCondition, totalCount, users);
  }
  
  public LogList findDetail(String loglistId){
	  
	  return dao.findDetail(loglistId); 
  }

}
