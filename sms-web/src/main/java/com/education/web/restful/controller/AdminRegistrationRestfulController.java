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
import com.education.web.helper.AdminRegistrationHelper;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;

@Controller
@RequestMapping(value="/restful")
public class AdminRegistrationRestfulController {
	
	@Autowired
	UserRepository userRepository;

	
	private static final Logger logger 											= LoggerFactory.getLogger(AdminRegistrationRestfulController.class);

	
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
		AdminRegistrationHelper adminRegistrationHelper				= new AdminRegistrationHelper();
		
		/**
		 * Delegate to registration helper
		 */
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register a system Administrator: ");
		response																= adminRegistrationHelper.saveSystemAdminDetails(session,requests);

		return response;
	}

}
