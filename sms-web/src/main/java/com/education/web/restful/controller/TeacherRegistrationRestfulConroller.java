package com.education.web.restful.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.education.web.helper.TeacherRegistrationHelper;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;


@Controller
@RequestMapping(value="/restful")
public class TeacherRegistrationRestfulConroller {
	
	
	private static final Logger logger = LoggerFactory.getLogger(TeacherRegistrationRestfulConroller.class);
	
	
	/**
	 * 
	 * @param session
	 * @param requests
	 * @param schoolName
	 * @return
	 */
	@RequestMapping(value="/register-teacher", method = RequestMethod.POST,  headers="Accept=application/json")
	public @ResponseBody Response registerSchool(HttpSession session,@RequestBody Request[] requests)
	{ 
		Response response														= new Response();
		TeacherRegistrationHelper teacherRegistrationHelper						= new TeacherRegistrationHelper();
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register teacher");
		response																= teacherRegistrationHelper.saveTeacherDetails(session,requests);
		
		return response;
	}

}
