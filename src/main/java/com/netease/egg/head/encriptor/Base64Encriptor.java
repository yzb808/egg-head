package com.netease.egg.head.encriptor;

import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;

import org.apache.commons.lang3.StringUtils;

public class Base64Encriptor implements Encriptor {

	private Decoder decoder = Base64.getDecoder();
	private Encoder encoder = Base64.getEncoder();

	@Override
	public String decrypt(String s) {
		if (org.apache.commons.lang3.StringUtils.isBlank(s)) {
			throw new RuntimeException("string to decript is null");
		}
		byte[] bb = decoder.decode(s);
		String jstring = new String(bb, Charset.forName("UTF-8"));
		return jstring;

	}

	@Override
	public String encript(String string) {
		if (string == null || StringUtils.isBlank(string)) {
			throw new RuntimeException("string to encript is null");
		}

		byte[] bb;
		try {
			bb = encoder.encode(string.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}

		try {
			return new String(bb, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}
	}

}
