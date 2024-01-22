package com.ibk.msg.common.dto;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import java.util.List;
import lombok.Data;
import org.springframework.util.CollectionUtils;

@Data
@JsonPropertyOrder({"total", "perPage", "currentPage", "lastPage", "startPage", "ednPage", "data"})
public class PaginationResponse {

	private int viewPageSize = 10;
	private int totalRecords;
	private int perPage;
	private int currentPage = 1;
	private int lastPage;
	private int startPage;
	private int endPage;
	private Object data;
	
	public PaginationResponse() {
		
	}

	public PaginationResponse(PaginationCondition condition, int totalCount, List data) {
		this.totalRecords = totalCount;
		this.currentPage = condition.getCurrentPage();
		this.perPage = condition.getPerPage();
		int extraPage = 0;
		if (totalCount % condition.getPerPage() > 0) {
			extraPage = 1;
		}
		this.lastPage = totalCount / condition.getPerPage() + extraPage;
		this.data = data;
		if (!CollectionUtils.isEmpty(data)) {
			this.startPage = ((condition.getCurrentPage() - 1) / viewPageSize) * viewPageSize + 1;
			this.endPage = this.startPage + viewPageSize - 1;
			if (endPage > lastPage) {
				endPage = lastPage;
			}
		}
	}
}
