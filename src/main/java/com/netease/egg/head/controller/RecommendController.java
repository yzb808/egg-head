package com.netease.egg.head.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;
import com.netease.egg.head.model.Player;
import com.netease.egg.head.service.DataHoldService;

@Controller
public class RecommendController {
	@SuppressWarnings("unused")
	private static Logger logger = Logger.getLogger(RecommendController.class);

	@Autowired
	private DataHoldService dataHoldService;

	@RequestMapping(value = "/api/recommend", method = RequestMethod.POST)
	public void searchP(HttpServletRequest request, ModelMap model, @RequestParam(value = "playerId", required = true)long playerId) throws Exception {
		Player player = dataHoldService.getPlayerById(playerId);
		Map<String, String[]> requestMap = request.getParameterMap();
		String select = requestMap.get("select")[0];
		String[] selects = select.split(",");
		List<HistoryDataSubmit> historyData = new ArrayList<>();
		for (int i = 0; i < selects.length; i++) {
			if (selects[i].equals("nothing")) {
				break;
			}
			String hisDataStr = null;
			String name = null;
			switch (selects[i]) {
			case "zbxl":
				hisDataStr = player.getPlayerFiveWeek().getWzBaoTu();
				name = "装备洗练";
				break;
			case "zbqh":
				hisDataStr = player.getPlayerFiveWeek().getWzBeiZhan();
				name = "装备强化";
				break;
			case "lsxl":
				hisDataStr = player.getPlayerFiveWeek().getWzCaiWei();
				name = "灵兽洗练";
				break;
			case "fbxl":
				hisDataStr = player.getPlayerFiveWeek().getWzDaDao();
				name = "法宝强化";
				break;
			case "dhyb":
				hisDataStr = player.getPlayerFiveWeek().getWzGaoChang();
				name = "兑换元宝";
				break;
			case "hbff":
				hisDataStr = player.getPlayerFiveWeek().getWzGuanNing();
				name = "红包发放";
				break;
			case "yzsh":
				hisDataStr = player.getPlayerFiveWeek().getWzHuoYun();
				name = "一掌山河";
				break;
			case "szgm":
				hisDataStr = player.getPlayerFiveWeek().getWzJiXing();
				name = "时装购买";
				break;
			case "djts":
				hisDataStr = player.getPlayerFiveWeek().getWzJuQing();
				name = "遁甲天书";
				break;
			case "jbsj":
				hisDataStr = player.getPlayerFiveWeek().getWzKouDao();
				name = "交保释金";
				break;
			default:
				break;
			}
			if (hisDataStr == null) {
				continue;
			}
			historyData.add(new HistoryDataSubmit(name, tranStringToInteger(hisDataStr.split(","))));
		}
		model.put("data", historyData);
	}
	
	/**
	 * 前端数据
	 * @author hzxuyun
	 *
	 */
	private class HistoryDataSubmit {
		private String name;
		private Integer[] data;
		
		public HistoryDataSubmit(String name, Integer[] data) {
			this.data = data;
			this.name = name;
		}
		
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}

		public Integer[] getData() {
			return data;
		}

		public void setData(Integer[] data) {
			this.data = data;
		}
		
	}
	
	private Integer[] tranStringToInteger(String[] dataStr) {
		Integer[] dataInt = new Integer[dataStr.length];
		for (int i = 0; i < dataStr.length; i++) {
			dataInt[i] = Integer.parseInt(dataStr[i]);
		}
		return dataInt;
	}

}