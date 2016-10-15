package com.netease.egg.head.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.alibaba.fastjson.JSON;
import com.netease.egg.head.service.LoginUser;
import com.netease.egg.head.service.SessionManagerService;

public class LoginCheckFilter implements Filter {

	@Autowired
	private SessionManagerService sessionManagerService;

	private String failedJsonResponse;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		ApplicationContext applicationContext = WebApplicationContextUtils
				.getWebApplicationContext(filterConfig.getServletContext());
		sessionManagerService = (SessionManagerService) applicationContext.getBean("sessionManagerService");
		if (sessionManagerService == null) {
			throw new RuntimeException("sessionManagerService not exists");
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", 401);
		map.put("message", "not login!");

		failedJsonResponse = JSON.toJSONString(map);
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		String uri = req.getRequestURI();

		if (ifNotCheck(uri)) {
			chain.doFilter(req, response);
			return;
		}

		LoginUser user = sessionManagerService.getSession(req);
		if (user == null) {
			if (uri.startsWith("/api/")) {
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().println(failedJsonResponse);
				return;
			} else {
				req.getSession().setAttribute("uri", uri);
				res.sendRedirect("/login");
				return;
			}
		}

		chain.doFilter(req, res);

	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	private boolean ifNotCheck(String uri) {
		
		if(uri.startsWith("/login")){
			return true;
		}
		
		if(uri.contains("/judge")){
			return true;
		}
		
		if(uri.contains(".")){
			return true;
		}
		
		return false;
	}

}
