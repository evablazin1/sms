package com.education.web.school;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SchoolRegistrationController {
	
	
	@RequestMapping(value="/register-school")
	public String registerSchool(){
		
		return "school-registration/register";
	}

}
