package com.education.service.country;

import java.util.List;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.education.domain.country.ProvinceDomain;
import com.education.repository.country.ProvinceRepository;

@Service
@RemoteProxy(name="provinceService")
public class ProvinceService {
	
	
	private static final Logger logger = LoggerFactory.getLogger(ProvinceService.class);
	
	@Autowired
	ProvinceRepository provinceRepository;
	
	@RemoteMethod
	public List<ProvinceDomain> getProvincesByCountryCode(String countryCode){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to retrieve provinces for country code : "+ countryCode);
		List<ProvinceDomain> listOfProvinces						= provinceRepository.findProvincesByCountryCode(countryCode);
		
		return listOfProvinces;
	}

}
