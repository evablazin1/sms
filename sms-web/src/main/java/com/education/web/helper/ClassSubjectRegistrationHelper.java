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
import com.education.domain.classes.ClassSubjectDomain;
import com.education.repository.classes.ClassSubjectRepository;
import com.education.repository.subject.SubjectRepository;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;
import com.education.web.security.SecurityHelper;

@Component("classSubjectRegistrationHelper")
public class ClassSubjectRegistrationHelper {
	

	/**
	 * 
	 */
	@Autowired
	ClassSubjectRepository classsubjectrepository;
	
	/**
	 * 
	 */
	@Autowired
	SubjectRepository subjectrepository;

	
	/**
	 * 
	 */
	@Value("${inactive.status}")
	private String inactivestatus;
	
	
	/**
	 *  static variables
	 */
	private static String inActiveStatus;
	private static ClassSubjectRepository classSubjectRepository;
	private static SubjectRepository subjectRepository;
	private static final Logger logger 													= LoggerFactory.getLogger(ClassSubjectRegistrationHelper.class);
	
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){
		 
		inActiveStatus																	= this.inactivestatus;
		classSubjectRepository															= this.classsubjectrepository;
		subjectRepository																= this.subjectrepository;
	}
	
	
	
	
	
	/**
	 * 
	 * @param session
	 * @param subjects
	 * @param schoolID
	 * @param classID
	 * @param className
	 */
	public Response saveClassSubjectDetails(HttpSession session,List<String> subjects,Long schoolID,Long classID,String className){
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering class details ");
	
		Response response								   								= new Response();
		List<ClassSubjectDomain> classSubjectDomains								    = new ArrayList<ClassSubjectDomain>();
		String createdBy																= !StringUtils.isEmpty((String)session.getAttribute(SecurityHelper.USER_NAME))?(String)session.getAttribute(SecurityHelper.USER_NAME):"Super-Admin";
		

		try{

			/**
			 * Save details to class subject table
			 */
			
			for(String subjectID:subjects){
					
						ClassSubjectDomain classSubjectDomain								= new ClassSubjectDomain();
						
						classSubjectDomain.setSchoolID(schoolID);
						classSubjectDomain.setClassID(classID);
						classSubjectDomain.setSubjectID(Long.valueOf(subjectID));
						classSubjectDomain.setClassName(className);
						classSubjectDomain.setSubjectName(subjectRepository.findOne(Long.valueOf(subjectID)).getSubjectName());
						
						classSubjectDomain.setStatus(inActiveStatus);
						classSubjectDomain.setCreatedBy(createdBy);
						classSubjectDomain.setModifiedBy(createdBy);
						classSubjectDomain.setCreatedDate(new Date());
						classSubjectDomain.setModifiedDate(new Date());
						
						classSubjectDomains.add(classSubjectDomain);
					
			  }

				classSubjectRepository.save(classSubjectDomains);
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered subjects for class");
				
				response.setStatus("Saved");
				response.setMessage("Details have been successfully saved to the Database.");
	
		}catch(Exception ex){
			
			    logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + ex.toString());
			    
			    response.setStatus("Not Saved");
				response.setMessage("Due to technical diffculities,leads were not successfully saved to the Database. Please try again later.");
		}
		
		return response;
	}
	
	public Response saveClassSubjectDetails(HttpSession session,Request[] requests){
		Response response								   								= new Response();
		
		String schoolID																= "";
		String classID																= "";
		String className															= "";
		String subject																= "";
		List<String> subjects													    = new ArrayList<String>();
		
		
		
		/**
		 * Retrieve and set variables from the request object
		 */
		for(Request request : requests){
			schoolID																= StringUtils.equals(request.getName().trim(),"School ID")?request.getValue().trim():schoolID;
			classID																	= StringUtils.equals(request.getName().trim(),"Class ID")?request.getValue().trim():classID;
			className																= StringUtils.equals(request.getName().trim(),"Class Name")?request.getValue().trim():className;
			
			/**
			 * Retrieve values from multiple select
			 */
			if(StringUtils.equals(request.getName().trim(),"Subjects")){
				subject																= request.getValue().trim();
				subjects.add(subject);
			}
			
		}
		
		response																	= saveClassSubjectDetails(session, subjects, Long.valueOf(schoolID), Long.valueOf(classID), className);
		
		return response;
		
	}
}
