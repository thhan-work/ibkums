package com.ibk.msg.web.envset;

import com.ibk.msg.config.database.KiupSmsRepository;

@KiupSmsRepository
public interface EnvSetDao {
	CutEmpl getCutEmplInfo(String emplID);
	void addCutEmpl(CutEmpl cutEmplInfo);
	void modCutEmpl(CutEmpl cutEmplInfo);
	void modEmplInfoCutEmpl(CutEmpl cutEmplInfo);
}
