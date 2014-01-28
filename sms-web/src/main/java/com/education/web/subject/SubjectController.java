package com.education.web.subject;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping(value="subject")
public class SubjectController {
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @return
	 */
	@RequestMapping(value="/list-of-subjects")
	public String listOfSubjects(Model model,@RequestParam(required=true) Long schoolID){
		
		model.addAttribute("schoolID", schoolID);
		return "subject/list-of-subjects";
	}
	
	
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @return
	 */
	@RequestMapping(value="/register-subject")
	public String registerSubject(Model model,@RequestParam(required=true) Long schoolID){
				
		model.addAttribute("schoolID", schoolID);
		return "subject/register-subject";
	}
	
	

	@RequestMapping(value="/list-of-classes")
	public String listOfClasses(Model model,@RequestParam(required=true) Long schoolID,@RequestParam(required=true) Long subjectID){
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("subjectID", subjectID);
		
		return "subject/list-of-classes";
	}
	
	@RequestMapping(value="/student-subject")
	public String listOfStudents(Model model,@RequestParam(required=true) Long schoolID,@RequestParam(required=true) Long classID,
									@RequestParam(required=true) Long subjectID){
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("classID", classID);
		model.addAttribute("subjectID", subjectID);
		
		return "subject/student-subject";
	}

}
