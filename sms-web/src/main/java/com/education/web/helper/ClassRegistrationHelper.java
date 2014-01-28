package com.education.web.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.education.domain.classes.ClassDomain;
import com.education.repository.classes.ClassRepository;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;
import com.education.web.security.SecurityHelper;

@Component("classRegistrationHelper")
public class ClassRegistrationHelper {
	
	/**
	 * 
	 */
	@Autowired
	ClassRepository classrepository;
	
	
	/**
	 * 
	 */
	@Value("${inactive.status}")
	private String inactivestatus;
	
	/**
	 * 
	 */
	private static String inActiveStatus;
	private static ClassRepository classRepository;

	
	private static final Logger logger 													= LoggerFactory.getLogger(ClassRegistrationHelper.class);
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){
		 
		inActiveStatus																	= this.inactivestatus;
		classRepository																	= this.classrepository;
	}
	
	
	
	
	
	/**
	 * 
	 * @param session
	 * @param requests
	 * @return
	 */
	public Response saveClassDetails(HttpSession session,Request[] requests){
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering class details ");
		
		Response response								   								= new Response();
		ClassDomain classDomain															= new ClassDomain();	
		String createdBy																= !StringUtils.isEmpty((String)session.getAttribute(SecurityHelper.USER_NAME))?(String)session.getAttribute(SecurityHelper.USER_NAME):"Super-Admin";
		
		
		try{
			
			/**
			 * Save details to class table
			 */
			
			String className															= "";
			String schoolID																= "";
			String subject																= "";
			List<String> subjects													    = new ArrayList<String>();
			
			
			
			/**
			 * Retrieve and set variables from the request object
			 */
			for(Request request : requests){
				className																= StringUtils.equals(request.getName().trim(),"Class Name")?request.getValue().trim():className;
				schoolID																= StringUtils.equals(request.getName().trim(),"School ID")?request.getValue().trim():schoolID;
				/**
				 * Retrieve values from multiple select
				 */
				if(StringUtils.equals(request.getName().trim(),"Subjects")){
					subject																= request.getValue().trim();
					subjects.add(subject);
				}
				
			}
			
			/**
			 * Save details to class table
			 */
			classDomain.setClassName(className);
			classDomain.setSchoolID(Long.valueOf(schoolID));
			classDomain.setStatus(inActiveStatus);
			
			classDomain.setCreatedBy(createdBy);
			classDomain.setModifiedBy(createdBy);
			classDomain.setCreatedDate(new Date());
			classDomain.setModifiedDate(new Date());
			
			classDomain																	= classRepository.save(classDomain);
			
			/**
			 * Save details to class subject table
			 */
			
			ClassSubjectRegistrationHelper  classSubjectRegistrationHelper				= new ClassSubjectRegistrationHelper();
			response																	= classSubjectRegistrationHelper.saveClassSubjectDetails(session, subjects, Long.valueOf(schoolID), classDomain.getId(), className);
			
			logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered class");
			
		}catch(Exception ex){
			
			logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + ex.toString());
			
			response.setStatus("Not Saved");
			response.setMessage("Due to technical diffculities,leads were not successfully saved to the Database. Please try again later.");
		}
		
		return response;
		
	}

}
