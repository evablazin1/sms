package com.education.domain.school;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="school_entity_attributes")
public class SchoolEntityAttributeDomain implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1463436875030825907L;
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY )
	private Long id;
	
	@Column( name="school_entity_id", nullable=false)
	private Long schoolEntityID;
	
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

	public Long getSchoolEntityID() {
		return schoolEntityID;
	}

	public void setSchoolEntityID(Long schoolEntityID) {
		this.schoolEntityID = schoolEntityID;
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
