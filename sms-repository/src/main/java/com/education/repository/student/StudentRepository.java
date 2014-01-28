package com.education.repository.student;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.education.domain.student.StudentDomain;

public interface StudentRepository extends JpaRepository<StudentDomain,Long>,PagingAndSortingRepository<StudentDomain, Long>{

	@Query("select sd from StudentDomain sd where sd.schoolID=:schoolID AND sd.classID=:classID")
	public List<StudentDomain> findBySchoolIDAndClassID(@Param("schoolID") Long schoolID,@Param("classID") Long classID);
}
