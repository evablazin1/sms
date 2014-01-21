package com.education.web.classes;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value="class")
public class ClassController {
	
	private static final Logger logger 							= LoggerFactory.getLogger(ClassController.class);

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

}
