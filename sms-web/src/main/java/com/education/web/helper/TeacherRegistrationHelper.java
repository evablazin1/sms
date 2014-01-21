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
import com.education.domain.teacher.TeacherDomain;
import com.education.domain.users.UserDomain;
import com.education.repository.teacher.TeacherRepository;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;
import com.education.web.security.SecurityHelper;

@Component("TeacherRegistrationHelper")
public class TeacherRegistrationHelper {

	@Autowired
	TeacherRepository teacherrepository;
	
	@Value("${inactive.status}")
	private String inactivestatus;

	private static String inactiveStatus;
	private static TeacherRepository teacherRepository;
	
	private static final Logger logger 												   = LoggerFactory.getLogger(TeacherRegistrationHelper.class);
	
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){
		 inactiveStatus																	= this.inactivestatus;
		 teacherRepository																= this.teacherrepository;
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
	public Response saveTeacherDetails(HttpSession session,Request[] requests){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering teacher details ");
		
		Response response																	= new Response();	
		TeacherDomain teacherDomain		    												= new TeacherDomain();
		
		String createdBy																	= !StringUtils.isEmpty((String)session.getAttribute(SecurityHelper.USER_NAME))?(String)session.getAttribute(SecurityHelper.USER_NAME):"Super-Admin";
		String password																		= RandomStringUtils.randomAlphanumeric(8);
		
		try{
				
				
				/**
				 *  Delegate to User registration helper
				 */
			
				UserRegistrationHelper userRegistrationHelper								= new UserRegistrationHelper();
				UserDomain userDomain 														= userRegistrationHelper.saveUserDetails(session,requests,password,createdBy);
				
				/**
				 * Save details to Teacher table
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
				String schoolID																= "";

				
				
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
					schoolID																= StringUtils.equals(request.getName().trim(),"School ID")?request.getValue().trim():schoolID;
				}
					
				teacherDomain.setUserID(userDomain.getId());
				teacherDomain.setSchoolID(Long.valueOf(schoolID));
				teacherDomain.setStatus(inactiveStatus);
				teacherDomain.setTitle(title);
				teacherDomain.setFirstName(firstName);
				teacherDomain.setLastName(lastName);
				
				teacherDomain.setSex(sex);
				teacherDomain.setDateOfBirth(new SimpleDateFormat("dd/MM/yyyy").parse(dateOfBirth));
				teacherDomain.setAge(Integer.valueOf(age));
				teacherDomain.setMobileNumber(mobileNumber);
				
				teacherDomain.setEmailAddress(emailAddress);
				teacherDomain.setCountryOfOrigin(countryOfOrigin);
				teacherDomain.setIdNumber(idNumber);
				teacherDomain.setCountryOfResidence(countryOfResidence);
				
				teacherDomain.setProvince(province);
				teacherDomain.setCity(city);
				teacherDomain.setAddress(address);
				teacherDomain.setSuburb(suburb);
				
				teacherDomain.setPostalCode(postalCode);
				teacherDomain.setCreatedBy(createdBy);
				teacherDomain.setModifiedBy(createdBy);
				teacherDomain.setCreatedDate(new Date());
				teacherDomain.setModifiedDate(new Date());
				
				teacherRepository.save(teacherDomain);

				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered Teacher");
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Delegating to MailHelper");
				
				
				
				
				
				/**
				 * ***********************************************************************
				 * Delegate to mailhelper to send login details to new user for activation
				 * *********************************************************************** 
				 */
				//TODO: Add sms impementation
				MailHelper mailHelper														=  new MailHelper();
				
				String addresses[]															= {StringUtils.trim(emailAddress)};				
				mailHelper.sendMail("Login Details", addresses, StringUtils.trim(emailAddress), password);
				
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
