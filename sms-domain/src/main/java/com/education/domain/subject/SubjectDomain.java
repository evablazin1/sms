package com.education.domain.subject;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="subject")
public class SubjectDomain implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3467745754492769585L;
	
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY )
	private Long id;
	
	@Column( name="school_id", nullable=false)
	private Long schoolID; 
	
	@Column( name="subject_teacher_id", nullable=false)
	private Long subjectTeacherID;
	
	@Column( name="class_id", nullable=false)
	private Long classID;
	
	@Column( name="subject_teacher_name", nullable=false)
	private String subjectTeacherName;
	
	@Column( name="class_name", nullable=false)
	private String className;
	
	@Column( name="subject_name", nullable=false)
	private String subjectName;

	@Column( name="status", nullable=false)
	private String status;
	
	@Column( name="created_by", nullable=false)
	private String createdBy;
	
	@Column( name="modified_by", nullable=false)
	private String modifiedBy;
	
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

	public Long getSchoolID() {
		return schoolID;
	}

	public void setSchoolID(Long schoolID) {
		this.schoolID = schoolID;
	}

	public Long getSubjectTeacherID() {
		return subjectTeacherID;
	}

	public void setSubjectTeacherID(Long subjectTeacherID) {
		this.subjectTeacherID = subjectTeacherID;
	}

	public Long getClassID() {
		return classID;
	}

	public void setClassID(Long classID) {
		this.classID = classID;
	}

	public String getSubjectTeacherName() {
		return subjectTeacherName;
	}

	public void setSubjectTeacherName(String subjectTeacherName) {
		this.subjectTeacherName = subjectTeacherName;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
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

	public String getModifiedBy() {
		return modifiedBy;
	}

	public void setModifiedBy(String modifiedBy) {
		this.modifiedBy = modifiedBy;
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
