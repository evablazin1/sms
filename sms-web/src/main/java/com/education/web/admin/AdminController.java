package com.education.web.admin;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/admin")
public class AdminController {
	
	
	
	@Value("${security.groups}")
	private String securityGroups;
	
	@Value("${titles}")
	private String title;
	
	/**
	 * 
	 * @return
	 */
	@RequestMapping(value="/register-admin")
	public String registerUser(Model model){
		
		String [] groups		=	 StringUtils.split(this.securityGroups, ",");
		String [] titles		=	 StringUtils.split(this.title, ",");
		//check access level
		model.addAttribute("groups", groups);
		model.addAttribute("titles", titles);
		
		return "admin/register-admin";
	}

}
