package com.education.web.helper;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.education.domain.admin.AdminDomain;
import com.education.domain.users.UserDomain;
import com.education.repository.admin.AdminRepository;
import com.education.repository.users.UserRepository;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;
import com.education.web.security.SecurityHelper;

@Component("adminRegistrationHelper")
public class AdminRegistrationHelper {

	@Autowired
	AdminRepository adminrepository;
	
	@Autowired
	UserRepository userrepository;
	
	@Value("${inactive.status}")
	private String inactivestatus;

	private static String inactiveStatus;
	private static AdminRepository adminRepository;
	private static UserRepository userRepository;
	
	private static final Logger logger 												   = LoggerFactory.getLogger(AdminRegistrationHelper.class);
	
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){
		 inactiveStatus																	= this.inactivestatus;
		 adminRepository															    = this.adminrepository;
		 userRepository															   		= this.userrepository;
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
	public Response saveSystemAdminDetails(HttpSession session,Request[] requests){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering admin details ");
		
		Response response																	= new Response();	
		AdminDomain adminDomain		    													= new AdminDomain();
		
		String createdBy																	= !StringUtils.isEmpty((String)session.getAttribute(SecurityHelper.USER_NAME))?(String)session.getAttribute(SecurityHelper.USER_NAME):"Super-Admin";
		String profileNumber																= generateProfileNumber();
		String pinNumber																	= RandomStringUtils.randomNumeric(4);
		
		try{
				
				
				/**
				 *  Delegate to User registration helper
				 */
			
				UserRegistrationHelper userRegistrationHelper								= new UserRegistrationHelper();
				UserDomain userDomain 														= userRegistrationHelper.saveUserDetails(session,requests,profileNumber,pinNumber,createdBy);
				
				/**
				 * Save details to admin table
				 */
				String title															    = "";
				String firstName															= "";
				String lastName																= "";
				String sex																	= "";
				String dateOfBirth															= "";
				
				String age																	= "";
				String mobileNumber															= "";
				String emailAddress															= "";
				String countryOfOrigin														= "";
				
				String idNumber																= "";
				String countryOfResidence													= "";
				String province																= "";
				String city																	= "";
				
				String address																= "";
				String suburb																= "";
				String postalCode															= "";

				
				
				/**
				 * Retrieve and set variables from the request object
				 */
				for(Request request : requests){
					title																    = StringUtils.equals(request.getName().trim(),"Title")?request.getValue().trim():title;
					firstName																= StringUtils.equals(request.getName().trim(),"First Name")?request.getValue().trim():firstName;
					lastName																= StringUtils.equals(request.getName().trim(),"Last Name")?request.getValue().trim():lastName;
					sex																		= StringUtils.equals(request.getName().trim(),"Sex")?request.getValue().trim():sex;
					dateOfBirth																= StringUtils.equals(request.getName().trim(),"Date of Birth")?request.getValue().trim():dateOfBirth;
					
					age																		= StringUtils.equals(request.getName().trim(),"Age")?request.getValue().trim():age;
					mobileNumber															= StringUtils.equals(request.getName().trim(),"Mobile Number")?request.getValue().trim():mobileNumber;
					emailAddress															= StringUtils.equals(request.getName().trim(),"Email Address")?request.getValue().trim():emailAddress;
					countryOfOrigin															= StringUtils.equals(request.getName().trim(),"Country of Origin")?request.getValue().trim():countryOfOrigin;
					
					idNumber																= StringUtils.equals(request.getName().trim(),"Passport/ID Number")?request.getValue().trim():idNumber;
					countryOfResidence														= StringUtils.equals(request.getName().trim(),"Country of Residence")?request.getValue().trim():countryOfResidence;
					province																= StringUtils.equals(request.getName().trim(),"Province")?request.getValue().trim():province;
					city																	= StringUtils.equals(request.getName().trim(),"City")?request.getValue().trim():city;
					
					address																	= StringUtils.equals(request.getName().trim(),"Address")?request.getValue().trim():address;
					suburb																	= StringUtils.equals(request.getName().trim(),"Suburb")?request.getValue().trim():suburb;
					postalCode																= StringUtils.equals(request.getName().trim(),"Postal Code")?request.getValue().trim():postalCode;
				}
					
				adminDomain.setUserID(userDomain.getId());
				adminDomain.setStatus(inactiveStatus);
				adminDomain.setTitle(title);
				adminDomain.setFirstName(firstName);
				adminDomain.setLastName(lastName);
				
				adminDomain.setSex(sex);
				adminDomain.setDateOfBirth(new SimpleDateFormat("dd/MM/yyyy").parse(dateOfBirth));
				adminDomain.setAge(Integer.valueOf(age));
				adminDomain.setMobileNumber(mobileNumber);
				
				adminDomain.setEmailAddress(emailAddress);
				adminDomain.setCountryOfOrigin(countryOfOrigin);
				adminDomain.setIdNumber(idNumber);
				adminDomain.setCountryOfResidence(countryOfResidence);
				
				adminDomain.setProvince(province);
				adminDomain.setCity(city);
				adminDomain.setAddress(address);
				adminDomain.setSuburb(suburb);
				
				adminDomain.setPostalCode(postalCode);
				adminDomain.setCreatedBy(createdBy);
				adminDomain.setModifiedBy(createdBy);
				adminDomain.setCreatedDate(new Date());
				adminDomain.setModifiedDate(new Date());
				
				adminRepository.save(adminDomain);

				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered system admin");
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sending login details to new user");
				
				
				/**
				 * ***********************************************************************
				 * Delegate to smshelper to send login details to new user for activation
				 * *********************************************************************** 
				 */
				//TODO: Add sms impementation
				
				
				/**
				 * ***********************************************************************
				 * Delegate to mailhelper to send login details to new user for activation
				 * *********************************************************************** 
				 */
				if(StringUtils.isNotEmpty(emailAddress)){
					MailHelper mailHelper														=  new MailHelper();			
					mailHelper.sendMail("Login Details", emailAddress, profileNumber, pinNumber);
				}
				

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
	
	
	private String generateProfileNumber(){
		String randomNumber																		= "";
		
		/**
		 *  To check if a user already exists with a profile number
		 */
		do{
			randomNumber																		= RandomStringUtils.randomNumeric(8);
		}
		while(userRepository.findByProfileNumber(randomNumber)!=null);
			
		return randomNumber;
	}
}
