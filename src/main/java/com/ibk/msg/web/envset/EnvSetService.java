package com.ibk.msg.web.envset;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EnvSetService {

	@Autowired
	private EnvSetDao dao;
	
	public CutEmpl getCutEmplInfo(String emplID) {
		CutEmpl cutEmplInfo = null;
		cutEmplInfo = dao.getCutEmplInfo(emplID);
				
		return cutEmplInfo;
	}
	
	public void addCutEmpl(CutEmpl cutEmplInfo) {
		dao.addCutEmpl(cutEmplInfo);
	}
	
	public void modCutEmpl(CutEmpl cutEmplInfo) {
		dao.modCutEmpl(cutEmplInfo);
	}
	
	public void modEmplInfoCutEmpl(CutEmpl cutEmplInfo) {
		dao.modEmplInfoCutEmpl(cutEmplInfo);
	}
	
}
