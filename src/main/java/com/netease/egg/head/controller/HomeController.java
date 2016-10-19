package com.netease.egg.head.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.netease.egg.head.model.Player;
import com.netease.egg.head.service.DataHoldService;
import com.netease.egg.head.service.LoginUser;
import com.netease.egg.head.service.SessionManagerService;

@Controller
public class HomeController {
	@SuppressWarnings("unused")
	private static Logger logger = Logger.getLogger(HomeController.class);
	private static String loginNull = "1";
	private static String loginError = "2";

	@Autowired
	private SessionManagerService sessionManagerService;

	@Autowired
	private DataHoldService dataHoldService;

	@RequestMapping("/error/404")
	public String notFound(HttpSession session, HttpServletRequest request, ModelMap model) {
		return "error/404";
	}

	@RequestMapping("/error/500")
	public String error(HttpSession session, HttpServletRequest request, ModelMap model) {
		return "error/500";
	}

	@RequestMapping("/index")
	public String index(HttpSession session, HttpServletRequest request, ModelMap model) {
		model.put("userName", "登录服务暂不可用");
		return "index";
	}

	@RequestMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws IOException {
		String message = request.getParameter("message");
		if (message != null) {
			if (message.equals(loginNull)) {
				model.put("message", "账号和密码不能为空");
			} else if (message.equals(loginError)) {
				model.put("message", "账号密码不匹配");
			}
		}
		return "login";
	}

	@RequestMapping("/logout")
	public String logout(HttpServletResponse response, HttpSession session, ModelMap model) throws IOException {
		response.sendRedirect("/login");
		return null;
	}

	@RequestMapping("/judge")
	public void judge(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws IOException {
		String userName = request.getParameter("userName");
		String password = request.getParameter("Password1");
		if (StringUtils.isBlank(userName) || StringUtils.isBlank(password)) {
			response.setContentType("text/html; charset=UTF-8");
			response.sendRedirect("/login?message=" + "1");
			return;
		}
		if (userName.equals("egg") && password.equals("123456")) {
			LoginUser user = new LoginUser();
			user.setAccount(userName);
			sessionManagerService.setSession(response, user);
			response.sendRedirect("/index");
		} else {
			response.setContentType("text/html; charset=UTF-8");
			response.sendRedirect("/login?message=" + "2");
		}
	}

}