package com.ibk.msg.web.address;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import lombok.Data;

@Data
@JsonPropertyOrder({"personalGroupList", "shareGroupList", "partList","partAddressList", "addrType"})
public class AddressCallResponse {
	public Object personalGroupList;
	public Object shareGroupList;
	public Object partList;
	public Object partAddressList;
	public String addrType;

}
