package com.ibk.msg.web.rcsBrand;

import java.util.List;
import java.util.Map;

import com.ibk.msg.config.database.IbkRepository;

@IbkRepository
public interface RcsBrandDao {
	int findTotalCount(RcsBrandSearchCondition searchCondition);
	List<RcsBrand> findRcsBrand(RcsBrandSearchCondition searchCondition);

	int insert(RcsBrand rcsBrand);
	int update(RcsBrand rcsBrand);	
	int delete(RcsBrand rcsBrand);	
}
