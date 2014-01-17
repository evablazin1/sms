package com.education.web.restful.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.education.web.helper.SchoolRegistrationHelper;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;


@Controller
@RequestMapping(value="/restful")
public class SchoolRegistrationRestfulConroller {
	
	
	private static final Logger logger = LoggerFactory.getLogger(SchoolRegistrationRestfulConroller.class);
	
	
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
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register school");
		response																= schoolRegistrationHelper.saveSchoolDetails(session,requests);
		
		return response;
	}

}
