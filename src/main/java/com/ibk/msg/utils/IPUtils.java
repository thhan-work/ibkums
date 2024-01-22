package com.ibk.msg.utils;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class IPUtils {

	private static final Logger logger = LoggerFactory.getLogger(IPUtils.class);

	private static final String[] IP_HEADER_CANDIDATES = {
			"X-Forwarded-For",
			"Proxy-Client-IP",
			"WL-Proxy-Client-IP",
			"HTTP_X_FORWARDED_FOR",
			"HTTP_X_FORWARDED",
			"HTTP_X_CLUSTER_CLIENT_IP",
			"HTTP_CLIENT_IP",
			"HTTP_FORWARDED_FOR",
			"HTTP_FORWARDED",
			"HTTP_VIA",
			"REMOTE_ADDR"};

	protected IPUtils() {}

	public static boolean isMatch(String ips, String ip) {
		if(ips == null) {
			return true;
		}

		String filtering = ips.replaceAll(ip.replaceAll("\\.", "\\\\.") + "($|\n)","");
		if (ips.equals(filtering)) {
			return false;
		}

		return true;
	}

	public static String getClientIp(HttpServletRequest request) {
		for (String header : IP_HEADER_CANDIDATES) {
			String ip = request.getHeader(header);
			if (StringUtils.isNotEmpty(ip) && !StringUtils.equals("unknown", ip)) {
				return ip;
			}
		}
		return request.getRemoteAddr();
	}
}
