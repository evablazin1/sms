package com.education.repository.student;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.education.domain.student.StudentDomain;

public interface StudentRepository extends JpaRepository<StudentDomain,Long>,PagingAndSortingRepository<StudentDomain, Long>{

}
