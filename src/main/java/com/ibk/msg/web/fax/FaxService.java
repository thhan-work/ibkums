package com.ibk.msg.web.fax;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.web.eventsend.PartInfo;
import com.ibk.msg.web.loglist.LogListDao;

@Component
public class FaxService {
	
  private static final Logger logger = LoggerFactory.getLogger(FaxService.class);

  @Autowired
  private FaxDao dao;
  
  @Autowired
  private LogListDao logDao;

  public PaginationResponse findByPagination(FaxSearchCondition searchCondition)
      throws Exception {
    Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");
    
    int totalCount = dao.findTotalCount(searchCondition);
    List<Fax> users = dao.findAllMessage(searchCondition);
    
    HashMap<String, String> pram = new HashMap<String, String>();
    String searchType = "";
    if(searchCondition.getSearchWordType().equals("sendReq")){
    	searchType = "발신번호:";
    }else if(searchCondition.getSearchWordType().equals("faxNo")){
    	searchType = "FAX번호:";
    }
    	
    String seachValue = "[FAX이력조회]시작일:"+searchCondition.getSearchStartDt() + "종료일:" + searchCondition.getSearchEndDt() + searchType + searchCondition.getSearchWord();
    
	pram.put("emplId", searchCondition.getEmplId());
	pram.put("seachValue", seachValue);
	pram.put("ipAdr", searchCondition.getEmplIp());
	logDao.msgHistoryLog(pram);
    
    return new PaginationResponse(searchCondition, totalCount, users);
  }

}
