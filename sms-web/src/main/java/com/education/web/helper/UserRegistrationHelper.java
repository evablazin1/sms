package com.education.web.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.education.domain.agents.AgentEntityAttributesDomain;
import com.education.domain.agents.AgentEntityDomain;
import com.education.domain.system.admin.SystemAdminEntityAttributesDomain;
import com.education.domain.system.admin.SystemAdminEntityDomain;
import com.education.domain.users.UserDomain;
import com.education.repository.agents.AgentEntityAttributesRepository;
import com.education.repository.agents.AgentEntityRepository;
import com.education.repository.system.admin.SystemAdminEntityAttributesRepository;
import com.education.repository.system.admin.SystemAdminEntityRepository;
import com.education.repository.users.UserRepository;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;

@Component("UserRegistrationHelper")
public class UserRegistrationHelper {
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	SystemAdminEntityRepository systemAdminEntityRepository;
	
	@Autowired
	SystemAdminEntityAttributesRepository systemAdminEntityAttributesRepository;
	
	@Autowired
	AgentEntityRepository agentEntityRepository;
	
	@Autowired
	AgentEntityAttributesRepository agentEntityAttributesRepository;
	

	private static UserRepository newUserRepository;
	private static SystemAdminEntityRepository newSystemAdminEntityRepository;
	
	private static SystemAdminEntityAttributesRepository newSystemAdminEntityAttributesRepository;
	private static AgentEntityRepository newAgentEntityRepository;
	
	private static AgentEntityAttributesRepository newAgentEntityAttributesRepository;
	
	private static final Logger logger 												= LoggerFactory.getLogger(UserRegistrationHelper.class);
	
	
	
	
	
	
	/**
	 * 
	 * @param requests
	 * @param role
	 * @param username
	 * @param phone
	 * @param createdBy
	 * @return
	 */
	public Response saveAdminDetails(Request[] requests,String role,String username,String phone,String createdBy){
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering admin details ");
		
		Response response															= new Response();		
		UserDomain	userDomain														= new UserDomain();
		
		List<SystemAdminEntityAttributesDomain> systemAdminEntityAttributesDomains  = new ArrayList<SystemAdminEntityAttributesDomain>();
		String password																= RandomStringUtils.randomAlphanumeric(8);
		
		try{
				
				//Save to users table
				userDomain.setUsername(StringUtils.trim(username));   //check for existing username
				userDomain.setPassword(DigestUtils.md5Hex(password));
				
				userDomain.setStatus("Inactive");
				userDomain.setGroupName(role);
				
				userDomain.setCreatedBy(createdBy);
				userDomain.setCreatedDate(new Date());
				
				userDomain.setModifiedDate(new Date());
				
				userDomain															= newUserRepository.save(userDomain);
				
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registered user");
				
				
				//Save details to entity table
				SystemAdminEntityDomain systemAdminEntityDomain		    					= new SystemAdminEntityDomain();	
				
				systemAdminEntityDomain.setUserID(userDomain.getId());
				systemAdminEntityDomain														= newSystemAdminEntityRepository.save(systemAdminEntityDomain);
				
				
				
				//save to entity attributes table
				for(Request request : requests){
				SystemAdminEntityAttributesDomain systemAdminEntityAttributesDomain 	= new SystemAdminEntityAttributesDomain();
					
					systemAdminEntityAttributesDomain.setAdminEntityID(systemAdminEntityDomain.getId());
					systemAdminEntityAttributesDomain.setAttribute(request.getName());
					
					systemAdminEntityAttributesDomain.setAttributeValue(StringUtils.trim(request.getValue()));
		
					systemAdminEntityAttributesDomains.add(systemAdminEntityAttributesDomain);
				}
				
				newSystemAdminEntityAttributesRepository.save(systemAdminEntityAttributesDomains);
				
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Delegating to MailHelper");
				
				MailHelper mailHelper														=  new MailHelper();
				
				//TODO: Add sms impementation
				String addresses[]															= {StringUtils.trim(username)};				
				mailHelper.sendMail("Login Details", addresses, StringUtils.trim(username), password);
				
				response.setStatus("Saved");
				response.setMessage("Details have been successfully saved to the Database.");
				
		}catch(Exception ex){
			
			logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + ex.toString());
			
			response.setStatus("Not Saved");
			response.setMessage("Due to technical diffculities,leads were not successfully saved to the Database. Please try again later.");
		}
		
		return response;
	}


	
	
	
	
	
	
	
	
	/**
	 * 
	 * @param requests
	 * @param role
	 * @param username
	 * @param phone
	 * @param createdBy
	 * @return
	 */
	public Response saveAgentDetails(Request[] requests,String role,String username,String phone,String createdBy){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering agent details ");
		
		Response response															= new Response();		
		UserDomain	userDomain														= new UserDomain();
		
		List<AgentEntityAttributesDomain> agentEntityAttributesDomains  			= new ArrayList<AgentEntityAttributesDomain>();
		String password																= RandomStringUtils.randomAlphanumeric(8);
		
		try{
				
				//Save to users table
				userDomain.setUsername(StringUtils.trim(username));   //check for existing username
				userDomain.setPassword(DigestUtils.md5Hex(password));
				
				userDomain.setStatus("Inactive");
				userDomain.setGroupName(role);
				
				userDomain.setCreatedBy(createdBy);
				userDomain.setCreatedDate(new Date());
				
				userDomain.setModifiedDate(new Date());
				
				userDomain															= newUserRepository.save(userDomain);
				
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registered user");
				
				
				//Save details to entity table
				AgentEntityDomain agentEntityDomain		    						= new AgentEntityDomain();	
				agentEntityDomain.setUserID(userDomain.getId());
				
				agentEntityDomain													= newAgentEntityRepository.save(agentEntityDomain);
				
				
				
				//save to entity attributes table
				for(Request request : requests){
					AgentEntityAttributesDomain agentEntityAttributesDomain 	= new AgentEntityAttributesDomain();
					
					agentEntityAttributesDomain.setAgentEntityID(agentEntityDomain.getId());
					agentEntityAttributesDomain.setAttribute(request.getName());
				
					agentEntityAttributesDomain.setAttributeValue(StringUtils.trim(request.getValue()));
		
					agentEntityAttributesDomains.add(agentEntityAttributesDomain);
				}
			
				newAgentEntityAttributesRepository.save(agentEntityAttributesDomains);
				
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Delegating to MailHelper");
				
				MailHelper mailHelper														=  new MailHelper();
				
				
				//TODO: Add sms impementation
				String addresses[]															= {StringUtils.trim(username)};				
				mailHelper.sendMail("Login Details", addresses, StringUtils.trim(username), password);
				
				response.setStatus("Saved");
				response.setMessage("Details have been successfully saved to the Database.");
				
		}catch(Exception ex){
			
			logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + ex.toString());
			
			response.setStatus("Not Saved");
			response.setMessage("Due to technical diffculities,leads were not successfully saved to the Database. Please try again later.");
		}
		
		return response;
	}
	
	

	//To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	@PostConstruct
	public void initializeDependency(){
		 
		 newUserRepository							= this.userRepository;
		 newSystemAdminEntityRepository				= this.systemAdminEntityRepository;
		 
		 newSystemAdminEntityAttributesRepository	= this.systemAdminEntityAttributesRepository;
		 newAgentEntityRepository					= this.agentEntityRepository;
		 
		 newAgentEntityAttributesRepository			= this.agentEntityAttributesRepository;
	}

}
