package com.education.repository.school;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.education.domain.school.SchoolDomain;

public interface SchoolRepository extends JpaRepository<SchoolDomain,Long>,PagingAndSortingRepository<SchoolDomain, Long>{

	public List<SchoolDomain> findSchoolsByCountryAndProvinceAndCity(String country,String province,String city);
}
