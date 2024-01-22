package com.ibk.msg.web.msgform;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ibk.msg.common.dto.PaginationResponse;

@Component
public class MsgFormService {
	
	private static final Logger logger = LoggerFactory.getLogger(MsgFormService.class);

	@Autowired
	private MsgFormDao dao;

	/**
	 * 해피콜 및 본부양식 리스트 조회
	 * 
	 * @param req_msgforminfo
	 * @return
	 * @throws SQLException
	 */
	public PaginationResponse getMMSMsgFormList(MsgFormSearchCondition req_msgforminfo) throws SQLException
	{
		PaginationResponse pr =null;
		try {
		   // count 조회
		int resultCount = dao.getMMSMsgFormListCount(req_msgforminfo);
		// data list 조회
		List<MsgFormSearchCondition> resultList = dao.getMMSMsgFormList(req_msgforminfo);
		
		if(resultList.size() > 0)
		{
			MsgFormSearchCondition rs0 = resultList.get(0);
			rs0.setCode(req_msgforminfo.getCode());
			rs0.setDivision(req_msgforminfo.getDivision());
		}
		
		//페이징 처리
		pr = new PaginationResponse(req_msgforminfo, resultCount, resultList);
		    
		} catch (Exception ex) {
		    logger.error("EXP", "MsgFormMgr.getMMSMsgFormList()", ex);
		} 

		return pr;
	}

	/**
	 * 부서서식함 리스트 조회
	 * 
	 * @param msgform
	 * @return
	 */
	public PaginationResponse getMMSMyMsgList(MsgFormSearchCondition msgform) {

		PaginationResponse pr =null;
        try {
        	int resultCount = dao.getMMSMyMsgListCount(msgform);
        	List<MsgFormSearchCondition> resultList = dao.getMMSMyMsgList(msgform);
    		
        	if(resultList.size() > 0)
    		{
    			MsgFormSearchCondition rs0 = resultList.get(0);
    			rs0.setCode(msgform.getCode());
    			rs0.setDivision(msgform.getDivision());
    		}
        	
    		//페이징 처리
    		pr = new PaginationResponse(msgform, resultCount, resultList);
    		
        } catch (Exception ex) {
            logger.error("EXP", "MsgFormMgr.getMyMsgList()", ex);
        }

        return pr;
	}
  
	/**
	 * 개인서식함 리스트 조회
	 * 
	 * @param msgform
	 * @return
	 */
	public PaginationResponse getMMSMyList(MsgFormSearchCondition msgform) {
		PaginationResponse pr =null;

        try {
        	int resultCount = dao.getMMSMyListCount(msgform);
        	List<MsgFormSearchCondition> resultList = dao.getMMSMyList(msgform);
        	
        	if(resultList.size() > 0)
    		{
    			MsgFormSearchCondition rs0 = resultList.get(0);
    			rs0.setCode(msgform.getCode());
    			rs0.setDivision(msgform.getDivision());
    		}
        	
    		//페이징 처리
    		pr = new PaginationResponse(msgform, resultCount, resultList);

        } catch (Exception ex) {
            logger.error("EXP", "MsgFormMgr.getMMSMyList()", ex);
        } 
        
        return pr;
	}
	
	
	
	/**
	 * 개인사서함에 이동 저장
	 * @param msgform
	 * @return
	 */
	public int addMMSMyMsg(MsgFormSearchCondition msgform) {
        int rslt = -1;

    	try {
            rslt = dao.addMMSMyMsg(msgform);

        } catch (Exception ex) {
            logger.error("EXP", "MsgFormMgr.addMMSMyMsg()", ex);
        }

        return rslt;
	}

	/**
	 * 부서서식함 메시지 삭제
	 * 
	 * @param msgform
	 * @return
	 */
	public int delMMSMyMsgList(MsgFormSearchCondition msgform) {
        int rslt = -1;

        try {
        	rslt = dao.delMMSMyMsgList(msgform);

        } catch (Exception ex) {
            logger.error("EXP", "MsgFormMgr.delMyMsgList()", ex);
        }

        return rslt;
	}

	/**
	 * 개인서식함 메시지 삭제
	 * 
	 * @param msgform
	 * @return
	 */
	public int deleteMMSMyMsg(MsgFormSearchCondition msgform) {
        int rslt = -1;

        try {
        	rslt = dao.deleteMMSMyMsg(msgform);

        } catch (Exception ex) {
            logger.error("EXP", "MsgFormMgr.deleteMyMsg()", ex);
        } 
        
        return rslt;
	}

	/**
	 * 부서서식함 메시지 추가
	 * 
	 * @param msgform
	 * @return
	 */
	public int addMMSMyMsgInfo(MsgFormSearchCondition msgform) {
        int rslt = -1;

        try {
        	rslt = dao.addMMSMyMsgInfo(msgform);

        } catch (Exception ex) {
            logger.error("EXP", "MsgFormMgr.addMyMsgInfo()", ex);
        }
        
        return rslt;
	}

}
