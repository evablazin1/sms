package com.education.web.systemadmin;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/system-admin")
public class SystemAdminRegistrationController {
	
	
	
	@Value("${security.groups}")
	private String securityGroups;
	
	/**
	 * 
	 * @return
	 */
	@RequestMapping(value="/register-system-admin")
	public String registerUser(Model model){
		
		String [] groups		=	 StringUtils.split(this.securityGroups, ",");
		//check access level
		model.addAttribute("groups", groups);
		
		return "system-admin/register-system-admin";
	}

}
