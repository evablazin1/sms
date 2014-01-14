package com.education.domain.system.admin;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="system_admin_entity_attributes")
public class SystemAdminEntityAttributesDomain implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2886828142154102449L;

	@Id @GeneratedValue(strategy=GenerationType.IDENTITY )
	private Long id;
	
	@Column( name="admin_entity_id", nullable=false)
	private Long adminEntityID;
	
	@Column( name="attribute", nullable=false)
	private String attribute;
	
	@Column( name="attribute_value", nullable=false)
	private String attributeValue;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getAdminEntityID() {
		return adminEntityID;
	}

	public void setAdminEntityID(Long adminEntityID) {
		this.adminEntityID = adminEntityID;
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
