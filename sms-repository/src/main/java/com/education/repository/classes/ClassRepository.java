package com.education.repository.classes;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.education.domain.classes.ClassDomain;

public interface ClassRepository  extends JpaRepository<ClassDomain,Long>,PagingAndSortingRepository<ClassDomain, Long>{

	public List<ClassDomain> findBySchoolID(Long schoolID);
}
