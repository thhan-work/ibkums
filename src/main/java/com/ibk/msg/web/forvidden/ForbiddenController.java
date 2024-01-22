package com.ibk.msg.web.forvidden;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ForbiddenController {

	@RequestMapping("/forbidden/not_available.ibk")
	public String notAvailable() {
		return "forbidden/not_available";
	}
}
