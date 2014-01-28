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
import com.education.domain.student.StudentSubjectDomain;
import com.education.repository.student.StudentSubjectRepository;
import com.education.repository.subject.SubjectRepository;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;
import com.education.web.security.SecurityHelper;

@Component("studentSubjectRegistrationHelper")
public class StudentSubjectRegistrationHelper {
	

	/**
	 * 
	 */
	@Autowired
	StudentSubjectRepository studentsubjectrepository;
	
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
	private static StudentSubjectRepository studentSubjectRepository;
	private static SubjectRepository subjectRepository;
	private static final Logger logger 													= LoggerFactory.getLogger(StudentSubjectRegistrationHelper.class);
	
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){
		 
		inActiveStatus																	= this.inactivestatus;
		studentSubjectRepository														= this.studentsubjectrepository;
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
	public Response saveStudentSubjectDetails(HttpSession session,List<String> subjects,Long schoolID,Long classID,String className,Long studentID,String studentName){
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering student-subject details ");
	
		Response response								   								= new Response();
		List<StudentSubjectDomain> studentSubjectDomains								= new ArrayList<StudentSubjectDomain>();
		String createdBy																= !StringUtils.isEmpty((String)session.getAttribute(SecurityHelper.USER_NAME))?(String)session.getAttribute(SecurityHelper.USER_NAME):"Super-Admin";
		

		try{

			/**
			 * Save details to class subject table
			 */
			
			for(String subjectID:subjects){

						StudentSubjectDomain studentSubjectDomain								= new StudentSubjectDomain();
						
						studentSubjectDomain.setSchoolID(schoolID);
						studentSubjectDomain.setClassID(classID);
						studentSubjectDomain.setStudentID(studentID);
						studentSubjectDomain.setSubjectID(Long.valueOf(subjectID));
						studentSubjectDomain.setClassName(className);
						studentSubjectDomain.setStudentName(studentName);
						studentSubjectDomain.setSubjectName(subjectRepository.findOne(Long.valueOf(subjectID)).getSubjectName());
						
						studentSubjectDomain.setStatus(inActiveStatus);
						studentSubjectDomain.setCreatedBy(createdBy);
						studentSubjectDomain.setModifiedBy(createdBy);
						studentSubjectDomain.setCreatedDate(new Date());
						studentSubjectDomain.setModifiedDate(new Date());
						
						studentSubjectDomains.add(studentSubjectDomain);
					
			  }
		
				studentSubjectRepository.save(studentSubjectDomains);
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered subjects for student");
				
				response.setStatus("Saved");
				response.setMessage("Details have been successfully saved to the Database.");
	
		}catch(Exception ex){
			
			    logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + ex.toString());
			    
			    response.setStatus("Not Saved");
				response.setMessage("Due to technical diffculities,leads were not successfully saved to the Database. Please try again later.");
		}
		
		return response;
	}
	
	public Response saveStudentSubjectDetails(HttpSession session,Request[] requests){
		Response response								   								= new Response();
		
		String schoolID																= "";
		String classID																= "";
		String studentID															= "";
		String className															= "";
		String studentName															= "";
		String subject																= "";
		List<String> subjects													    = new ArrayList<String>();
		
		
		
		/**
		 * Retrieve and set variables from the request object
		 */
		for(Request request : requests){
			schoolID																= StringUtils.equals(request.getName().trim(),"School ID")?request.getValue().trim():schoolID;
			classID																	= StringUtils.equals(request.getName().trim(),"Class ID")?request.getValue().trim():classID;
			studentID																= StringUtils.equals(request.getName().trim(),"Student ID")?request.getValue().trim():studentID;
			className																= StringUtils.equals(request.getName().trim(),"Class Name")?request.getValue().trim():className;
			studentName																= StringUtils.equals(request.getName().trim(),"Student Name")?request.getValue().trim():studentName;
			
			/**
			 * Retrieve values from multiple select
			 */
			if(StringUtils.equals(request.getName().trim(),"Subjects")){
				subject																= request.getValue().trim();
				subjects.add(subject);
			}
			
		}
		
		response																	= saveStudentSubjectDetails(session, subjects, Long.valueOf(schoolID),Long.valueOf(classID),className, Long.valueOf(studentID),studentName);;
		
		return response;
		
	}
}
