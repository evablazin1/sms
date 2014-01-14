package com.education.repository.country;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.education.domain.country.ProvinceDomain;

public interface ProvinceRepository extends JpaRepository<ProvinceDomain,Long>,PagingAndSortingRepository<ProvinceDomain, Long>{

	@Query("select pd from ProvinceDomain pd where pd.countryCode=:countryCode order by pd.provinceName ")
	public List<ProvinceDomain> findProvincesByCountryCode(@Param("countryCode") String countryCode);
}
