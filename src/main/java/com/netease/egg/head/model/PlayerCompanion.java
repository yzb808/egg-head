package com.netease.egg.head.model;
import java.util.Date;

/**
 * 伴侣信息
 * @author hzxuyun
 *
 */
public class PlayerCompanion {

	private Date marryTime;
	private Long companionId;
	private String companionName;
	private String companionVip;
	private String marryStatus;
	private String marryHistory;
	
	public Date getMarryTime() {
		return marryTime;
	}
	public void setMarryTime(Date marryTime) {
		this.marryTime = marryTime;
	}
	public Long getCompanionId() {
		return companionId;
	}
	public void setCompanionId(Long companionId) {
		this.companionId = companionId;
	}
	public String getCompanionName() {
		return companionName;
	}
	public void setCompanionName(String companionName) {
		this.companionName = companionName;
	}
	public String getCompanionVip() {
		return companionVip;
	}
	public void setCompanionVip(String companionVip) {
		this.companionVip = companionVip;
	}
	public String getMarryStatus() {
		return marryStatus;
	}
	public void setMarryStatus(String marryStatus) {
		this.marryStatus = marryStatus;
	}
	public String getMarryHistory() {
		return marryHistory;
	}
	public void setMarryHistory(String marryHistory) {
		this.marryHistory = marryHistory;
	}
	
}