package com.ibk.msg.web.template;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import com.ibk.msg.common.dto.PaginationResponse;

@Component
@ConfigurationProperties(prefix="spring")
public class TemplateService {

	private static final Logger logger = LoggerFactory.getLogger(TemplateService.class);

	@Autowired
	private TemplateDao dao;


	public PaginationResponse SelectAll(TemplateSearchCondition tc ) {

		int totalCount = dao.SelectAllCount(tc);
		List<Map<String,Object>> tmplList = dao.SelectAll(tc);

		return new PaginationResponse(tc, totalCount, tmplList);

	}
	
	public List<TemplateDTO> downloadSelectAll() {
		
		List<TemplateDTO> downloadlTmplList = dao.downloadSelectAll();
		return downloadlTmplList;
		
	}
	
	public PaginationResponse SelectCategory(TemplateSearchCondition tc ) {

		int totalCount = dao.SelectCategoryCount(tc); 
		List<Map<String,Object>> SelectCategory = dao.SelectCategory(tc);
		return new PaginationResponse(tc, totalCount, SelectCategory);

	}

	public TemplateSearchCondition TmplRegist(TemplateSearchCondition tc ) {

		dao.tmplRegist(tc);	
		return tc;

	}
	public TemplateSearchCondition TmplModify(TemplateSearchCondition tc ) {

		dao.tmplModify(tc);	
		return tc;

	}

	public Object ModifyInfo(TemplateSearchCondition tc ) {
		Map<String,Object> modifyInfo = dao.modifyInfo(tc);

		return modifyInfo;

	}
	
	public TemplateDTO selectTemplateBySeq(int MMS_IMG_ID) {
    	return dao.selectTemplateBySeq(MMS_IMG_ID);
    }
}
