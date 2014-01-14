package com.education.service.country;

import java.util.List;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.education.domain.country.CountryDomain;
import com.education.repository.country.CountryRepository;


@Service
@RemoteProxy(name="countryService")
public class CountryService {
	
	
	private static final Logger logger = LoggerFactory.getLogger( CountryService.class );
	
	@Autowired
	CountryRepository countryRepository;
	
	@RemoteMethod
	public List<CountryDomain> getAllCoutries(){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to retrieve all countries");
		List<CountryDomain> listOfCountries					=	 countryRepository.findAllCountries();

		return listOfCountries;
	}

}
