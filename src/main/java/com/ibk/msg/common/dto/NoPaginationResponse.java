package com.ibk.msg.common.dto;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.Data;

@Data
@JsonPropertyOrder({"data"})
public class NoPaginationResponse {

	private Object data;
	
	public NoPaginationResponse() {
		
	}
}
