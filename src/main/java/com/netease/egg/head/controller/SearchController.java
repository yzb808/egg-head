package com.netease.egg.head.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
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
import com.netease.egg.head.util.FormAjaxDataModel;

@Controller
public class SearchController {
	@SuppressWarnings("unused")
	private static Logger logger = Logger.getLogger(SearchController.class);

	@Autowired
	private DataHoldService dataHoldService;
	
	@RequestMapping(value = "/api/search", method = RequestMethod.GET)
	public void searchG(@RequestParam(value = "name", required = false, defaultValue = "17")String searchWord,HttpServletRequest request, ModelMap model) throws Exception {
		List<Player> players = Collections.emptyList();
		model.put("data", FormAjaxDataModel.formAjax(players));
	}

	@RequestMapping(value = "/api/search", method = RequestMethod.POST)
	public void searchP(HttpServletRequest request, ModelMap model) throws Exception {
		Map<String, String[]> requestMap = request.getParameterMap();
		Map<String, String> paraMap = new HashMap<>();
		for(Map.Entry<String, String[]> entry : requestMap.entrySet()) {
			String key = entry.getKey();
			String[] values = entry.getValue();
			if (values.length == 0) {
				continue;
			}
			if (StringUtils.isNotBlank(values[0])) {
				paraMap.put(key, values[0]);
			}
		}
		List<Player> players = dataHoldService.searchByPara(paraMap);
		model.put("data", FormAjaxDataModel.formAjax(players));
	}
	
	@RequestMapping(value = "/searchInput", method = RequestMethod.GET)
	public String searchInput(ModelMap model) throws Exception {
		return "searchInput";
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String search(HttpServletRequest request, ModelMap model) throws Exception {
		Map<String, String[]> requestMap = request.getParameterMap();
		Map<String, String> paraMap = new HashMap<>();
		for(Map.Entry<String, String[]> entry : requestMap.entrySet()) {
			String key = entry.getKey();
			String[] values = entry.getValue();
			if (values.length == 0) {
				continue;
			}
			if (StringUtils.isNotBlank(values[0])) {
				paraMap.put(key, values[0]);
			}
		}
		model.put("paraMap", JSON.toJSONString(paraMap));
		return "search";
	}

}