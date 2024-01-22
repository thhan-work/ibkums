package com.ibk.msg.web.common;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.stereotype.Component;

import com.ibk.msg.web.manage.Code;

@Component
@PropertySources({
	@PropertySource("classpath:local.properties")
	, @PropertySource(value="classpath:${spring.profiles.active}.properties", ignoreResourceNotFound=true)
})
public class CommonService {
	private static final Logger logger = LoggerFactory.getLogger(CommonService.class);

	@Autowired
	private CommonDao commonDao;
	
	/**
	 * 공통코드 조회
	 * @param param
	 * @return
	 */
	public HashMap<String, List<Code>> selectCodeList(String[] codes) {
		HashMap<String, List<Code>> codeMap = new HashMap<>();
		try {
			if(codes != null) {
				for(String code : codes) {
					List<Code> list = commonDao.selectCodeList(code);
					codeMap.put(code, list);
				}
			}
		} catch(Exception e) {
			logger.error("[공통코드 조회 에러]" + e.getMessage());
		}
		return codeMap;
	}
}
