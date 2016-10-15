package com.netease.egg.head.encriptor;

import java.io.UnsupportedEncodingException;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Hex;
import org.apache.log4j.Logger;

public class BlowfishEncriptor implements Encriptor {

	private static Logger LOG = Logger.getLogger(BlowfishEncriptor.class);

	private static final String INITIALIZATION_VECTOR = "cnBHdE9F";//初始化向量
    private static final String BLOW_FISH_KEY="xusndkdhxlcuesqm";//BlowFish对称加密用到的key 128位
    private static final String TRANSFORMATION = "Blowfish/CBC/PKCS5Padding";

	// 密钥算法名称
	public static final String BLOWFISH = "Blowfish";

	private static SecretKeySpec sksSpec;
	private static AlgorithmParameterSpec algorithmParameterSpec;
	static {
		// 根据给定的字节数组构造一个密钥 Blowfish-与给定的密钥内容相关联的密钥算法的名称

		try {
			sksSpec = new SecretKeySpec(BLOW_FISH_KEY.getBytes("UTF-8"), BLOWFISH);
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}

		// 使用 initializationVector 中的字节作为 IV 来构造一个 IvParameterSpec 对象

		try {
			algorithmParameterSpec = new IvParameterSpec(INITIALIZATION_VECTOR.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}

	}

	@Override
	public String encript(String text) {
		byte[] encrypted = null;
		// 加密文本
		try {
			Cipher initializedEncrypt = null;
			initializedEncrypt = Cipher.getInstance(TRANSFORMATION);
			initializedEncrypt.init(Cipher.ENCRYPT_MODE, sksSpec, algorithmParameterSpec);
			encrypted = initializedEncrypt.doFinal(text.getBytes("UTF-8"));
		} catch (Exception e) {
			throw new RuntimeException("failed to encript", e);
		}
		return new String(Hex.encodeHex(encrypted));
	}

	@Override
	public String decrypt(String text) {

		byte[] decrypted = null;

		try {
			Cipher initializedDecrypt = Cipher.getInstance(TRANSFORMATION);

			initializedDecrypt.init(Cipher.DECRYPT_MODE, sksSpec, algorithmParameterSpec);

			decrypted = Hex.decodeHex(text.toCharArray());
			decrypted = initializedDecrypt.doFinal(decrypted);

		} catch (Exception e) {
			LOG.error("failed to decript:", e);
			return null;
		}
		String s;
		try {
			s = new String(decrypted, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return null;
		}

		return s;
	}

	public static void main(String[] args) {
		BlowfishEncriptor bf = new BlowfishEncriptor();
		String contents = "hanviwuniwe";

		long start = System.nanoTime() / 1000000;// 单位是毫秒
		String encripted = bf.encript(contents);
		String decrypted = bf.decrypt(encripted);
		if (contents.equals(decrypted)) {
			System.out.println("ok");
		} else {
			System.out.println("failed");
		}
		long end = System.nanoTime() / 1000000;
		System.out.println((end - start) + "ms");
	}

}
