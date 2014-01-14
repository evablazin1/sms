package com.education.web.school.registration;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SchoolRegistration {
	
	
	@RequestMapping(value="/register-school")
	public String registerSchool(){
		
		return "school-registration/register";
	}

}
