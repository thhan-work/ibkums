package com.ibk.msg.web.reservedmessage;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.web.loglist.LogListDao;

@Component
public class ReservedMessageService {


  @Autowired
  private ReservedMessageDao dao;
  
  @Autowired
  private LogListDao logDao;

  public PaginationResponse findByPagination(ReservedMessageSearchCondition searchCondition)
	      throws Exception {
	    Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
	    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");
	    
    	searchCondition.setRegDt(searchCondition.getSearchStartDt().substring(0,6));
    	
	    String boCode = searchCondition.getBoCode();
	    String emplId = searchCondition.getEmplId();
	    String tranId = "CC" + boCode + "_" + emplId; 
	    
	    searchCondition.setBoCode(tranId);
	    
	    int totalCount = dao.findTotalCount(searchCondition);
	    List<ReservedMessage> users = dao.findReservedMessage(searchCondition);
	    
	    HashMap<String, String> pram = new HashMap<String, String>();
	    String seachValue = "[예약 메시지]시작일:"+searchCondition.getSearchStartDt() + "종료일:" + searchCondition.getSearchEndDt() + "휴대폰번호:" + searchCondition.getSearchPhoneNumber();
	    
		pram.put("emplId", emplId);
		pram.put("seachValue", seachValue);
		pram.put("ipAdr", searchCondition.getEmplIp());
		logDao.msgHistoryLog(pram);
	    
	    return new PaginationResponse(searchCondition, totalCount, users);
	  }

	  public Object cancel(List<ReservedMessage> reservedmessageList) {
		int total = 0;  
		int count = 0;
		
		for(ReservedMessage reservedmessage : reservedmessageList){
			
			Preconditions.checkArgument(StringUtils.isNoneBlank(reservedmessage.getMessageType()), "MessageType is empty");
			Preconditions.checkArgument(reservedmessage.getId() > 0, "reservedmessage id empty");
			
		    String boCode = reservedmessage.getBoCode();
		    String emplId = reservedmessage.getEmplId();
		    String tranId = "CC" + boCode + "_" + emplId; 
		    
		    reservedmessage.setBoCode(tranId);
			reservedmessage.setMessageType(reservedmessage.getMessageType());
			dao.cancel(reservedmessage);
			count++;
		}
		total += count;
	    return total;
	  }
	  
}
