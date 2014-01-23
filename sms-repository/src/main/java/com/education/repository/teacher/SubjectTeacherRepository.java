package com.education.repository.teacher;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import com.education.domain.teacher.SubjectTeacherDomain;

public interface SubjectTeacherRepository extends JpaRepository<SubjectTeacherDomain,Long>,PagingAndSortingRepository<SubjectTeacherDomain, Long>{
	
	@Query("select std from SubjectTeacherDomain std where std.schoolID=:schoolID AND std.subjectTeacherID=:teacherID ")
	public List<SubjectTeacherDomain> findBySchoolIDAndTeacherID(@Param("schoolID") Long schoolID,@Param("teacherID") Long teacherID);

}
