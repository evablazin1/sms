package com.education.web.helper;

import java.util.Date;

import javax.annotation.PostConstruct;

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
	 * @param role
	 * @param username
	 * @param phone
	 * @param createdBy
	 * @param fullName
	 * @return
	 */
	public UserDomain saveUserDetails(String role,String username,String password,String phone,String createdBy,String fullName){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering admin details ");
	
		UserDomain	userDomain																= new UserDomain();
		UserGroupDomain	userGroupDomain														= new UserGroupDomain();

		
		try{
				
				
				/**
				 *  Save to users table
				 */
				userDomain.setFullName(fullName);
				userDomain.setUsername(StringUtils.trim(username));   //TODO:check for existing username
				userDomain.setPassword(DigestUtils.md5Hex(password));
				
				userDomain.setStatus(StringUtils.trim(inactiveStatus));
				userDomain.setCreatedBy(createdBy);
				
				userDomain.setCreatedDate(new Date());
				userDomain.setModifiedDate(new Date());
				userDomain																	= userRepository.save(userDomain);
				
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered user");
				
				
				
				/**
				 * Save details to user group table
				 */
				userGroupDomain.setUserID(userDomain.getId());
				userGroupDomain.setGroupName(role);
				
				userGroupRepository.save(userGroupDomain);
				
			}catch(Exception ex){
				logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + ex.toString());
		    }
		
		return userDomain;
	}
}
