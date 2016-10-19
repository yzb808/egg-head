package com.netease.egg.head.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.netease.egg.head.model.Player;
import com.netease.egg.head.service.DataHoldService;
import com.netease.egg.head.util.FormAjaxDataModel;

@Controller
public class SearchController {
	@SuppressWarnings("unused")
	private static Logger logger = Logger.getLogger(SearchController.class);

	@Autowired
	private DataHoldService dataHoldService;

	@RequestMapping("/api/search")
	public void search(@RequestParam(value = "searchWord", required = false, defaultValue = "17")String searchWord, ModelMap model) throws Exception {
		List<Player> players = dataHoldService.getPlayerByVip(Integer.parseInt(searchWord));
		model.put("data", FormAjaxDataModel.formAjax(players));
	}

}