package com.education.web.subject;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.education.domain.classes.ClassDomain;
import com.education.repository.classes.ClassRepository;


@Controller
@RequestMapping(value="subject")
public class SubjectController {
	
	@Autowired
	ClassRepository classRepository;
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @return
	 */
	@RequestMapping(value="/list-of-subjects")
	public String listOfSubjects(Model model,@RequestParam(required=true) Long schoolID,@RequestParam(required=true) Long classID){
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("classID", classID);
		return "subject/list-of-subjects";
	}
	
	
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @return
	 */
	@RequestMapping(value="/register-subject")
	public String registerSubject(Model model,@RequestParam(required=true) Long schoolID,@RequestParam(required=true) Long classID){
		
		ClassDomain  classDomain							=	classRepository.findOne(classID);
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("classID", classID);
		model.addAttribute("className", classDomain.getClassName());
		
		return "subject/register-subject";
	}

}
