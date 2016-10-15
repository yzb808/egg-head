package com.netease.egg.head.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.netease.egg.head.util.CookieManager;
import com.netease.egg.head.util.EncriptorUtil;

public class SessionManagerService {

	private ThreadLocal<LoginUser> userLocal = new ThreadLocal<LoginUser>();

	private int aliveAgeHour;

	public LoginUser getSession(HttpServletRequest request) {
		String s = CookieManager.getCookie(request, CookieManager.COOKIE_NAME_LOGIN);
		if (s == null) {
			return null;
		}
		LoginUser u = EncriptorUtil.decrypt(s);
		return u;
	}

	/**
	 * 设置cookie信息
	 * 
	 * @param response
	 * @param user
	 */
	public void setSession(HttpServletResponse response, LoginUser user) {

		if (user == null) {
			throw new RuntimeException("user is null");
		}
		String s = EncriptorUtil.encript(user);
		CookieManager.addCookie(response, CookieManager.COOKIE_NAME_LOGIN, s, 3600);
	}

	public void clearSession(HttpServletResponse response) {
		CookieManager.removeCookie(response, CookieManager.COOKIE_NAME_LOGIN);
	}

	/**
	 * 将用户信息放入当前线程相关的上下文
	 * 
	 * @param user
	 */
	public void setThreadLocalUser(LoginUser user) {
		userLocal.set(user);
	}

	public void clearThreadLocalUser() {
		userLocal.remove();
	}

	/**
	 * 在web层判断用户是否登陆
	 * 
	 * @param user
	 */
	public LoginUser getSessionLoginUser() {
		return userLocal.get();
	}

	public int getAliveAgeHour() {
		return aliveAgeHour;
	}

	public void setAliveAgeHour(int aliveAgeHour) {
		this.aliveAgeHour = aliveAgeHour;
	}

}
