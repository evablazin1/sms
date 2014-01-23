package com.education.repository.teacher;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.education.domain.teacher.ClassTeacherDomain;

public interface ClassTeacherRepository extends JpaRepository<ClassTeacherDomain,Long>,PagingAndSortingRepository<ClassTeacherDomain, Long>{

	public List<ClassTeacherDomain> findBySchoolID(Long schoolID);
	
	@Query("select ctd from ClassTeacherDomain ctd where ctd.schoolID=:schoolID AND ctd.classTeacherID=:teacherID ")
	public List<ClassTeacherDomain> findBySchoolIDAndTeacherID(@Param("schoolID") Long schoolID,@Param("teacherID") Long teacherID);
}
