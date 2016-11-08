package com.netease.egg.head.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.netease.egg.head.service.DataHoldService;

@Controller
public class PlayerLYController {
	@SuppressWarnings("unused")
	private static Logger logger = Logger.getLogger(PlayerLYController.class);

	@Autowired
	private DataHoldService dataHoldService;
	
	@RequestMapping(value = "/player", method = RequestMethod.GET)
	public String player(@RequestParam(value = "id", required = true)Long playerId, ModelMap model) {
		model.put("player", dataHoldService.getPlayerById(playerId));
		return "playerInfo";
	}

}