package com.ibk.msg.web.alimTalkTemplate;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;
import com.ibk.msg.utils.RcsTemplateUtils;

@Component
public class AlimTalkTemplateService {
	
	private static final Logger logger = LoggerFactory.getLogger(AlimTalkTemplateService.class);
	
	@Autowired
	private AlimTalkTemplateDao dao;
	
	public PaginationResponse findRcsTemplateByPagination(AlimTalkTemplateSearchCondition searchCondition) throws Exception {
	    Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
	    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

	    int totalCount = dao.findTotalCount(searchCondition);
	    List<AlimTalkTemplate> alimTalkTemplate = dao.findAlimTalkTemplate(searchCondition);
	    	    								
	    return new PaginationResponse(searchCondition, totalCount, alimTalkTemplate);
	  }
	
	public List<AlimTalkTemplate> findAlimTalkTemplate(AlimTalkTemplateSearchCondition searchCondition) throws Exception {
	   	    								
	   return dao.findAlimTalkTemplate(searchCondition);
	}
	
	 public Integer saveAlimTalkTemplate(AlimTalkTemplate param) throws Exception {
		 
		param = RcsTemplateUtils.AlimTalkBtnStringToJson(param);
		
		// 22.09.28 알림톡 발신프로필 키 - SEQ 최신 데이터 1개만 조회
		AlimTalkSndPropkey  alimTalkSndPropkey =  dao.selectSndPropkeyInfo();
		param.setSndPropkey(alimTalkSndPropkey.getSndPropkey());
		
		String isCreate = param.getMode();
		int result = 0;
		if( "C".equals(isCreate)) {
			AlimTalkTemplateSearchCondition search = new AlimTalkTemplateSearchCondition();
			search.setKkoTmplCd(param.getKkoTmplCd());
			List<AlimTalkTemplate> selectList = dao.findAlimTalkTemplate(search);
			if(selectList.size() > 0) {
				//throw new Exception("이미 존재하는 코드입니다.");
				logger.warn("이미 존재하는 코드입니다.");
				result = 99;
			} else {
				param.setRegUserId( param.getEmplId() );
				result = dao.insert(param);
			}
			
		} else {
			param.setApprResult("저장");
			param.setUpdtUserId( param.getEmplId() );
			result = dao.update(param);
		}
			
		 return result;
	 }
	 
	 public Integer deleteAlimTalkTemplate(AlimTalkTemplate param) throws Exception {
			
		 int result = 0;
		 result = dao.delete(param);
		 
		 return result;
	 }
	 
	 public Integer approvalAlimTalkTemplate(AlimTalkTemplate param) throws Exception {
		 int result = 0;
		 result = dao.approval(param);
		 
		 return result;
	 }

}
