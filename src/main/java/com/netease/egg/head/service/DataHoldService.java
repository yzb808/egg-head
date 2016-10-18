package com.netease.egg.head.service;

import java.util.List;

import com.netease.egg.head.model.Player;

public interface DataHoldService {

	public void loadData();
	
	public List<Player> getPlayerByVip(Integer vipLevel);
	
}
