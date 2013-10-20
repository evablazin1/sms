package com.education.web.restful.controller;

import javax.servlet.http.HttpSession;

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
import com.education.web.helper.UserRegistrationHelper;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;
import com.education.web.security.SecurityHelper;

@Controller
@RequestMapping(value="/restful")
public class UserRegistrationRestfulController {
	
	@Autowired
	UserRepository userRepository;

	
	private static final Logger logger = LoggerFactory.getLogger(UserRegistrationRestfulController.class);

	

	
	
	/**
	 * 
	 * @param requests
	 * @param role
	 * @param email
	 * @param phone
	 * @return
	 */
	@RequestMapping(value="/register-user", method = RequestMethod.POST,  headers="Accept=application/json")
	public @ResponseBody Response registerAgent(HttpSession session,@RequestBody Request[] requests,@RequestParam(required=true) String role,@RequestParam(required=true) String email,@RequestParam(required=true) String phone)
	{ 
		Response response														= new Response();
		UserRegistrationHelper userRegistrationHelper							= new UserRegistrationHelper();
		String createdBy														= !StringUtils.isEmpty((String)session.getAttribute(SecurityHelper.USER_NAME))?(String)session.getAttribute(SecurityHelper.USER_NAME):"Super-Admin";
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register");
		
		//save details to the DB depending on role
		if(StringUtils.equals(StringUtils.trim(role),"System-Admin")){
			
			logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register " + role );
			response							= userRegistrationHelper.saveAdminDetails(requests,role,email,phone,createdBy);
		
		}else{
			
			logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register " + role);
			response							= userRegistrationHelper.saveAgentDetails(requests,role,email,phone,createdBy);
		
		}

		return response;
	}

}
