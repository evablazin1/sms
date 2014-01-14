package com.education.repository.country;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.education.domain.country.CityDomain;

public interface CityRepository extends JpaRepository<CityDomain,Long>,PagingAndSortingRepository<CityDomain, Long>{

		@Query("select cd from CityDomain cd where cd.provinceCode=:provinceCode order by cd.cityName")
		public List<CityDomain> findCitiesByProvinceCode(@Param("provinceCode") String provinceCode);
}
