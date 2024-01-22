package com.ibk.msg.web.rcsBrand;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;

@Component
public class RcsBrandService {
	
	private static final Logger logger = LoggerFactory.getLogger(RcsBrandService.class);
	
	@Autowired
	private RcsBrandDao brandDao;
	
	@Autowired
	private RcsBrandChatbotDao chatbotDao;

	public PaginationResponse findRcsBrandByPagination(RcsBrandSearchCondition searchCondition) throws Exception {
	    Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
	    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

	    int totalCount = brandDao.findTotalCount(searchCondition);
	    List<RcsBrand> RcsBrands = brandDao.findRcsBrand(searchCondition);
	    	    								
	    return new PaginationResponse(searchCondition, totalCount, RcsBrands);
	 }
	 
	 /**
	  * RCS 브랜드 조회
	 * @param searchCondition
	 * @return
	 * @throws Exception
	 */
	public List<RcsBrand> findRcsBrand(RcsBrandSearchCondition searchCondition) throws Exception {
		 return brandDao.findRcsBrand(searchCondition);
	 }
	 
	 /**
	  * RCS 브랜드 저장(등록/수정)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveRcsBrand(RcsBrand param) throws Exception {
		 RcsBrandSearchCondition search = new RcsBrandSearchCondition();
		 search.setBrId(param.getBrId());
		 List<RcsBrand> brand = brandDao.findRcsBrand(search);
		 //param 데이터 다시 넣기
		int result = 0;
		if(brand.size() > 0) {
			result = brandDao.update(param);
			
		} else {
			result = brandDao.insert(param);
		}
		 return result;
	 }
	 
	 /**
	  * RCS 브랜드 삭제
	 * @param param RcsBrand
	 * @return
	 */
	@Transactional(transactionManager = "ibkSmsTxManager")
	public int removeRcsBrand(RcsBrand param) {
		int result = 0;
		result = brandDao.delete(param);

		RcsBrandSearchCondition search = new RcsBrandSearchCondition();
		search.setBrId(param.getBrId());
		List<RcsBrandChatbot> chatbotList = chatbotDao.findRcsBrandChatbot(search);
		
		if(chatbotList.size() > 0) {
			for(RcsBrandChatbot chatbot : chatbotList) {
				result = chatbotDao.delete(chatbot);	
			}
		}
		
        return result;
	 }
	 
	 public PaginationResponse findRcsBrandChatbotByPagination(RcsBrandSearchCondition searchCondition) throws Exception {
	    Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
	    Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

	    int totalCount = chatbotDao.findRcsBrandChatbotTotalCount(searchCondition);
	    List<RcsBrandChatbot> RcsBrands = chatbotDao.findRcsBrandChatbot(searchCondition);
	    	    								
	    return new PaginationResponse(searchCondition, totalCount, RcsBrands);
	 }
	 
	 /**
	  * 챗봇(발신번호) 조회
	 * @param searchCondition
	 * @return
	 * @throws Exception
	 */
	public List<RcsBrandChatbot> findRcsBrandChatbot(RcsBrandSearchCondition searchCondition) throws Exception {
		 return chatbotDao.findRcsBrandChatbot(searchCondition);
	 }
 
	 /**
	  * 챗봇(발신번호) 저장(등록/수정)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int saveRcsBrandChatbot(RcsBrandChatbot param) throws Exception {
		// update 후 result >0 이면 insert 하는것도 괜찮을 꺼같다
		RcsBrandSearchCondition search = new RcsBrandSearchCondition();
		search.setBrId(param.getBrId());
		search.setChatbotId(param.getChatbotId());
		List<RcsBrandChatbot> chatbot = chatbotDao.findRcsBrandChatbot(search);
		int result = 0;
		if(chatbot.size() > 0) {
			result = chatbotDao.update(param);
			
		} else {
			result = chatbotDao.insert(param);
		}
		 return result;
	 }
	 
	 /**
	  *챗봇(발신번호)  삭제
	 * @param param
	 * @return
	 */
	public int removeRcsBrandChatbot(RcsBrandChatbot param) {
        return chatbotDao.delete(param);
	 }
	 
}
