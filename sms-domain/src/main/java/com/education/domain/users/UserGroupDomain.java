package com.education.domain.users;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="user_group")
public class UserGroupDomain implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6347626903468298566L;

	@Id @GeneratedValue(strategy=GenerationType.IDENTITY )
	private Long id;
	
	@Column( name="user_id", nullable=false)
	private long userID; 
	
	@Column( name="group_name", nullable=false)
	private String groupName;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public long getUserID() {
		return userID;
	}

	public void setUserID(long userID) {
		this.userID = userID;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
}
