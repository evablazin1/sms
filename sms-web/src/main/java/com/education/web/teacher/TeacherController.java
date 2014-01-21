package com.education.web.teacher;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value="/teacher")
public class TeacherController {
	
	private static final Logger logger 							= LoggerFactory.getLogger(TeacherController.class);
	
	@Value("${school.groups}")
	private String schoolGroups;
	
	@Value("${titles}")
	private String title;
	
	
	
	
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @return
	 */
	@RequestMapping(value="/list-of-teachers")
	public String listOfTeachers(Model model,@RequestParam(required=true) Long schoolID){
		
		model.addAttribute("schoolID", schoolID);
		return "teacher/list-of-teachers";
	}
	
	
	
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @return
	 */
	@RequestMapping(value="/register-teacher")
	public String registerSchool(Model model,@RequestParam(required=true) Long schoolID){
		
		String [] groups		=	 StringUtils.split(this.schoolGroups, ",");
		String [] titles		=	 StringUtils.split(this.title, ",");
		
		//check access level
		model.addAttribute("groups", groups);
		model.addAttribute("titles", titles);
		model.addAttribute("schoolID", schoolID);
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to register teacher for school with ID : "+ schoolID );
		
		return "teacher/register-teacher";
	}
}
