package com.ibk.msg.web.envset;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ibk.msg.web.smssendlist.SmsSendListController;

@Controller
public class EnvSetController {
	private static final Logger logger = LoggerFactory.getLogger(SmsSendListController.class);
	
	@Autowired
	private EnvSetService envSetService;
	
	@GetMapping("/envset.ibk")
	public String ViewEnvset(Model model, HttpSession session) {
		
		String emplID= session.getAttribute("EMPL_ID").toString();
		String emplName = session.getAttribute("EMPL_NAME").toString();
		
		CutEmpl cutEmplInfo = new CutEmpl();

		try {
			cutEmplInfo = envSetService.getCutEmplInfo(emplID);
		} catch (Exception e) {
			logger.error("",e);
		}
		
		String flag = "";
		
		if (cutEmplInfo != null) {
			flag = cutEmplInfo.getEmplCut();
		}
		
		model.addAttribute("flag", flag);
		model.addAttribute("emplName", emplName);

		return "envset/envset-index";
	}
	
	@GetMapping(value = "/envset/save")
	public String envsetsave(@RequestParam(value = "flag") String flag, HttpSession session) {
		
		String emplID = session.getAttribute("EMPL_ID").toString();
		String emplBoCode = session.getAttribute("EMPL_BOCODE").toString();
				
		if(logger.isInfoEnabled())
			logger.info(" + emplId : [" + emplID + "]	boCode : [" + emplBoCode + "]	flag : [" + flag + "]");
		
		CutEmpl cutEmplInfo = new CutEmpl();
		cutEmplInfo.setEmplId(emplID);
		cutEmplInfo.setBoCode(emplBoCode);
		cutEmplInfo.setEmplCut(flag);
		logger.debug("cutEmplInfo.toString() : " + cutEmplInfo.toString());

		try {
			if (envSetService.getCutEmplInfo(emplID) == null) {
				envSetService.addCutEmpl(cutEmplInfo);
				envSetService.modEmplInfoCutEmpl(cutEmplInfo);
			} else {
				envSetService.modCutEmpl(cutEmplInfo);
				envSetService.modEmplInfoCutEmpl(cutEmplInfo);
			}
		} catch (Exception e) {
			logger.error("",e);
		}
		
		return "redirect:/envset.ibk";
	}
	
}
