package com.ibk.msg.web.sendstatistics;

import java.util.List;

import com.ibk.msg.config.database.KiupSmsRepository;

@KiupSmsRepository
public interface SendStatisticsDao {
	StatisticsData dailyStatisticsTotalCount(StatisticsSearchCondition searchCondition);
	List<StatisticsData> dailyStatisticsList(StatisticsSearchCondition searchCondition);
	
	StatisticsData monthlyStatisticsTotalCount(StatisticsSearchCondition searchCondition);
	List<StatisticsData> totalCountGroupByMonth(StatisticsSearchCondition searchCondition);
	List<StatisticsData> monthlyStatisticsList(StatisticsSearchCondition searchCondition);
	
	StatisticsData departmentStatisticsTotalCount(StatisticsSearchCondition searchCondition);
	List<StatisticsData> totalCountGroupByDepartment(StatisticsSearchCondition searchCondition);
	List<StatisticsData> departmentStatisticsList(StatisticsSearchCondition searchCondition);
}
