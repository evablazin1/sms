package com.education.repository.subject;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;


import com.education.domain.subject.SubjectDomain;

public interface SubjectRepository extends JpaRepository<SubjectDomain,Long>,PagingAndSortingRepository<SubjectDomain, Long>{
	
	public List<SubjectDomain> findBySchoolID(Long schoolID);

}
