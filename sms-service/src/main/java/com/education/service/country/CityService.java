package com.education.service.country;

import java.util.List;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.education.domain.country.CityDomain;
import com.education.repository.country.CityRepository;

@Service
@RemoteProxy(name="cityService")
public class CityService {
	
	private static final Logger logger = LoggerFactory.getLogger( CityService.class );
	
	@Autowired
	CityRepository cityRepository;
	
	@RemoteMethod
	public List<CityDomain> getCitiesByProvinceCode(String provinceCode){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to retrieve cities for province code : "+ provinceCode);
		List<CityDomain> listOfCities					=	 cityRepository.findCitiesByProvinceCode(provinceCode);
		
		return listOfCities;
	}

}
