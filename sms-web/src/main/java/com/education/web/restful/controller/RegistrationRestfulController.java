package com.education.web.restful.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.education.web.helper.AdminRegistrationHelper;
import com.education.web.helper.ClassRegistrationHelper;
import com.education.web.helper.SchoolRegistrationHelper;
import com.education.web.helper.SubjectRegistrationHelper;
import com.education.web.helper.TeacherRegistrationHelper;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;

@Controller
@RequestMapping(value="/restful")
public class RegistrationRestfulController {
	
	private static final Logger logger 											= LoggerFactory.getLogger(RegistrationRestfulController.class);

	
	/**
	 * 
	 * @param requests
	 * @param role
	 * @param email
	 * @param phone
	 * @return
	 */
	@RequestMapping(value="/register-system-admin", method = RequestMethod.POST,  headers="Accept=application/json")
	public @ResponseBody Response registerAgent(HttpSession session,@RequestBody Request[] requests)
	{ 
		
		Response response														= new Response();
		AdminRegistrationHelper adminRegistrationHelper							= new AdminRegistrationHelper();
		
		/**
		 * Delegate to registration helper
		 */
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register a system Administrator: ");
		response																= adminRegistrationHelper.saveSystemAdminDetails(session,requests);

		return response;
	}
	
	
	/**
	 * 
	 * @param session
	 * @param requests
	 * @param schoolName
	 * @return
	 */
	@RequestMapping(value="/register-school", method = RequestMethod.POST,  headers="Accept=application/json")
	public @ResponseBody Response registerSchool(HttpSession session,@RequestBody Request[] requests)
	{ 
		Response response														= new Response();
		SchoolRegistrationHelper schoolRegistrationHelper						= new SchoolRegistrationHelper();
		
		/**
		 * Delegate to registration helper
		 */
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register school");
		response																= schoolRegistrationHelper.saveSchoolDetails(session,requests);
		
		return response;
	}
	
	
	/**
	 * 
	 * @param session
	 * @param requests
	 * @param schoolName
	 * @return
	 */
	@RequestMapping(value="/register-teacher", method = RequestMethod.POST,  headers="Accept=application/json")
	public @ResponseBody Response registerTeacher(HttpSession session,@RequestBody Request[] requests)
	{ 
		Response response														= new Response();
		TeacherRegistrationHelper teacherRegistrationHelper						= new TeacherRegistrationHelper();
		
		/**
		 * Delegate to registration helper
		 */
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register teacher");
		response																= teacherRegistrationHelper.saveTeacherDetails(session,requests);
		
		return response;
	}
	
	
	/**
	 * 
	 * @param session
	 * @param requests
	 * @param schoolName
	 * @return
	 */
	@RequestMapping(value="/register-class", method = RequestMethod.POST,  headers="Accept=application/json")
	public @ResponseBody Response registerClass(HttpSession session,@RequestBody Request[] requests)
	{ 
		Response response														= new Response();
		ClassRegistrationHelper classRegistrationHelper							= new ClassRegistrationHelper();
		
		/**
		 * Delegate to registration helper
		 */
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register class");
		response																= classRegistrationHelper.saveClassDetails(session,requests);
		
		return response;
	}
	
	
	@RequestMapping(value="/register-subject", method = RequestMethod.POST,  headers="Accept=application/json")
	public @ResponseBody Response registerSubject(HttpSession session,@RequestBody Request[] requests)
	{ 
		Response response														= new Response();
		SubjectRegistrationHelper subjectRegistrationHelper						= new SubjectRegistrationHelper();
		
		/**
		 * Delegate to registration helper
		 */
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register class");
		response																= subjectRegistrationHelper.saveSubjectDetails(session,requests);
		
		return response;
	}

}
