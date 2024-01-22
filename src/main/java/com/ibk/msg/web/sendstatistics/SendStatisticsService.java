package com.ibk.msg.web.sendstatistics;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SendStatisticsService {

	@Autowired
	private SendStatisticsDao dao;
	
	/**
	 * 발송통계(일별/월별/부서별) 조회
	 * @param searchCondition
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> findStatisticsListAjax(StatisticsSearchCondition searchCondition)
			throws Exception {
		
		Map<String, Object> statisticsMap = new HashMap<String, Object>();

		StatisticsData totalCount = new StatisticsData();
		List<StatisticsData> totalCountGroupByMonth = new ArrayList<>();
		List<StatisticsData> totalCountGroupByDepartment = new ArrayList<>();
		List<StatisticsData> statisticsList = new ArrayList<>();
		
		if(searchCondition.getSearchStartDt() != null) {
			if("daily".equals(searchCondition.getStatisticsType())) {					// 일별
				totalCount = dao.dailyStatisticsTotalCount(searchCondition);
				statisticsList = dao.dailyStatisticsList(searchCondition);
			} else if("monthly".equals(searchCondition.getStatisticsType())) {			// 월별	
				totalCount = dao.monthlyStatisticsTotalCount(searchCondition);
				statisticsList = dao.monthlyStatisticsList(searchCondition);
				totalCountGroupByMonth = dao.totalCountGroupByMonth(searchCondition);
			} else if("department".equals(searchCondition.getStatisticsType())) { 	// 부서별
				totalCount = dao.departmentStatisticsTotalCount(searchCondition);
				statisticsList = dao.departmentStatisticsList(searchCondition);
				totalCountGroupByDepartment = dao.totalCountGroupByDepartment(searchCondition);
			}
		}

		statisticsMap.put("totalCountGroupByMonth", totalCountGroupByMonth);
		statisticsMap.put("totalCountGroupByDepartment", totalCountGroupByDepartment);
		statisticsMap.put("totalCount", totalCount);
		statisticsMap.put("statisticsList", statisticsList);
		
		return statisticsMap;
	}

}
