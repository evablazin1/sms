package com.education.web.helper;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.education.domain.system.admin.SystemAdminEntityAttributesDomain;
import com.education.domain.system.admin.SystemAdminEntityDomain;
import com.education.domain.users.UserDomain;
import com.education.repository.system.admin.SystemAdminEntityAttributesRepository;
import com.education.repository.system.admin.SystemAdminEntityRepository;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;

@Component("SystemAdminRegistrationHelper")
public class SystemAdminRegistrationHelper {

	@Autowired
	SystemAdminEntityRepository systemadminentityrepository;
	
	@Autowired
	SystemAdminEntityAttributesRepository systemadminentityattributesrepository;
	
	private static SystemAdminEntityRepository systemAdminEntityRepository;
	private static SystemAdminEntityAttributesRepository systemAdminEntityAttributesRepository;
	
	private static final Logger logger 												   = LoggerFactory.getLogger(SystemAdminRegistrationHelper.class);
	
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){

		 systemAdminEntityRepository													= this.systemadminentityrepository;
		 systemAdminEntityAttributesRepository											= this.systemadminentityattributesrepository;
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
	public Response saveSystemAdminDetails(Request[] requests,String role,String username,String password,String phone,String createdBy,String fullName){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering admin details ");
		Response response																	= new Response();	
		SystemAdminEntityDomain systemAdminEntityDomain		    							= new SystemAdminEntityDomain();
		List<SystemAdminEntityAttributesDomain> systemAdminEntityAttributesDomains  		= new ArrayList<SystemAdminEntityAttributesDomain>();
		
		try{
				
				
				/**
				 *  Delegate to User registration helper
				 */
			
				UserRegistrationHelper userRegistrationHelper								= new UserRegistrationHelper();
				UserDomain userDomain 														= userRegistrationHelper.saveUserDetails(role,username,password,phone,createdBy,fullName);
				
				/**
				 * Save details to system admin entity table
				 */
				systemAdminEntityDomain.setUserID(userDomain.getId());
				systemAdminEntityDomain														= systemAdminEntityRepository.save(systemAdminEntityDomain);
				
				
				
				/**
				 * save to system admin entity attributes table
				 */
				for(Request request : requests){
					SystemAdminEntityAttributesDomain systemAdminEntityAttributesDomain 	= new SystemAdminEntityAttributesDomain();
					
					systemAdminEntityAttributesDomain.setAdminEntityID(systemAdminEntityDomain.getId());
					systemAdminEntityAttributesDomain.setAttribute(request.getName());
					
					systemAdminEntityAttributesDomain.setAttributeValue(StringUtils.trim(request.getValue()));
		
					systemAdminEntityAttributesDomains.add(systemAdminEntityAttributesDomain);
				}
				
				systemAdminEntityAttributesRepository.save(systemAdminEntityAttributesDomains);
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered user details");
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Delegating to MailHelper");
				
				
				
				
				
				/**
				 * ***********************************************************************
				 * Delegate to mailhelper to send login details to new user for activation
				 * *********************************************************************** 
				 */
				//TODO: Add sms impementation
				MailHelper mailHelper														=  new MailHelper();
				
				String addresses[]															= {StringUtils.trim(username)};				
				mailHelper.sendMail("Login Details", addresses, StringUtils.trim(username), password);
				
				/**
				 * Send response back to controller
				 */
				response.setStatus("Saved");
				response.setMessage("Details have been successfully saved to the Database.");
				
		}catch(Exception ex){
			
			logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + ex.toString());
			
			response.setStatus("Not Saved");
			response.setMessage("Due to technical diffculities,details were not successfully saved to the Database. Please try again later.");
		}
		
		return response;
	}
}
