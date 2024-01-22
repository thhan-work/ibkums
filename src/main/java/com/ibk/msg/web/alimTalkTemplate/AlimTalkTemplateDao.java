package com.ibk.msg.web.alimTalkTemplate;

import java.util.List;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface AlimTalkTemplateDao {
	
	int findTotalCount(AlimTalkTemplateSearchCondition searchCondition);
	List<AlimTalkTemplate> findAlimTalkTemplate(AlimTalkTemplateSearchCondition searchCondition);
	
	int insert(AlimTalkTemplate param);
	int update(AlimTalkTemplate param);	
	int delete(AlimTalkTemplate param);	
	
	int approval(AlimTalkTemplate param);
	
	/* 알림톡 발신프로필 키 정보  */
	AlimTalkSndPropkey selectSndPropkeyInfo();

}
