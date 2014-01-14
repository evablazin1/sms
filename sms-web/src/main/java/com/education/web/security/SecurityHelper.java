package com.education.web.security;


import java.util.Arrays;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.education.domain.users.UserDomain;
import com.education.repository.agents.AgentEntityRepository;
import com.education.repository.system.admin.SystemAdminEntityRepository;
import com.education.repository.users.UserRepository;


@Component
public class SecurityHelper {
	
	@Value("${security.groups}")
	private String securityGroups;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	SystemAdminEntityRepository systemAdminEntityRepository;

	@Autowired
	AgentEntityRepository agentEntityRepository;
	
	private static String newSecurityGroups;
	private static UserRepository newUserRepository;
	
	private static SystemAdminEntityRepository newSystemAdminEntityRepository;
	private static AgentEntityRepository newAgentEntityRepository;
	
	public static final String USER											= "AUTHENTICATED_USER";
	public static final String USER_GROUP									= "AUTHENTICATED_USER_GROUP";
	public static final String USER_NAME									= "AUTHENTICATED_USER_NAME";
	
	private static final Logger logger 										= LoggerFactory.getLogger(SecurityHelper.class);
	
	
	
	
	
	/**
	 * 
	 * @param session
	 * @return
	 */
	public static boolean isAuthenticated( HttpSession session ){
		
		if(session.getAttribute(USER)!= null){
			
			//Retrieve security groups and convert to list
			String [] groups									=	StringUtils.split(newSecurityGroups, ",");
			List<String> groupList								=	Arrays.asList(groups);

			//Check if user group exists
			if(groupList.contains((String)session.getAttribute( USER_GROUP)))
			 return true;
		}
		return false;
	}
	

	
	
	
	
	/**
	 * 
	 * @param session
	 * @return
	 */
	public static UserDomain getAuthenticatedUser(HttpSession session){
		return (UserDomain) session.getAttribute(USER);
	}

	
	
	
	
	
	
	
	/**
	 * 
	 * @param session
	 * @param username
	 * @param password
	 * @param userRepository
	 * @return
	 */
	public static boolean authenticateUser( HttpSession session, String username,String password){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> About to authenticate user : " + username);
		
		try{
			
			//Retrieve User from database by Username
			UserDomain userDomain										=	newUserRepository.findByUsername(StringUtils.trim(username));
			
			//Validate if user exists
			if(userDomain!=null){
			
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> User found : " + userDomain.getUsername());
				
				//Validate Password
				if(StringUtils.equals(DigestUtils.md5Hex(password), userDomain.getPassword())){
					
					logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> Password authenticated ");
				
					session.setAttribute(USER, userDomain);
					session.setAttribute(USER_GROUP, userDomain.getGroupName());
					
					String fullName										= "";
					
					
					logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> logged in user's group  " + (String)session.getAttribute(USER_GROUP));
					
					//Retrieve Full name based on users group
					if(StringUtils.equals((String)session.getAttribute(USER_GROUP), "System-Admin")){
						
						List<String> names								=	 newSystemAdminEntityRepository.findUsersFullName(userDomain.getId());
						
						for(String name:names){
							fullName									+= name + " ";
						}
						
						logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> Logged in user's full name :  " + fullName );
						session.setAttribute(USER_NAME, StringUtils.trim(fullName));
					}
					
					
					if(StringUtils.equals((String)session.getAttribute(USER_GROUP), "Head-Agent")
							||StringUtils.equals((String)session.getAttribute(USER_GROUP), "Agent")){
						
						List<String> names								=	 newAgentEntityRepository.findUsersFullName(userDomain.getId());
						
						for(String name:names){
							fullName									+= name + " ";
						}
						
						logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> Logged in user's full name :  " + fullName );
						session.setAttribute(USER_NAME, StringUtils.trim(fullName));
					}
					
					
					return true;
				}
			}
		}catch(Exception ex){
			logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + ex.toString());
		}
		return false;
	}

	
	/**
	 * 
	 * @param session
	 * @param groupName
	 * @return
	 */
	public static boolean isUserInGroup(HttpSession session, String groupName){
	 if(session.getAttribute(USER_GROUP ).equals(groupName)){
		logger.debug( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Found match, user is in group " + groupName );
		return true;
	  }
		return false;
	}
	
	
	
	//To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	@PostConstruct
	public void initializeDependency(){
		
		 newSecurityGroups							= this.securityGroups;
		 newUserRepository							= this.userRepository;
		
		 newSystemAdminEntityRepository				= this.systemAdminEntityRepository;
		 newAgentEntityRepository					= this.agentEntityRepository;
	}
}
