package com.education.web.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.education.domain.school.SchoolEntityAttributeDomain;
import com.education.domain.school.SchoolEntityDomain;
import com.education.repository.school.SchoolEntityAttributesRepository;
import com.education.repository.school.SchoolEntityRepository;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;

@Component("SchoolRegistrationHelper")
public class SchoolRegistrationHelper {
	
	@Autowired
	SchoolEntityRepository schoolEntityRepository;
	
	@Autowired
	SchoolEntityAttributesRepository schoolEntityAttributesRepository;
	
	private static SchoolEntityRepository newSchoolEntityRepository;
	private static SchoolEntityAttributesRepository newSchoolEntityAttributesRepository;
	
	private static final Logger logger 												= LoggerFactory.getLogger(SchoolRegistrationHelper.class);
	
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){
		 
		newSchoolEntityRepository														= this.schoolEntityRepository;
		newSchoolEntityAttributesRepository												= this.schoolEntityAttributesRepository;
	}
	
	
	/**
	 * 
	 * @param requests
	 * @param schoolName
	 * @param createdBy
	 * @return
	 */
	public Response saveSchoolDetails(Request[] requests,String schoolName,String createdBy){
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering school details ");
		
		Response response								   								= new Response();
		SchoolEntityDomain schoolEntityDomain											= new SchoolEntityDomain();	
		List<SchoolEntityAttributeDomain> schoolEntityAttributesDomains        			= new ArrayList<SchoolEntityAttributeDomain>();
		
		try{
			
			/**
			 * Save details to school entity table
			 */
			schoolEntityDomain.setSchoolName(schoolName);
			schoolEntityDomain.setCreatedBy(createdBy);
			
			schoolEntityDomain.setStatus("Active");
			schoolEntityDomain.setCreatedDate(new Date());
			schoolEntityDomain.setModifiedDate(new Date());
			
			schoolEntityDomain															= newSchoolEntityRepository.save(schoolEntityDomain);

			logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered school");
			
			
			/**
			 * save to entity attributes table
			 */
			for(Request request : requests){
					SchoolEntityAttributeDomain schoolEntityAttributeDomain 			= new SchoolEntityAttributeDomain();
					
					schoolEntityAttributeDomain.setSchoolEntityID(schoolEntityDomain.getId());
					schoolEntityAttributeDomain.setAttribute(request.getName());
					schoolEntityAttributeDomain.setAttributeValue(StringUtils.trim(request.getValue()));
		
					schoolEntityAttributesDomains.add(schoolEntityAttributeDomain);
			}
			newSchoolEntityAttributesRepository.save(schoolEntityAttributesDomains);
			
			logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered school details");
			
			response.setStatus("Saved");
			response.setMessage("Details have been successfully saved to the Database.");
			
		}catch(Exception ex){
			
			logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + ex.toString());
			
			response.setStatus("Not Saved");
			response.setMessage("Due to technical diffculities,leads were not successfully saved to the Database. Please try again later.");
		}
		
		return response;
		
	}

}
