package com.ibk.msg.web.xweb;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class XWebController {

	@GetMapping("/monitor-queue.ibk")
	public String monitorChannel() {
		return "xweb/monitor-queue";
	}
	
	@GetMapping("/monitor-process.ibk")
	public String monitorBranch() {
		return "xweb/monitor-process";
	}
		
	@GetMapping("/monitor-log.ibk")	
	public String monitorVendor() {
		return "xweb/monitor-log";
	}
	
}
