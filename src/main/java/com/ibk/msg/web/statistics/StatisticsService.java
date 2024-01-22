package com.ibk.msg.web.statistics;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.common.base.Preconditions;
import com.ibk.msg.common.dto.PaginationResponse;

@Component
public class StatisticsService {

	@Autowired
	private StatisticsDao dao;

	public PaginationResponse findBranchStatisticsByPagination(BranchStatisticsSearchCondition searchCondition)
			throws Exception {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		
		int totalCount = dao.findTotalBranchCount(searchCondition);
		List<BranchStatisticsData> branchStatisticsData = dao.findBranch(searchCondition);

		return new PaginationResponse(searchCondition, totalCount, branchStatisticsData);
	}
	
	public List<Map<Object, Object>> findBranchStatistics(BranchStatisticsSearchCondition searchCondition)
			throws Exception {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		
		List<Map<Object, Object>> branchStatisticsData = dao.findBranchExcel(searchCondition);

		return branchStatisticsData;
	}
	
	public PaginationResponse findChannelStatisticsByPagination(ChannelStatisticsSearchCondition searchCondition)
			throws Exception {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		
		int totalCount = dao.findTotalChannelCount(searchCondition);
		List<ChannelStatisticsData> channelStatisticsData = dao.findChannel(searchCondition);

		return new PaginationResponse(searchCondition, totalCount, channelStatisticsData);
	}
	
	public List<Map<Object, Object>> findChannelStatistics(ChannelStatisticsSearchCondition searchCondition)
			throws Exception {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		
		List<Map<Object, Object>> channelStatisticsData = dao.findChannelExcel(searchCondition);

		return channelStatisticsData;
	}
	
	public PaginationResponse findFailureStatisticsByPagination(FailureStatisticsSearchCondition searchCondition)
			throws Exception {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		
		int totalCount = dao.findTotalFailureCount(searchCondition);
		List<FailureStatisticsData> failureStatisticsData = dao.findFailure(searchCondition);

		return new PaginationResponse(searchCondition, totalCount, failureStatisticsData);
	}
	
	public List<Map<Object, Object>> findFailureStatistics(FailureStatisticsSearchCondition searchCondition)
			throws Exception {
		Preconditions.checkArgument(searchCondition.getPerPage() > 0, "perPage is null");
		Preconditions.checkArgument(searchCondition.getCurrentPage() > 0, "currentPage is null");

		
		List<Map<Object, Object>> failureStatisticsData = dao.findFailureExcel(searchCondition);

		return failureStatisticsData;
	}
	
	public List<VendorStatisticsData> findVendorStatisticsByPagination(VendorStatisticsSearchCondition searchCondition)
			throws Exception {
		List<VendorStatisticsData> vendorStatisticsData = dao.findVendor(searchCondition);
		return vendorStatisticsData;
	}
	
	public List<Map<Object, Object>> findVendorStatistics(VendorStatisticsSearchCondition searchCondition)
			throws Exception {
		List<Map<Object, Object>> vendorStatisticsData = dao.findVendorExcel(searchCondition);
		return vendorStatisticsData;
	}

	public List<SendData> findSend(String yyyyMM)
			throws Exception {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("yyyyMM", yyyyMM);
		return dao.findSend(paramMap);
	}
	
	public List<SendGroupData> findSendGroup(String yyyyMM)
			throws Exception {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("yyyyMM", yyyyMM);
		return dao.findSendGroup(paramMap);
	}

	public int changeSendGroup(Map<String, Object> map) {
		return dao.changeSendGroupStatus(map);
	}
}
