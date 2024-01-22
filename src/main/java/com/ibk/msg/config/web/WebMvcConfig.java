package com.ibk.msg.config.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import java.util.List;

@Configuration
public class WebMvcConfig extends WebMvcConfigurerAdapter {

	@Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
		super.configureMessageConverters(converters);

		// 5. WebMvcConfigurerAdapter �뿉 MessageConverter 異붽�
		converters.add(htmlEscapingConverter());
	}

	private IpCheckInterceptor ipCheckInterceptor = null;
	@Bean
	public IpCheckInterceptor ipCheckInterceptor(){
		if(ipCheckInterceptor == null){
			ipCheckInterceptor = new IpCheckInterceptor();
		}
		return ipCheckInterceptor;
	}

	private AllMSGCheckInterceptor allMSGCheckInterceptor = null;
	@Bean
	public AllMSGCheckInterceptor allMSGCheckInterceptor(){
		if(allMSGCheckInterceptor == null){
			allMSGCheckInterceptor = new AllMSGCheckInterceptor();
		}
		return allMSGCheckInterceptor;
	}

	private LevelCheckInterceptor levelCheckInterceptor = null;
	@Bean
	public LevelCheckInterceptor levelCheckInterceptor(){
		if(levelCheckInterceptor == null){
			levelCheckInterceptor = new LevelCheckInterceptor();
		}
		return levelCheckInterceptor;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(levelCheckInterceptor())
		.addPathPatterns("/**")
		.excludePathPatterns("/**/login.ibk")
		.excludePathPatterns("/**/motp_login.ibk")
		.excludePathPatterns("/auth.ibk")
		.excludePathPatterns("/")
		.excludePathPatterns("/sso**")
		.excludePathPatterns("/sso/**")
		.excludePathPatterns("/fax/**")
		.excludePathPatterns("/email/**")
		.excludePathPatterns("/login.ibk")
		.excludePathPatterns("/logout.ibk")
		.excludePathPatterns("/motp_login.ibk")
		.excludePathPatterns("/allmessage.ibk")
		.excludePathPatterns("/allmessageSSO.ibk")
		.excludePathPatterns("/allmessage/**")
		.excludePathPatterns("/error/**")
		.excludePathPatterns("/static/**")
		.excludePathPatterns("/statistics/**")
		.excludePathPatterns("/eventsend.ibk")
		.excludePathPatterns("/eventsend/**")
		.excludePathPatterns("/template-view.ibk")
		.excludePathPatterns("/template-list")
		.excludePathPatterns("/template-img.ibk")
		.excludePathPatterns("/template-categoryList")
		.excludePathPatterns("/download-template-img.ibk")
		.excludePathPatterns("/download-all-template-img.ibk")
		.excludePathPatterns("/forbidden/not_available.ibk")
		.excludePathPatterns("/crmview.ibk")
		.excludePathPatterns("/crmview");

		registry.addInterceptor(ipCheckInterceptor())
		.addPathPatterns("/**")
		.excludePathPatterns("/**/login.ibk")
		.excludePathPatterns("/**/motp_login.ibk")
		.excludePathPatterns("/auth.ibk")
		.excludePathPatterns("/")
		.excludePathPatterns("/sso**")
		.excludePathPatterns("/sso/**")
		.excludePathPatterns("/test**")
		.excludePathPatterns("/test/**")
		.excludePathPatterns("/static/**")
		.excludePathPatterns("/statistics/**")
		.excludePathPatterns("/error/**")
		.excludePathPatterns("/login.ibk")
		.excludePathPatterns("/logout.ibk")
		.excludePathPatterns("/motp_login.ibk")
		.excludePathPatterns("/allmessage.ibk")
		.excludePathPatterns("/allmessageSSO.ibk")
		.excludePathPatterns("/allmessage/**")
		.excludePathPatterns("/fax/**")
		.excludePathPatterns("/email/**")
		.excludePathPatterns("/smssendlist/confirm/**")
		.excludePathPatterns("/eventsend.ibk")
		.excludePathPatterns("/eventsend/**")
		.excludePathPatterns("/index_AllMessage**")
		.excludePathPatterns("/template-view.ibk")
		.excludePathPatterns("/template-list")
		.excludePathPatterns("/template-categoryList")
		.excludePathPatterns("/template-img.ibk")
		.excludePathPatterns("/forbidden/not_available.ibk");
		

		registry.addInterceptor(allMSGCheckInterceptor())
		.addPathPatterns("/allmessage.ibk")
		.addPathPatterns("/allmessage/**")
		.addPathPatterns("/fax/**")
		.addPathPatterns("/email/**")
		.addPathPatterns("/static/**")
		.addPathPatterns("/statistics/**")
		.addPathPatterns("/sso**")
		.addPathPatterns("/sso/**")
		.excludePathPatterns("/allmessageSSO.ibk")
		;

	}

	private HttpMessageConverter<?> htmlEscapingConverter() {
		ObjectMapper objectMapper = new ObjectMapper();
		// 3. ObjectMapper �뿉 �듅�닔 臾몄옄 泥섎━ 湲곕뒫 �쟻�슜
		objectMapper.getFactory().setCharacterEscapes(new HTMLCharacterEscapes());

		// 4. MessageConverter �뿉 ObjectMapper �꽕�젙
		MappingJackson2HttpMessageConverter htmlEscapingConverter =
				new MappingJackson2HttpMessageConverter();
		htmlEscapingConverter.setObjectMapper(objectMapper);

		return htmlEscapingConverter;
	}

}
