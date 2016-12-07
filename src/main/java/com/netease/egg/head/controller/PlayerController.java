package com.netease.egg.head.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.netease.egg.head.model.Player;
import com.netease.egg.head.service.DataHoldService;

@Controller
public class PlayerController {
	@SuppressWarnings("unused")
	private static Logger logger = Logger.getLogger(PlayerController.class);

	@Autowired
	private DataHoldService dataHoldService;
	
	@RequestMapping(value = "/playerLY", method = RequestMethod.GET)
	public String player(@RequestParam(value = "id", required = true)Long playerId, ModelMap model) {
		Player player = dataHoldService.getPlayerById(playerId);
		model.put("player", player);
		model.put("roleImgName", player.getSex() + " " + player.getProfession());
		return "playerInfoLY";
	}

}