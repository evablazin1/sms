package com.education.repository.student;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import com.education.domain.student.StudentSubjectDomain;

public interface StudentSubjectRepository extends JpaRepository<StudentSubjectDomain,Long>,PagingAndSortingRepository<StudentSubjectDomain, Long>{

	@Query("select ssd from StudentSubjectDomain ssd where ssd.schoolID=:schoolID AND ssd.classID=:classID AND ssd.studentID=:studentID")
	public List<StudentSubjectDomain> findBySchoolIDAndClassIDAndStudentID(@Param("schoolID") Long schoolID,@Param("classID") Long classID,@Param("studentID") Long studentID);
	
	
	@Query("select ssd from StudentSubjectDomain ssd where ssd.schoolID=:schoolID AND ssd.classID=:classID AND ssd.subjectID=:subjectID")
	public List<StudentSubjectDomain> findBySchoolIDAndClassIDAndSubjectID(@Param("schoolID") Long schoolID,@Param("classID") Long classID,@Param("subjectID") Long subjectID);
	
}
