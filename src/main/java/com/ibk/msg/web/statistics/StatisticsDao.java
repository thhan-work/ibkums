package com.ibk.msg.web.statistics;

import java.util.List;
import java.util.Map;

import com.ibk.msg.config.database.KiupSmsRepository;

@KiupSmsRepository
public interface StatisticsDao {

	int findTotalBranchCount(BranchStatisticsSearchCondition branchStatisticsSearchCondition);
	List<BranchStatisticsData> findBranch(BranchStatisticsSearchCondition branchStatisticsSearchCondition);
	List<Map<Object, Object>> findBranchExcel(BranchStatisticsSearchCondition branchStatisticsSearchCondition);
	
	int findTotalChannelCount(ChannelStatisticsSearchCondition channelStatisticsSearchCondition);
	List<ChannelStatisticsData> findChannel(ChannelStatisticsSearchCondition channelStatisticsSearchCondition);
	List<Map<Object, Object>> findChannelExcel(ChannelStatisticsSearchCondition channelStatisticsSearchCondition);
	
	int findTotalFailureCount(FailureStatisticsSearchCondition failureStatisticsSearchCondition);
	List<FailureStatisticsData> findFailure(FailureStatisticsSearchCondition failureStatisticsSearchCondition);
	List<Map<Object, Object>> findFailureExcel(FailureStatisticsSearchCondition failureStatisticsSearchCondition);
	
	int findTotalVendorCount(VendorStatisticsSearchCondition vendorStatisticsSearchCondition);
	List<VendorStatisticsData> findVendor(VendorStatisticsSearchCondition vendorStatisticsSearchCondition);
	List<Map<Object, Object>> findVendorExcel(VendorStatisticsSearchCondition vendorStatisticsSearchCondition);
	
	List<SendData> findSend(Map<String, String> param);	
	List<SendGroupData> findSendGroup(Map<String, String> param);
	int changeSendGroupStatus(Map<String, Object> param);
}
