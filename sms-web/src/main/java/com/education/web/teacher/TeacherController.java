package com.education.web.teacher;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.education.domain.teacher.TeacherDomain;
import com.education.repository.teacher.TeacherRepository;

@Controller
@RequestMapping(value="/teacher")
public class TeacherController {

	
	@Autowired
	TeacherRepository teacherRepository;
	
	/**
	 * 
	 */
	@Value("${school.groups}")
	private String schoolGroups;
	
	
	/**
	 * 
	 */
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
		
		/**
		 * check access level
		 */
		model.addAttribute("groups", groups);
		model.addAttribute("titles", titles);
		model.addAttribute("schoolID", schoolID);

		return "teacher/register-teacher";
	}
	
	
	

	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @param teacherID
	 * @return
	 */
	@RequestMapping(value="/list-of-classes")
	public String listOfClasses(Model model,@RequestParam(required=true) Long schoolID,@RequestParam(required=true) Long teacherID){
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("teacherID", teacherID);
		
		return "teacher/list-of-classes";
	}
	
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @param teacherID
	 * @return
	 */
	@RequestMapping(value="/register-class-teacher")
	public String registerClassTeacher(Model model,@RequestParam(required=true) Long schoolID,@RequestParam(required=true) Long teacherID){
		
		TeacherDomain teacherDomain							=	teacherRepository.findOne(teacherID);
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("teacherID", teacherID);
		model.addAttribute("classTeacherName", teacherDomain.getTitle()+" "+teacherDomain.getFirstName()+" "+teacherDomain.getLastName());
		
		return "teacher/register-class-teacher";
	}
	
	
	
	/**
	 * 
	 * @param model
	 * @param schoolID
	 * @param teacherID
	 * @return
	 */
	@RequestMapping(value="/list-of-subjects")
	public String listOfSubjects(Model model,@RequestParam(required=true) Long schoolID,@RequestParam(required=true) Long teacherID){
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("teacherID", teacherID);
		
		return "teacher/list-of-subjects";
	}
	
	@RequestMapping(value="/register-subject-teacher")
	public String registerSubjectTeacher(Model model,@RequestParam(required=true) Long schoolID,@RequestParam(required=true) Long teacherID){
		
		TeacherDomain teacherDomain							=	teacherRepository.findOne(teacherID);
		
		model.addAttribute("schoolID", schoolID);
		model.addAttribute("teacherID", teacherID);
		model.addAttribute("subjectTeacherName", teacherDomain.getTitle()+" "+teacherDomain.getFirstName()+" "+teacherDomain.getLastName());
		
		return "teacher/register-subject-teacher";
	}
}
