package com.ibk.msg;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement(proxyTargetClass = true)
// WAR 배포후 Container 에서 기동을 하기 위해서는 SpringBootServletInitializer 를 상속 해야 한다.
public class IbkMsgApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(IbkMsgApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication app = new SpringApplication();
		app.run(IbkMsgApplication.class, args);
	}
}
