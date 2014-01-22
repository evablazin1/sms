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
import com.education.domain.subject.SubjectDomain;
import com.education.repository.subject.SubjectRepository;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;
import com.education.web.security.SecurityHelper;

@Component("subjectRegistrationHelper")
public class SubjectRegistrationHelper {
	
	@Autowired
	SubjectRepository subjectrepository;
	
	@Value("${inactive.status}")
	private String inactivestatus;
	
	
	private static String inActiveStatus;
	private static SubjectRepository subjectRepository;
	
	private static final Logger logger 													= LoggerFactory.getLogger(SubjectRegistrationHelper.class);
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){
		 
		inActiveStatus																	= this.inactivestatus;
		subjectRepository																= this.subjectrepository;
	}
	
	public Response saveSubjectDetails(HttpSession session,Request[] requests){
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering class details ");
		
		Response response								   								= new Response();
		SubjectDomain subjectDomain														= new SubjectDomain();	
		String createdBy																= !StringUtils.isEmpty((String)session.getAttribute(SecurityHelper.USER_NAME))?(String)session.getAttribute(SecurityHelper.USER_NAME):"Super-Admin";
		
		
		try{
			
			/**
			 * Save details to school table
			 */
			
			String subjectName															= "";
			String className															= "";
			String classID																= "";
			String subjectTeacherID														= "";
			String subjectTeacherName													= "";
			String schoolID																= "";
			
			
			
			/**
			 * Retrieve and set variables from the request object
			 */
			for(Request request : requests){
				
				subjectName																= StringUtils.equals(request.getName().trim(),"Subject Name")?request.getValue().trim():subjectName;
				className																= StringUtils.equals(request.getName().trim(),"Class Name")?request.getValue().trim():className;
				classID																	= StringUtils.equals(request.getName().trim(),"Class ID")?request.getValue().trim():classID;
				subjectTeacherID														= StringUtils.equals(request.getName().trim(),"Subject Teacher")?request.getValue().trim():subjectTeacherID;
				subjectTeacherName														= StringUtils.equals(request.getName().trim(),"Subject Teacher Name")?request.getValue().trim():subjectTeacherName;
				schoolID																= StringUtils.equals(request.getName().trim(),"School ID")?request.getValue().trim():schoolID;
			}
			
			subjectDomain.setSubjectName(subjectName);
			subjectDomain.setClassID(Long.valueOf(classID));
			subjectDomain.setClassName(className);
			
			subjectDomain.setSubjectTeacherID(Long.valueOf(subjectTeacherID));
			subjectDomain.setSubjectTeacherName(subjectTeacherName);
			subjectDomain.setSchoolID(Long.valueOf(schoolID));
			subjectDomain.setStatus(inActiveStatus);
			
			subjectDomain.setCreatedBy(createdBy);
			subjectDomain.setModifiedBy(createdBy);
			subjectDomain.setCreatedDate(new Date());
			subjectDomain.setModifiedDate(new Date());
			
			subjectRepository.save(subjectDomain);

			logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered class");
			
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
