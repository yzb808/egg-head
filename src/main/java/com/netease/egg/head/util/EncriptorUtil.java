package com.netease.egg.head.util;

import org.apache.log4j.Logger;
import com.alibaba.fastjson.JSON;
import com.netease.egg.head.encriptor.BlowfishEncriptor;
import com.netease.egg.head.encriptor.Encriptor;
import com.netease.egg.head.service.LoginUser;

public class EncriptorUtil {
	private static Logger LOG = Logger.getLogger(EncriptorUtil.class);
	private static Encriptor encriptor = new BlowfishEncriptor();

	public static LoginUser decrypt(String s) {
		try {
			String de = encriptor.decrypt(s);

			LoginUser u = JSON.parseObject(de, LoginUser.class);
			if (u.getAccount() == null) {
				LOG.error("user id or name is null:" + s);
				return null;
			}
			return u;
		} catch (Exception e) {
			LOG.error("failed deserilize LoginUser:" + s, e);
			return null;
		}
	}

	/**
	 * 将java对象加密成字符串
	 * 
	 * @param u
	 * @return
	 */
	public static String encript(LoginUser u) {
		String s = JSON.toJSONString(u);
		return encriptor.encript(s);
	}

}
