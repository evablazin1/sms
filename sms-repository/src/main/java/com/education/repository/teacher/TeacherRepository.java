package com.education.repository.teacher;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.education.domain.teacher.TeacherDomain;

public interface TeacherRepository extends JpaRepository<TeacherDomain,Long>,PagingAndSortingRepository<TeacherDomain, Long>{

	public List<TeacherDomain> findBySchoolID(Long schoolID);
}
