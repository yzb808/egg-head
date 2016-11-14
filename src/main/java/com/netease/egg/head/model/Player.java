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
	private PlayerFiveWeek playerFiveWeek;		// 五周任务完成情况
	private PlayerCompanion playerCompanion;	// 配偶信息
	private PlayerMaster playerMaster;			// 师徒关系
	private PlayerRecommend playerRecommend;	// 推荐效果
	private PlayerFriend playerFriend;			// 好友关系
	
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
//		this.createTimeS = createTime.toString();
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
	public PlayerFiveWeek getPlayerFiveWeek() {
		return playerFiveWeek;
	}
	public void setPlayerFiveWeek(PlayerFiveWeek playerFiveWeek) {
		this.playerFiveWeek = playerFiveWeek;
	}
	public PlayerCompanion getPlayerCompanion() {
		return playerCompanion;
	}
	public void setPlayerCompanion(PlayerCompanion playerCompanion) {
		this.playerCompanion = playerCompanion;
	}
	public PlayerMaster getPlayerMaster() {
		return playerMaster;
	}
	public void setPlayerMaster(PlayerMaster playerMaster) {
		this.playerMaster = playerMaster;
	}
	public PlayerRecommend getPlayerRecommend() {
		return playerRecommend;
	}
	public void setPlayerRecommend(PlayerRecommend playerRecommend) {
		this.playerRecommend = playerRecommend;
	}
	public PlayerFriend getPlayerFriend() {
		return playerFriend;
	}
	public void setPlayerFriend(PlayerFriend playerFriend) {
		this.playerFriend = playerFriend;
	}
	
}
