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
import com.education.domain.teacher.SubjectTeacherDomain;
import com.education.repository.teacher.SubjectTeacherRepository;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;
import com.education.web.security.SecurityHelper;

@Component("subjectTeacherRegistrationHelper")
public class SubjectTeacherRegistrationHelper {

	/**
	 * 
	 */
	@Autowired
	SubjectTeacherRepository subjectteacherrepository;
	
	/**
	 * 
	 */
	@Value("${active.status}")
	private String activestatus;

	/**
	 * 
	 */
	private static String activeStatus;
	private static SubjectTeacherRepository subjectTeacherRepository;
	
	private static final Logger logger 												   = LoggerFactory.getLogger(SubjectTeacherRegistrationHelper.class);
	
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){
		 activeStatus																	= this.activestatus;
		 subjectTeacherRepository														= this.subjectteacherrepository;
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
	public Response saveSubjectTeacherDetails(HttpSession session,Request[] requests){

		Response response																	= new Response();	
		SubjectTeacherDomain subjectTeacherDomain		    								= new SubjectTeacherDomain();
		
		String createdBy																	= !StringUtils.isEmpty((String)session.getAttribute(SecurityHelper.USER_NAME))?(String)session.getAttribute(SecurityHelper.USER_NAME):"Super-Admin";
		
		try{
				
				/**
				 * Save details to Subject Teacher table
				 */
				
				String schoolID															    = "";
				String classID																= "";
				String subjectID															= "";
				String subjectTeacherID														= "";
				String className															= "";
				String subjectName															= "";
				String subjectTeacherName													= "";
			
				/**
				 * Retrieve and set variables from the request object
				 */
				for(Request request : requests){
					schoolID																= StringUtils.equals(request.getName().trim(),"School ID")?request.getValue().trim():schoolID;
					classID																	= StringUtils.equals(request.getName().trim(),"Class ID")?request.getValue().trim():classID;
					subjectID																= StringUtils.equals(request.getName().trim(),"Subject ID")?request.getValue().trim():subjectID;
					subjectTeacherID														= StringUtils.equals(request.getName().trim(),"Subject Teacher ID")?request.getValue().trim():subjectTeacherID;
					className																= StringUtils.equals(request.getName().trim(),"Class Name")?request.getValue().trim():className;
					subjectName																= StringUtils.equals(request.getName().trim(),"Subject Name")?request.getValue().trim():subjectName;
					subjectTeacherName														= StringUtils.equals(request.getName().trim(),"Subject Teacher Name")?request.getValue().trim():subjectTeacherName;
				}
					
				subjectTeacherDomain.setSchoolID(Long.valueOf(schoolID));
				subjectTeacherDomain.setClassID(Long.valueOf(classID));
				subjectTeacherDomain.setSubjectID(Long.valueOf(subjectID));
				subjectTeacherDomain.setSubjectTeacherID(Long.valueOf(subjectTeacherID));
				subjectTeacherDomain.setClassName(className);
				subjectTeacherDomain.setSubjectName(subjectName);
				subjectTeacherDomain.setSubjectTeacherName(subjectTeacherName);
				subjectTeacherDomain.setStatus(activeStatus);
				
				subjectTeacherDomain.setCreatedBy(createdBy);
				subjectTeacherDomain.setModifiedBy(createdBy);
				subjectTeacherDomain.setCreatedDate(new Date());
				subjectTeacherDomain.setModifiedDate(new Date());
				
				subjectTeacherRepository.save(subjectTeacherDomain);

				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered Subject-Teacher");
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
