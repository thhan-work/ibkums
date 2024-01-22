package com.ibk.msg.web.rcsTemplate;

import java.util.List;
import java.util.Map;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface RcsTemplateDao {
	/* RCS_MSGBASE_REQ */
	List<Map<String, Object>> selectRcsBizService(String cardType);

	int findTotalCount(RcsTemplateSearchCondition searchCondition);
	List<RcsTemplate> findRcsTemplate(RcsTemplateSearchCondition searchCondition);

	int insertRcsReq(RcsTemplate rcsTemplate);
	int updateRcsReq(RcsTemplate rcsTemplate);	
	int deleteRcsReq(RcsTemplate rcsTemplate);	
	
	int approvalRcsReq(RcsTemplate rcsTemplate);
	
	Map<String, Object> selectRcsTemplateDBYmd();
	
	/* RCS_MSGBASE_FROM */
	RcsTemplateForm selectRcsForm(RcsTemplate rcsTemplate);

	/*	RCS_MSGBASE (모듈 사용시 :  모듈에서  추가, 수동일시 : UMS에서 추가)	 */
	List<RcsTemplateBase> selectRcsTemplateBase(RcsTemplateBase rcsTemplateBase);
	int insertRcsBase(RcsTemplateBase rcsTemplateBase);
	int updateRcsBase(RcsTemplateBase rcsTemplateBase);	
	int deleteRcsBase(RcsTemplateBase rcsTemplateBase);	
	
	int approvalRcsBase(RcsTemplateBase rcsTemplateBase);
}
