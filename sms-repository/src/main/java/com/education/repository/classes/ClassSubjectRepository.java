package com.education.repository.classes;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.education.domain.classes.ClassSubjectDomain;

public interface ClassSubjectRepository  extends JpaRepository<ClassSubjectDomain,Long>,PagingAndSortingRepository<ClassSubjectDomain, Long>{

	@Query("select csd from ClassSubjectDomain csd where csd.schoolID=:schoolID AND csd.subjectID=:subjectID")
	public List<ClassSubjectDomain> findBySchoolIDAndSubjectID(@Param("schoolID")Long schoolID,@Param("subjectID")Long subjectID);
	
	@Query("select csd from ClassSubjectDomain csd where csd.schoolID=:schoolID AND csd.classID=:classID")
	public List<ClassSubjectDomain> findBySchoolIDAndClassID(@Param("schoolID")Long schoolID,@Param("classID")Long classID);
	
	@Query("select csd.subjectID from ClassSubjectDomain csd where csd.schoolID=:schoolID AND csd.classID=:classID")
	public List<Long> getSubjectIDs(@Param("schoolID")Long schoolID,@Param("classID")Long classID);
}
