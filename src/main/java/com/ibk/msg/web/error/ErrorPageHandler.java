package com.ibk.msg.web.error;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public  class ErrorPageHandler implements ErrorController  { 
	
	@RequestMapping("/error") 
	public String error(HttpServletRequest request) { 
		
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		Object errorMsg = request.getAttribute(RequestDispatcher.ERROR_MESSAGE);
		
		request.setAttribute("errorCode", status);
		request.setAttribute("errorMsg", errorMsg);
		
		if(status != null){
			int statusCode = Integer.valueOf(status.toString());
			
			if(statusCode == HttpStatus.FORBIDDEN.value()){
				return "error/400error";
			}
			
			if(statusCode == HttpStatus.FORBIDDEN.value()){
				return "error/403error";
			}
			
			if(statusCode == HttpStatus.NOT_FOUND.value()){				
//				return "redirect:";
				return "error/404error";
			}
			
			if(statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()){
				return "error/500error";
			}
			
		} 
		return "error/error";
	} 
	
	@RequestMapping("/error/{errorCode}") 
	public String errorPage(@PathVariable("errorCode") String errorCode, HttpServletRequest request) { 
		if(errorCode == null || errorCode.equals("")){
			return "error/error";
		}
		
		if(errorCode.equals("400")){
			return "error/400error";
		}else if(errorCode.equals("403")){
			return "error/403error";
		}else if(errorCode.equals("404")){
//			return "index";
			return "error/404error";
		}else if(errorCode.equals("500")){
			return "error/500error";
		}else{
			return "error/error";
		}
	}
	
	@Override
	public String getErrorPath() {
        return "error/error";
	} 
}

