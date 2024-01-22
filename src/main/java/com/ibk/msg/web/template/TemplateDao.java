package com.ibk.msg.web.template;

import java.util.List;
import java.util.Map;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface TemplateDao {
	List<Map<String, Object>> SelectAll(TemplateSearchCondition tc);
	List<TemplateDTO> downloadSelectAll();

	int SelectAllCount(TemplateSearchCondition tc);
	
	void tmplRegist(TemplateSearchCondition tc);
	
	void tmplModify(TemplateSearchCondition tc);
	
	List<Map<String, Object>> SelectCategory(TemplateSearchCondition tc);
	int SelectCategoryCount(TemplateSearchCondition tc);
	Map<String, Object> modifyInfo(TemplateSearchCondition tc);
	TemplateDTO selectTemplateBySeq(int MMS_IMG_ID);
}
