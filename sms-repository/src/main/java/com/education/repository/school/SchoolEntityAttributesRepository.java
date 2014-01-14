package com.education.repository.school;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.education.domain.school.SchoolEntityAttributeDomain;

public interface SchoolEntityAttributesRepository extends JpaRepository<SchoolEntityAttributeDomain,Long>,PagingAndSortingRepository<SchoolEntityAttributeDomain, Long>{

}
