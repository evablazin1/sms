package com.education.domain.agents;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="agent_entity_attributes")
public class AgentEntityAttributesDomain implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5472204127633978255L;

	@Id @GeneratedValue(strategy=GenerationType.IDENTITY )
	private Long id;
	
	@Column( name="agent_entity_id", nullable=false)
	private Long agentEntityID;
	
	@Column( name="attribute", nullable=false)
	private String attribute;
	
	@Column( name="attribute_value", nullable=true)
	private String attributeValue;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getAgentEntityID() {
		return agentEntityID;
	}

	public void setAgentEntityID(Long agentEntityID) {
		this.agentEntityID = agentEntityID;
	}

	public String getAttribute() {
		return attribute;
	}

	public void setAttribute(String attribute) {
		this.attribute = attribute;
	}

	public String getAttributeValue() {
		return attributeValue;
	}

	public void setAttributeValue(String attributeValue) {
		this.attributeValue = attributeValue;
	}
}
