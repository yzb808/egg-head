package com.netease.egg.head.model;

/**
 * 师徒关系信息
 * @author hzxuyun
 *
 */
public class PlayerMaster {

	private String masterInfo;
	private String apprenticeInfo;
	private String maseteNow;
	private String apprenticeNow;
	
	public String getMasterInfo() {
		return masterInfo;
	}
	public void setMasterInfo(String masterInfo) {
		this.masterInfo = masterInfo;
	}
	public String getApprenticeInfo() {
		return apprenticeInfo;
	}
	public void setApprenticeInfo(String apprenticeInfo) {
		this.apprenticeInfo = apprenticeInfo;
	}
	public String getMaseteNow() {
		return maseteNow;
	}
	public void setMaseteNow(String maseteNow) {
		this.maseteNow = maseteNow;
	}
	public String getApprenticeNow() {
		return apprenticeNow;
	}
	public void setApprenticeNow(String apprenticeNow) {
		this.apprenticeNow = apprenticeNow;
	}
	
}
