package com.education.domain.users;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="users")
public class UserDomain implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 9198015870178667852L;
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY )
	private Long id;
	
	@Column( name="fullname", nullable=false)
	private String fullName; 
	
	@Column( name="username", nullable=false)
	private String username; 
	
	@Column( name="password", nullable=false)
	private String password;
	
	@Column( name="status", nullable=false)
	private String status;
	
	@Column( name="created_by", nullable=false)
	private String createdBy;
	
	@Column( name="created_date", nullable=false)
	private Date createdDate;
	
	@Column( name="modified_date", nullable=false)
	private Date modifiedDate;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getModifiedDate() {
		return modifiedDate;
	}

	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
}
