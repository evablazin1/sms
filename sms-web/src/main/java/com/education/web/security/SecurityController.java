package com.education.web.security;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.education.web.security.model.LoginModel;

@Controller
public class SecurityController {
	

	
	private static final Logger logger 						= LoggerFactory.getLogger(SecurityController.class);
	
	
	
	
	/**
	 * 
	 * @param session
	 * @param loginModel
	 * @return
	 */
	@RequestMapping(value="/login",method =RequestMethod.GET)
	public String login(HttpSession session,@ModelAttribute("loginModel") LoginModel loginModel)
	{		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> directing to login");
		
		if( SecurityHelper.isAuthenticated(session) ){
			logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> User authenticated");
		
			//TODO:  get user and direct to dash board according to role
			//UserDomain userDomain      = (UserDomain) session.getAttribute(SecurityHelper.USER);
			
			return "redirect:/";
		}
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> No Authenticated user found,redirecting to login page");
		return "security/login";
	}

	
	
	
	
	
	
	
	/**
	 * 
	 * @param session
	 * @param loginModel
	 * @return
	 */
	@RequestMapping(value="/login",method =RequestMethod.POST)
	public String loginPost(HttpSession session,@ModelAttribute("loginModel") LoginModel loginModel)
	{	
		if(SecurityHelper.authenticateUser(session,loginModel.getProfileNumber(),loginModel.getPinNumber()))
		{
			return "redirect:/";
		}
		
		loginModel.setMessage("Incorrect Login details.Please enter correct profile-number and pin");
		return "security/login";
	}
	
	
	
	/**
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/logout", method =RequestMethod.GET)
	public String logOut( HttpSession session)
	{
		if( session.getAttribute(SecurityHelper.USER) == null )
			return "security/logout";
		
		try{
			session.invalidate();
		}catch (Exception e) {
			logger.error( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  failed to invalidate session : session @ " + session );
		}
		
		return "security/logout";
	}

}
