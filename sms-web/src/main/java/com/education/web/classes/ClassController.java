package com.education.web.classes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.education.repository.classes.ClassRepository;

@Controller
@RequestMapping(value="class")
public class ClassController {

	
	@Autowired
	ClassRepository classRepository;
	
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @return
	 */
	@RequestMapping(value="/list-of-classes")
	public String listOfClasses(Model model,@RequestParam(required=true) Long schoolID){
		
		model.addAttribute("schoolID", schoolID);
		return "class/list-of-classes";
	}
	
	
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @return
	 */
	@RequestMapping(value="/register-class")
	public String registerClass(Model model,@RequestParam(required=true) Long schoolID){
		
		model.addAttribute("schoolID", schoolID);
		return "class/register-class";
	}
	
	
	
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @param classID
	 * @return
	 */
	@RequestMapping(value="/list-of-subjects")
	public String listOfSubjects(Model model,@RequestParam(required=true) Long schoolID,Long classID){
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("classID", classID);
		
		return "class/list-of-subjects";
	}
	
	
	/**
	 *
	 * @param model
	 * @param schoolID
	 * @param classID
	 * @return
	 */
	@RequestMapping(value="/register-subject")
	public String registerSubject(Model model,@RequestParam(required=true) Long schoolID,Long classID){
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("classID", classID);
		model.addAttribute("className", classRepository.findOne(classID).getClassName());
		
		return "class/register-subject";
	}
	
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @param classID
	 * @return
	 */
	@RequestMapping(value="/list-of-students")
	public String listOfStudents(Model model,@RequestParam(required=true) Long schoolID,Long classID){
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("classID", classID);
		
		return "class/list-of-students";
	}
	
	
	/**
	 *
	 * @param model
	 * @param schoolID
	 * @param classID
	 * @return
	 */
	@RequestMapping(value="/register-student")
	public String registerStudent(Model model,@RequestParam(required=true) Long schoolID,Long classID){
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("classID", classID);
		model.addAttribute("className", classRepository.findOne(classID).getClassName());
		
		return "class/register-student";
	}
	
	@RequestMapping(value="/student-subject")
	public String listOfStudents(Model model,@RequestParam(required=true) Long schoolID,@RequestParam(required=true) Long classID,
									@RequestParam(required=true) Long subjectID){
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("classID", classID);
		model.addAttribute("subjectID", subjectID);
		
		return "class/student-subject";
	}
}
