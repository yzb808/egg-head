package com.netease.egg.head.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieManager {
	public static String COOKIE_NAME_LOGIN = "sentry_web_login_cookie";

	public static String getCookie(HttpServletRequest request, String cookieName) {
		Cookie[] cookies = request.getCookies();
		if (cookies == null || cookies.length == 0) {
			return null;
		}
		for (Cookie c : cookies) {
			if (cookieName.equals(c.getName())) {
				String cv = c.getValue();
				return cv;
			}
		}
		return null;
	}

	public static void addCookie(HttpServletResponse response, String cookieName, String value, int maxAge) {

		Cookie cookie = new Cookie(cookieName, value); //
		cookie.setPath("/");
		cookie.setMaxAge(maxAge);
		response.addCookie(cookie);

	}

	public static void removeCookie(HttpServletResponse response, String cookieName) {
		Cookie newCookie = new Cookie(cookieName, null);
		newCookie.setMaxAge(0);
		newCookie.setPath("/");
		response.addCookie(newCookie);

	}

}
