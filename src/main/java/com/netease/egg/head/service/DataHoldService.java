package com.netease.egg.head.service;

import java.util.List;
import java.util.Map;

import com.netease.egg.head.model.Player;

public interface DataHoldService {

	public void loadData();
	
	public List<Player> getPlayerByVip(Integer vipLevel);
	
	public List<Player> searchByPara(Map<String, String> param) throws Exception;
	
	public Player getPlayerById(long playerId);
	
}
