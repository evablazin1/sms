package com.education.web.teacher;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.education.web.controller.IndexController;

@Controller
@RequestMapping(value="/teacher")
public class TeacherRegistrationController {
	
	private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@Value("${school.groups}")
	private String schoolGroups;
	
	@RequestMapping(value="/register-teacher")
	public String registerSchool(Model model,@RequestParam(required=true) Long schoolID){
		
		String [] groups		=	 StringUtils.split(this.schoolGroups, ",");
		//check access level
		model.addAttribute("groups", groups);
		model.addAttribute("schoolID", schoolID);
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register teachers for school with ID : "+ schoolID );
		
		return "teacher/register-teacher";
	}

}
