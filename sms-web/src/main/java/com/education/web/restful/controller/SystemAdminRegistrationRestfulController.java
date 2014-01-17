package com.education.web.restful.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.education.repository.users.UserRepository;
import com.education.web.helper.SystemAdminRegistrationHelper;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;

@Controller
@RequestMapping(value="/restful")
public class SystemAdminRegistrationRestfulController {
	
	@Autowired
	UserRepository userRepository;

	
	private static final Logger logger 											= LoggerFactory.getLogger(SystemAdminRegistrationRestfulController.class);

	
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
		SystemAdminRegistrationHelper systemAdminRegistrationHelper				= new SystemAdminRegistrationHelper();
		
		/**
		 * Delegate to registration helper
		 */
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register a system Administrator: ");
		response																= systemAdminRegistrationHelper.saveSystemAdminDetails(session,requests);

		return response;
	}

}
