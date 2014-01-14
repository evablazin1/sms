package com.education.repository.country;

import java.util.List;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.education.domain.country.CountryDomain;

public interface CountryRepository extends JpaRepository<CountryDomain,Long>,PagingAndSortingRepository<CountryDomain, Long>{

	@Cacheable(value="countries")
	@Query("select cd from CountryDomain cd order by cd.countryName")
	public List<CountryDomain> findAllCountries();
}
