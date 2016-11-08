package com.netease.egg.head.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.netease.egg.head.model.Player;

/**
 * 生成datatables格式的ajax数据
 * @author hzxuyun
 *
 */
public class FormAjaxDataModel {
	
	public static List<List<String>> formAjax(List<Player> players) {
		List<List<String>> rows = new ArrayList<>();
		for (Player player : players) {
			List<String> row = new ArrayList<>();
			row.add(player.getRoleId() + "");
			row.add(player.getRoleName());
			row.add(player.getProfession());
			row.add(player.getSex());
			row.add(player.getVipLevel() + "");
			row.add(player.getManager());
			row.add(player.getAccount());
			rows.add(row);
		}
		return rows;
	}

}
