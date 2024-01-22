package com.ibk.msg.web.rcsBrand;

import java.util.List;
import java.util.Map;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface RcsBrandChatbotDao {
	int findRcsBrandChatbotTotalCount(RcsBrandSearchCondition searchCondition);
	List<RcsBrandChatbot> findRcsBrandChatbot(RcsBrandSearchCondition searchCondition);

	int insert(RcsBrandChatbot brandChatbot);
	int update(RcsBrandChatbot brandChatbot);	
	int delete(RcsBrandChatbot brandChatbot);	
}
