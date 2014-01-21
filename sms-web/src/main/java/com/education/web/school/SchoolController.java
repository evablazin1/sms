package com.education.web.school;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/school")
public class SchoolController {
	
	/**
	 * 
	 * @return
	 */
	@RequestMapping(value="/list-of-schools")
	public String listOfSchools(){
		
		return "school/list-of-schools";
	}
	
	
	@RequestMapping(value="/register-school")
	public String registerSchool(){
		
		return "school/register-school";
	}

}
