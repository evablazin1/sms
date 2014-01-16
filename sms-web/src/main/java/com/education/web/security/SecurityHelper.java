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

import com.education.repository.users.UserGroupRepository;
import com.education.repository.users.UserRepository;


@Component("SecurityHelper")
public class SecurityHelper {
	
	@Value("${security.groups}")
	private String securitygroups;
	
	@Autowired
	UserRepository userrepository;
	
	@Autowired
	UserGroupRepository usergrouprepository;

	
	private static String securityGroups;
	private static UserRepository userRepository;
	private static UserGroupRepository userGroupRepository;
	
	public static final String USER											= "AUTHENTICATED_USER";
	public static final String USER_NAME									= "AUTHENTICATED_USER_NAME";
	public static final String USER_GROUP									= "AUTHENTICATED_USER_GROUP";
	
	private static final Logger logger 										= LoggerFactory.getLogger(SecurityHelper.class);
	
	
	
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){
		
		securityGroups														= this.securitygroups;
		userRepository														= this.userrepository;
		userGroupRepository													= this.usergrouprepository;

	}
	
	
	
	
	
	/**
	 * 
	 * @param session
	 * @return
	 */
	public static boolean isAuthenticated( HttpSession session ){
		
		if(session.getAttribute(USER)!= null){
			
			/**
			 * Retrieve security groups and convert to list
			 */
			String [] groups												=	StringUtils.split(securityGroups, ",");
			List<String> groupList											=	Arrays.asList(groups);

			/**
			 * Check if user group exists
			 */
			List<String> groupNames										    = (List<String>) session.getAttribute(USER_GROUP);
			for(String groupName: groupNames){
				if(groupList.contains(groupName))
					return true;
			}
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
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> About to authenticate user : " + username);
		
		try{
			
			/**
			 * Retrieve User from database by Username
			 */
			UserDomain userDomain													=	userRepository.findByUsername(StringUtils.trim(username));
			
			/**
			 * Validate if user exists
			 */
			if(userDomain!=null){
			
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> User found : " + userDomain.getUsername());
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Full Name : " + userDomain.getFullName());
				
				/**
				 * Validate Password
				 */
				if(StringUtils.equals(DigestUtils.md5Hex(password), userDomain.getPassword())){
					
					logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Password authenticated ");
				
					session.setAttribute(USER, userDomain);
					session.setAttribute(USER_NAME, StringUtils.trim(userDomain.getFullName()));
					session.setAttribute(USER_GROUP, userGroupRepository.retrieveUserGroup(userDomain.getId()));
					
					for( String group : (List<String>) session.getAttribute(USER_GROUP)){
						logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> logged in user's group  " + group );
					}
					
				return true;
				}
			}
		}catch(Exception ex){
			logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + ex.toString());
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
		List<String> groups															= (List<String>) session.getAttribute(USER_GROUP);
		if(groups.contains(groupName)){
			logger.debug( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Found match, user is in group " + groupName );
			return true;
		}
		return false;
	}
}
