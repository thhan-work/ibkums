package com.ibk.msg.web.smsUnsubscribe;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@Controller
public class SmsUnsubscribeController {
	private static final Logger logger = LoggerFactory.getLogger(SmsUnsubscribeController.class);
	
    @Autowired
    private SmsUnsubscribeService smsUnsubscribeService;

    
    @GetMapping("/smsUnsubscribe.ibk")
    public String viewListJspToSmsUnsubscribe() {
        return "smsUnsubscribe/smsUnsubscribe-list";
    }
    
    @GetMapping("/smsUnsubscribe")
    @ResponseBody
    public Object findByPagination(SmsUnsubscribeSearchCondition searchCondition) throws Exception {
        return smsUnsubscribeService.findByPagination(searchCondition);
    }

    @GetMapping("/smsUnsubscribe/{phone}")
    @ResponseBody
    public Object findDetail(@PathVariable("phone") String phone) throws Exception {
        return smsUnsubscribeService.findDetail(phone);
    }

    @GetMapping("/smsUnsubscribe/{phone}/count")
    @ResponseBody
    public int getCount(@PathVariable("phone") String phone) throws Exception {
        return smsUnsubscribeService.findDetailCount(phone);
    }

    @PutMapping(value = "/smsUnsubscribe/{phone}", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public Object modify(@PathVariable("phone") String phone, @RequestBody SmsUnsubscribeInfo smsUnsubscribeInfo, HttpSession session) throws Exception {
    	logger.info("[INFO] ########### phone="+phone);
    	logger.info("[INFO] ########### smsUnsubscribeInfo="+smsUnsubscribeInfo.toString());
    	
    	smsUnsubscribeInfo.setEnlister(getWriter(session));
        return smsUnsubscribeService.modify(smsUnsubscribeInfo);
    }
    
    @DeleteMapping("/smsUnsubscribe/del/{phone}")
    @ResponseBody
    public Object remove(@PathVariable("phone") String[] phoneArr, HttpSession session) throws Exception {
    	logger.info("[INFO] ########### phone="+phoneArr);
    	
        return smsUnsubscribeService.remove(phoneArr, session);
    }

    @PostMapping(value = "/smsUnsubscribe", produces = {"application/json"})
    @ResponseBody
    @ResponseStatus(HttpStatus.CREATED)
    public Object add(@RequestBody SmsUnsubscribeInfo smsUnsubscribeInfo, HttpSession session) throws Exception {
    	logger.info("[INFO] ########### smsUnsubscribeInfo="+ smsUnsubscribeInfo.toString());
    	logger.info("[INFO] ########### regId="+ getWriter(session));
    	
        smsUnsubscribeInfo.setEnlister(getWriter(session));
        return smsUnsubscribeService.add(smsUnsubscribeInfo);
    }
    
    private String getWriter(HttpSession session) {
        return (String) session.getAttribute("EMPL_ID");
    }
}
