package com.education.web.student;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.education.repository.classes.ClassRepository;
import com.education.repository.student.StudentRepository;

@Controller
@RequestMapping(value="/student")
public class StudentController {
	
	/**
	 * 
	 */
	@Autowired
	ClassRepository classRepository;
	
	
	
	/**
	 * 
	 */
	@Autowired
	StudentRepository studentRepository;
	
	
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @return
	 */
	@RequestMapping(value="/list-of-subjects")
	public String listOfSubjects(Model model,@RequestParam(required=true) Long schoolID,
									@RequestParam(required=true) Long classID,@RequestParam(required=true) Long studentID){
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("classID", classID);
		model.addAttribute("studentID", studentID);

		return "student/list-of-subjects";
	}
	
	
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @return
	 */
	@RequestMapping(value="/register-subject")
	public String registerSubject(Model model,@RequestParam(required=true) Long schoolID,
										@RequestParam(required=true) Long classID,@RequestParam(required=true) Long studentID){
				
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("classID", classID);
		model.addAttribute("studentID", studentID);
		
		model.addAttribute("className", classRepository.findOne(classID).getClassName());
		model.addAttribute("studentName", studentRepository.findOne(studentID).getFirstName()+" "+studentRepository.findOne(studentID).getLastName());
		
		
		return "student/register-subject";
	}

}
