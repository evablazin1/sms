package com.education.service.school;

import java.util.List;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.education.domain.school.SchoolDomain;
import com.education.repository.school.SchoolRepository;

@Service
@RemoteProxy(name="schoolService")
public class SchoolService {
	
	
	private static final Logger logger = LoggerFactory.getLogger(SchoolService.class);
	
	@Autowired
	SchoolRepository schoolRepository;
	
	@RemoteMethod
	public List<SchoolDomain> retrieveSchoolsByLocation(String country,String province,String city){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to retrieve schools from country : "+ country + " ,province : " +province+ " ,city : " + city);
		
		List<SchoolDomain> listOfSchools				=  schoolRepository.findSchoolsByCountryAndProvinceAndCity(country, province, city);
		return listOfSchools;
	}
	
	

}
