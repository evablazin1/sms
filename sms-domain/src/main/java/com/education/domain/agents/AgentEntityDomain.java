package com.education.domain.agents;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="agent_entity")
public class AgentEntityDomain implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3689017774113066973L;

	@Id @GeneratedValue(strategy=GenerationType.IDENTITY )
	private Long id;
	
	@Column( name="user_id", nullable=true)
	private Long userID;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}
}
