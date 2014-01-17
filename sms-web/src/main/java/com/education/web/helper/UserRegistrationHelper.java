package com.education.web.helper;

import java.util.Date;

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
import com.education.domain.users.UserGroupDomain;
import com.education.repository.users.UserGroupRepository;
import com.education.repository.users.UserRepository;
import com.education.web.restful.request.model.Request;

@Component("UserRegistrationHelper")
public class UserRegistrationHelper {
	
	@Autowired
	UserRepository userrepository;
	
	@Autowired
	UserGroupRepository usergrouprepository;
	
	@Value("${inactive.status}")
	private String inactivestatus;
	
	private static String inactiveStatus;
	private static UserRepository userRepository;
	private static UserGroupRepository userGroupRepository;
	
	private static final Logger logger 												= LoggerFactory.getLogger(UserRegistrationHelper.class);
	
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){
		 
		 inactiveStatus																		= this.inactivestatus;
		 userRepository																		= this.userrepository;
		 userGroupRepository															    = this.usergrouprepository;
	}
	
	

	/**
	 * 
	 * @param session
	 * @param requests
	 * @param password
	 * @param createdBy
	 * @return
	 */
	public UserDomain saveUserDetails(HttpSession session,Request[] requests,String password,String createdBy){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering user details ");
	
		UserDomain	userDomain																= new UserDomain();
		UserGroupDomain	userGroupDomain														= new UserGroupDomain();
		try{
				String firstName															= "";
				String lastName																= "";
				String userName																= "";
				String groupName															= "";
				
				/**
				 * Retrieve and set variables from the request object
				 */
				for(Request request : requests){
					firstName																= StringUtils.equals(request.getName().trim(),"First Name")?request.getValue().trim():firstName;
					lastName																= StringUtils.equals(request.getName().trim(),"Last Name")?request.getValue().trim():lastName;
					userName																= StringUtils.equals(request.getName().trim(),"Email Address")?request.getValue().trim():userName;
					groupName																= StringUtils.equals(request.getName().trim(),"Group Name")?request.getValue().trim():groupName;
				}
				
				/**
				 *  Save to users table
				 */
				userDomain.setFirstName(firstName);
				userDomain.setLastName(lastName);
				userDomain.setUsername(StringUtils.trim(userName));   //TODO:check for existing username
				userDomain.setPassword(DigestUtils.md5Hex(password));
				
				userDomain.setStatus(StringUtils.trim(inactiveStatus));
				userDomain.setCreatedBy(createdBy);
				userDomain.setModifiedBy(createdBy);
				userDomain.setCreatedDate(new Date());
				userDomain.setModifiedDate(new Date());
				userDomain																	= userRepository.save(userDomain);
				
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered user");
				
				
				
				/**
				 * Save details to user group table
				 */
				userGroupDomain.setUserID(userDomain.getId());
				userGroupDomain.setGroupName(groupName);
				
				userGroupRepository.save(userGroupDomain);
				
			}catch(Exception ex){
				logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + ex.toString());
		    }
		
		return userDomain;
	}
}
