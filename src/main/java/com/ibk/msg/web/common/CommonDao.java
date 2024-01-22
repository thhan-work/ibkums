package com.ibk.msg.web.common;

import java.util.List;

import com.ibk.msg.config.database.IbkRepository;
import com.ibk.msg.web.manage.Code;

@IbkRepository
public interface CommonDao {

	List<Code> selectCodeList(String code);

}

