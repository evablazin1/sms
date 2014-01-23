package com.education.web.helper;


import java.util.Date;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.education.domain.teacher.ClassTeacherDomain;
import com.education.repository.teacher.ClassTeacherRepository;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;
import com.education.web.security.SecurityHelper;

@Component("classTeacherRegistrationHelper")
public class ClassTeacherRegistrationHelper {

	/**
	 * 
	 */
	@Autowired
	ClassTeacherRepository classteacherrepository;
	
	/**
	 * 
	 */
	@Value("${active.status}")
	private String activestatus;

	/**
	 * 
	 */
	private static String activeStatus;
	private static ClassTeacherRepository classTeacherRepository;
	
	private static final Logger logger 												   = LoggerFactory.getLogger(ClassTeacherRegistrationHelper.class);
	
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){
		 activeStatus																	= this.activestatus;
		 classTeacherRepository															= this.classteacherrepository;
	}
	
	
	
	
	/**
	 * 
	 * @param requests
	 * @param role
	 * @param username
	 * @param phone
	 * @param createdBy
	 * @return
	 */
	public Response saveClassTeacherDetails(HttpSession session,Request[] requests){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering teacher details ");
		
		Response response																	= new Response();	
		ClassTeacherDomain classTeacherDomain		    									= new ClassTeacherDomain();
		
		String createdBy																	= !StringUtils.isEmpty((String)session.getAttribute(SecurityHelper.USER_NAME))?(String)session.getAttribute(SecurityHelper.USER_NAME):"Super-Admin";
		
		try{
				
				/**
				 * Save details to Class Teacher table
				 */
				
				String schoolID															    = "";
				String classID																= "";
				String className															= "";
				String classTeacherID														= "";
				String classTeacherName														= "";
			
				/**
				 * Retrieve and set variables from the request object
				 */
				for(Request request : requests){
					schoolID																= StringUtils.equals(request.getName().trim(),"School ID")?request.getValue().trim():schoolID;
					classID																	= StringUtils.equals(request.getName().trim(),"Class ID")?request.getValue().trim():classID;
					className																= StringUtils.equals(request.getName().trim(),"Class Name")?request.getValue().trim():className;
					classTeacherID															= StringUtils.equals(request.getName().trim(),"Class Teacher ID")?request.getValue().trim():classTeacherID;
					classTeacherName														= StringUtils.equals(request.getName().trim(),"Class Teacher Name")?request.getValue().trim():classTeacherName;
				}
					
				classTeacherDomain.setSchoolID(Long.valueOf(schoolID));
				classTeacherDomain.setClassID(Long.valueOf(classID));
				classTeacherDomain.setClassTeacherID(Long.valueOf(classTeacherID));
				classTeacherDomain.setClassName(className);
				classTeacherDomain.setClassTeacherName(classTeacherName);
				classTeacherDomain.setStatus(activeStatus);
				
				classTeacherDomain.setCreatedBy(createdBy);
				classTeacherDomain.setModifiedBy(createdBy);
				classTeacherDomain.setCreatedDate(new Date());
				classTeacherDomain.setModifiedDate(new Date());
				
				classTeacherRepository.save(classTeacherDomain);

				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered Class-Teacher");
				/**
				 * Send response back to controller
				 */
				response.setStatus("Saved");
				response.setMessage("Details have been successfully saved to the Database.");
				
		}catch(Exception ex){
			
			logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + ex.toString());
			
			response.setStatus("Not Saved");
			response.setMessage("Due to technical diffculities,details were not successfully saved to the Database. Please try again later.");
		}
		
		return response;
	}
}
