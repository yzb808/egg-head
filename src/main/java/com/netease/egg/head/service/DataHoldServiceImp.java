package com.netease.egg.head.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.xml.crypto.Data;

import org.apache.commons.io.input.BOMInputStream;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.netease.egg.head.model.Player;
import com.netease.egg.head.model.PlayerMission;
import com.netease.egg.head.model.PlayerSpendLY;
import com.netease.egg.head.model.PlayerSpendYL;
import com.netease.egg.head.util.FileUtil;

@Service
public class DataHoldServiceImp implements DataHoldService {
	private static Logger logger = Logger.getLogger(DataHoldServiceImp.class);
	private static String fileName = "palyerData.txt";
	private static String charset = "UTF-8";
	private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");

	private final Map<Long, Player> playerWithId = new HashMap<>();
	private final Map<Integer, List<Player>> playerWithVip = new HashMap<>();

	@PostConstruct
	public void init() {
		loadData();
		System.out.println();
	}
	
	@Override
	public List<Player> getPlayerByVip(Integer vipLevel) {
		List<Player> players = playerWithVip.get(vipLevel);
		if (players == null) {
			return Collections.emptyList();
		}
		return players;
	}

	@Override
	public void loadData() {
		BufferedReader br = null;
		try {
			InputStream is = FileUtil.class.getClassLoader().getResourceAsStream(fileName);
			BOMInputStream bomInputStream = new BOMInputStream(is);
			System.out.println(bomInputStream.hasBOM());
			br = new BufferedReader(new InputStreamReader(bomInputStream, charset));
			while (true) {
				String line = br.readLine();
				if (line == null) {
					break;
				}
				try {
					Player player = form(line.trim());
					playerWithId.put(player.getRoleId(), player);
					
					/*
					 * vip
					 */
					Integer vipLevel = player.getVipLevel();
					List<Player> vipPlayerList = playerWithVip.get(vipLevel);
					if (vipPlayerList == null) {
						vipPlayerList = new ArrayList<>();
						playerWithVip.put(vipLevel, vipPlayerList);
					}
					vipPlayerList.add(player);
					
				} catch (Exception e) {
					logger.error("player translate error, line=" + line, e);
				}
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
		
		PlayerMission playerMission = new PlayerMission();
		player.setPlayerMission(playerMission);
		Method[] missionMethods = PlayerMission.class.getMethods();
		Map<String, Method> missionMethodMap = new HashMap<>();
		for(Method method : missionMethods) {
			missionMethodMap.put(method.getName(), method);
		}
		Field[] missionFields = PlayerMission.class.getDeclaredFields();
		for (Field field : missionFields) {
			String fieldName = field.getName();
			char[] cs = fieldName.toCharArray();
			cs[0] -= 32;
			String setMethodName = "set" + String.valueOf(cs);
			Method setMethod = missionMethodMap.get(setMethodName);
			setValue(setMethod, playerMission, pieceData[point++]);
		}

		return player;
	}
	
	public static String DEFAULT_FORMAT="yyyy/MM/dd HH:mm";
	private static SimpleDateFormat format = new SimpleDateFormat(DEFAULT_FORMAT);
	private void setValue(Method method, Object object, String data) throws Exception {
		String d = data.trim();
		Class<?> paraType = method.getParameterTypes()[0];
		if (paraType.equals(int.class) || paraType.equals(Integer.class)) {
			if (d.equals("NULL")) {
				method.invoke(object, 0);
			} else {
				method.invoke(object, Integer.parseInt(d));
			}
		} else if (paraType.equals(long.class) || paraType.equals(Long.class)) {
			if (d.equals("NULL")) {
				method.invoke(object, 0l);
			} else {
				method.invoke(object, Long.parseLong(d));
			}
		} else if (paraType.equals(float.class) || paraType.equals(Float.class)) {
			if (d.equals("NULL")) {
				method.invoke(object, 0f);
			} else {
				method.invoke(object, Float.parseFloat(d));
			}
		} else if (paraType.equals(double.class) || paraType.equals(Double.class)) {
			if (d.equals("NULL")) {
				method.invoke(object, 0d);
			} else {
				method.invoke(object, Double.parseDouble(d));
			}
		} else if(paraType.equals(Date.class)){
			if (d.equals("NULL")) {
				method.invoke(object, new Date(0));
			} else {
				method.invoke(object, format.parse(d));
			}
		} else {
			method.invoke(object, d);
		}
	}
	
	@Override
	public List<Player> searchByPara(Map<String, String> param) throws Exception {
		List<Player> result = new ArrayList<>();
		Collection<Player> players = playerWithId.values();
		for(Player player : players) {
			String account = param.get("account");
			if (account != null) {
				account = account.trim();
				if (!player.getAccount().equals(account)) {
					continue;
				}
			}
			
			String vip_level = param.get("vip_level");
			if (vip_level != null) {
				vip_level = vip_level.trim();
				if (!player.getVipLevel().equals(Integer.parseInt(vip_level))) {
					continue;
				}
			}
			
			String mengpai = param.get("mengpai");
			if (mengpai != null) {
				mengpai = mengpai.trim();
				if (!player.getProfession().equals(mengpai)) {
					continue;
				}
			}
			
			String niki_name = param.get("niki_name");
			if (niki_name != null) {
				niki_name = niki_name.trim();
				if (!player.getRoleName().equals(niki_name)) {
					continue;
				}
			}
			
			String createDate1 = param.get("createDate1");
			if (createDate1 != null) {
				createDate1 = createDate1.trim();
				Date dateStart = df.parse(createDate1);
				if (player.getCreateTime().before(dateStart)) {
					continue;
				}
			}
			
			String createDate2 = param.get("createDate2");
			if (createDate2 != null) {
				createDate2 = createDate2.trim();
				Date dateEnd = df.parse(createDate2);
				if (player.getCreateTime().after(dateEnd)) {
					continue;
				}
			}
			
			String sexSelect = param.get("sexSelect");
			if (sexSelect != null) {
				sexSelect = sexSelect.trim();
				if (!player.getSex().equals(sexSelect) && !sexSelect.equals("未选")) {
					continue;
				}
			}
			
			String manager = param.get("manager");
			if (manager != null) {
				manager = manager.trim();
				if (!player.getManager().equals(manager)) {
					continue;
				}
			}
			
			String songhua1 = param.get("songhua1");
			if (songhua1 != null) {
				songhua1 = songhua1.trim();
				if (player.getPlayerSpendLY().getSongHua() < Long.parseLong(songhua1)) {
					continue;
				}
			}
			
			String songhua2 = param.get("songhua2");
			if (songhua2 != null) {
				songhua2 = songhua2.trim();
				if (player.getPlayerSpendLY().getSongHua() > Long.parseLong(songhua2)) {
					continue;
				}
			}
			
			String qianghua1 = param.get("qianghua1");
			if (qianghua1 != null) {
				qianghua1 = qianghua1.trim();
				if (player.getPlayerSpendLY().getWssStrong() < Long.parseLong(qianghua1)) {
					continue;
				}
			}
			
			String qianghua2 = param.get("qianghua2");
			if (qianghua2 != null) {
				qianghua2 = qianghua2.trim();
				if (player.getPlayerSpendLY().getWssStrong() > Long.parseLong(qianghua2)) {
					continue;
				}
			}

			String player_id = param.get("player_id");
			if (player_id != null) {
				player_id = player_id.trim();
				if (player.getRoleId() != Long.parseLong(player_id)) {
					continue;
				}
			}
			
			String yinliang1 = param.get("yinliang1");
			if (yinliang1 != null) {
				yinliang1 = yinliang1.trim();
				if (player.getPlayerSpendYL().getZongYinLiang() < Double.parseDouble(yinliang1)) {
					continue;
				}
			}
			
			String yinliang2 = param.get("yinliang2");
			if (yinliang2 != null) {
				yinliang2 = yinliang2.trim();
				if (player.getPlayerSpendYL().getZongYinLiang() > Double.parseDouble(yinliang2)) {
					continue;
				}
			}
			
			String xilian1 = param.get("xilian1");
			if (xilian1 != null) {
				xilian1 = xilian1.trim();
				if (player.getPlayerSpendLY().getWashEquipment() < Long.parseLong(xilian1)) {
					continue;
				}
			}
			
			String xilian2 = param.get("xilian2");
			if (xilian2 != null) {
				xilian2 = xilian2.trim();
				if (player.getPlayerSpendLY().getWashEquipment() > Long.parseLong(xilian2)) {
					continue;
				}
			}
			
			String server = param.get("server");
			if (server != null) {
				server = server.trim();
				if (player.getServerId() != Integer.parseInt(server)) {
					continue;
				}
			}
			
			result.add(player);
		}
		return result;
	}

}
