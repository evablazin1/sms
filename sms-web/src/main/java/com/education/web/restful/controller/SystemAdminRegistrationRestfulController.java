package com.education.web.restful.controller;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.education.repository.users.UserRepository;
import com.education.web.helper.SystemAdminRegistrationHelper;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;
import com.education.web.security.SecurityHelper;

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
	public @ResponseBody Response registerAgent(HttpSession session,@RequestBody Request[] requests,
													@RequestParam(required=true) String role,@RequestParam(required=true) String email,
														@RequestParam(required=true) String phone,@RequestParam(required=true) String fullName)
	{ 
		
		Response response														= new Response();
		SystemAdminRegistrationHelper systemAdminRegistrationHelper				= new SystemAdminRegistrationHelper();
		
		String createdBy														= !StringUtils.isEmpty((String)session.getAttribute(SecurityHelper.USER_NAME))?(String)session.getAttribute(SecurityHelper.USER_NAME):"Super-Admin";
		String password															= RandomStringUtils.randomAlphanumeric(8);
		
		/**
		 * Delegate to registration helper
		 */
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register : " + role);
		response																= systemAdminRegistrationHelper.saveSystemAdminDetails(requests,role,email,password,phone,createdBy,fullName);

		return response;
	}

}
