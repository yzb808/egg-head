package com.netease.egg.head.encriptor;


public interface Encriptor {
	
	/**
	 * 建字符串解密，生成User对象
	 * @param s
	 * @return
	 */
	public String decrypt(String s);
	
	/**
	 * 将java对象加密成字符串
	 * @param u
	 * @return
	 */
	public String encript(String u);
}
