package com.netease.egg.head.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.netease.egg.head.model.Player;
import com.netease.egg.head.model.PlayerSpendLY;
import com.netease.egg.head.model.PlayerSpendYL;
import com.netease.egg.head.util.FileUtil;

@Service
public class DataHoldServiceImp implements DataHoldService {
	private static Logger logger = Logger.getLogger(DataHoldServiceImp.class);
	private static String fileName = "palyerData.txt";
	private static String charset = "UTF-8";

	private final Map<Long, Player> playerWithId = new HashMap<>();

	@PostConstruct
	public void init() {
		loadData();
	}

	@Override
	public void loadData() {
		BufferedReader br = null;
		try {
			InputStream is = FileUtil.class.getClassLoader().getResourceAsStream(fileName);
			br = new BufferedReader(new InputStreamReader(is, charset));
			while (true) {
				String line = br.readLine();
				if (line == null) {
					break;
				}
				Player player = form(line.trim());
				playerWithId.put(player.getRoleId(), player);
			}
		} catch (Exception e) {
			throw new RuntimeException("failed to read file:" + fileName, e);
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					logger.error(e);
				}
			}
		}
	}

	private static List<String> dropFieldList = Arrays.asList("playerSpendLY", "playerSpendYL", "playerMission");
	private Player form(String data) throws Exception {
		String[] pieceData = data.split("\t");
		int point = 0;
		
		Player player = new Player();
		Method[] methods = Player.class.getMethods();
		Map<String, Method> methodMap = new HashMap<>();
		for(Method method : methods) {
			methodMap.put(method.getName(), method);
		}
		Field[] fields = Player.class.getDeclaredFields();
		for (Field field : fields) {
			if (dropFieldList.contains(field.getName())) {
				continue;
			}
			String fieldName = field.getName();
			char[] cs = fieldName.toCharArray();
			cs[0] -= 32;
			String setMethodName = "set" + String.valueOf(cs);
			Method setMethod = methodMap.get(setMethodName);
			setValue(setMethod, player, pieceData[point++]);
		}
		
		PlayerSpendLY playerSpendLY = new PlayerSpendLY();
		player.setPlayerSpendLY(playerSpendLY);
		Method[] lyMethods = PlayerSpendLY.class.getMethods();
		Map<String, Method> lyMethodMap = new HashMap<>();
		for(Method method : lyMethods) {
			lyMethodMap.put(method.getName(), method);
		}
		Field[] lyFields = PlayerSpendLY.class.getDeclaredFields();
		for (Field field : lyFields) {
			String fieldName = field.getName();
			char[] cs = fieldName.toCharArray();
			cs[0] -= 32;
			String setMethodName = "set" + String.valueOf(cs);
			Method setMethod = lyMethodMap.get(setMethodName);
			setValue(setMethod, playerSpendLY, pieceData[point++]);
		}
		
		PlayerSpendYL playerSpendYL = new PlayerSpendYL();
		player.setPlayerSpendYL(playerSpendYL);
		Method[] ylMethods = PlayerSpendYL.class.getMethods();
		Map<String, Method> ylMethodMap = new HashMap<>();
		for(Method method : ylMethods) {
			ylMethodMap.put(method.getName(), method);
		}
		Field[] ylFields = PlayerSpendYL.class.getDeclaredFields();
		for (Field field : ylFields) {
			String fieldName = field.getName();
			char[] cs = fieldName.toCharArray();
			cs[0] -= 32;
			String setMethodName = "set" + String.valueOf(cs);
			Method setMethod = ylMethodMap.get(setMethodName);
			setValue(setMethod, playerSpendYL, pieceData[point++]);
		}

		return player;
	}
	
	public static String DEFAULT_FORMAT="yyyy/MM/dd HH:mm";
	private static SimpleDateFormat format = new SimpleDateFormat(DEFAULT_FORMAT);
	private void setValue(Method method, Object object, String data) throws Exception {
		Class<?> paraType = method.getParameterTypes()[0];
		if (paraType.equals(int.class) || paraType.equals(Integer.class)) {
			method.invoke(object, Integer.parseInt(data));
		} else if (paraType.equals(long.class) || paraType.equals(Long.class)) {
			method.invoke(object, Long.parseLong(data));
		} else if (paraType.equals(float.class) || paraType.equals(Float.class)) {
			method.invoke(object, Float.parseFloat(data));
		} else if (paraType.equals(double.class) || paraType.equals(Double.class)) {
			if (data.equals("NULL")) {
				method.invoke(object, 0d);
			} else {
				method.invoke(object, Double.parseDouble(data));
			}
		} else if(paraType.equals(Date.class)){
			method.invoke(object, format.parse(data));
		} else {
			method.invoke(object, data);
		}
	}

}
