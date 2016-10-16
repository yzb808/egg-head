package com.netease.egg.head.model;

import java.util.Date;

public class Player {

	private int serverId;		// 服务器id
	private long roleId;		// 角色id
	private String account;		// 账号
	private Integer vipLevel;	// vip等级
	private String manager;		// 专属经理
	private String roleName;
	private String profession;	// 职业
	private String sex;
	private Date createTime;
	private Double onlineTime;	// 在线时长
	
	private PlayerSpendLY playerSpendLY;		// 灵玉花费记录
	private PlayerSpendYL playerSpendYL;		// 银两花费记录
	private PlayerMission playerMission;		// 任务完成记录
	
	
	public long getRoleId() {
		return roleId;
	}
	public void setRoleId(long roleId) {
		this.roleId = roleId;
	}
	public int getServerId() {
		return serverId;
	}
	public void setServerId(int serverId) {
		this.serverId = serverId;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public Integer getVipLevel() {
		return vipLevel;
	}
	public void setVipLevel(Integer vipLevel) {
		this.vipLevel = vipLevel;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getProfession() {
		return profession;
	}
	public void setProfession(String profession) {
		this.profession = profession;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Double getOnlineTime() {
		return onlineTime;
	}
	public void setOnlineTime(Double onlineTime) {
		this.onlineTime = onlineTime;
	}
	public PlayerSpendLY getPlayerSpendLY() {
		return playerSpendLY;
	}
	public void setPlayerSpendLY(PlayerSpendLY playerSpendLY) {
		this.playerSpendLY = playerSpendLY;
	}
	public PlayerSpendYL getPlayerSpendYL() {
		return playerSpendYL;
	}
	public void setPlayerSpendYL(PlayerSpendYL playerSpendYL) {
		this.playerSpendYL = playerSpendYL;
	}
	public PlayerMission getPlayerMission() {
		return playerMission;
	}
	public void setPlayerMission(PlayerMission playerMission) {
		this.playerMission = playerMission;
	}
	
}
