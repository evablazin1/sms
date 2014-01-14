package com.education.repository.school;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.education.domain.school.SchoolEntityDomain;

public interface SchoolEntityRepository extends JpaRepository<SchoolEntityDomain,Long>,PagingAndSortingRepository<SchoolEntityDomain, Long>{

}
