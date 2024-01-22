package com.ibk.msg.web.manage;

import java.util.List;
import java.util.Map;

import com.ibk.msg.config.database.DacomRepository;

@DacomRepository
public interface ManageDao {

	int findTotalCodeGroupCount(CodeGroupSearchCondition codeGroupSearchCondition);
	List<CodeGroup> findCodeGroup(CodeGroupSearchCondition codeGroupSearchCondition);
	void removeCodeGroup(String codeGroupId);
    void addCodeGroup(CodeGroup codeGroup);
    void modifyCodeGroup(CodeGroup codeGroup);
    CodeGroup findDetailCodeGroup(String codeGroupId);
    int findCodeGroupCount(String codeGroup);
    List<CodeGroup> findAllCodeGroup();
    
	
	int findTotalCodeCount(CodeSearchCondition codeSearchCondition);
	List<Code> findCode(CodeSearchCondition codeSearchCondition);
	void removeCode(Map<Object, Object> param);
    void addCode(Code code);
    void modifyCode(Code code);
    Code findDetailCode(Map<Object, Object> param);
    List<Code> findDetailCodes(Map<Object, Object> param);
    int findCodeCount(Map<Object, Object> param);
    
    
    int findTotalJobCodeCount(JobCodeSearchCondition jobCodeSearchCondition);
	List<JobCode> findJobCode(JobCodeSearchCondition jobCodeSearchCondition);
	void removeJobCode(String bzwkIdfr);
    void addJobCode(JobCode jobCode);
    void addJobCode(Map<String,Object> jobCode);
    void modifyJobCode(JobCode jobCode);
    JobCode findDetailJobCode(String bzwkIdfr);
    int findJobCodeCount(String bzwkIdfr);
    List<Map<Object, Object>> findAllJobCode();
    
    List<Code> selectSendPrice();
}
