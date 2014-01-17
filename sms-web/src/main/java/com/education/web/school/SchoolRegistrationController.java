package com.education.web.school;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/school")
public class SchoolRegistrationController {
	
	
	@RequestMapping(value="/register-school")
	public String registerSchool(){
		
		return "school/register-school";
	}

}
