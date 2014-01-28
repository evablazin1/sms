package com.education.web.helper;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import com.education.domain.student.StudentDomain;
import com.education.domain.users.UserDomain;
import com.education.repository.student.StudentRepository;
import com.education.repository.users.UserRepository;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;
import com.education.web.security.SecurityHelper;

@Component("studentRegistrationHelper")
public class StudentRegistrationHelper {

	@Autowired
	StudentRepository studentrepository;
	
	@Autowired
	UserRepository userrepository;
	
	@Value("${inactive.status}")
	private String inactivestatus;

	private static String inactiveStatus;
	private static StudentRepository studentRepository;
	private static UserRepository userRepository;
	
	private static final Logger logger 												   = LoggerFactory.getLogger(StudentRegistrationHelper.class);
	
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){
		 inactiveStatus																	= this.inactivestatus;
		 studentRepository															    = this.studentrepository;
		 userRepository															   		= this.userrepository;
	}
	
	
	
	
	/**
	 * 
	 * @param session
	 * @param requests
	 * @return
	 */
	public Response saveStudentDetails(HttpSession session,Request[] requests){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering student details ");
		
		Response response																	= new Response();	
		StudentDomain studentDomain		    												= new StudentDomain();
		
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
				
				String schoolID																= "";
				String classID																= "";
				String className															= "";
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
				String subject																= "";
				List<String> subjects													    = new ArrayList<String>();

				
				
				/**
				 * Retrieve and set variables from the request object
				 */
				for(Request request : requests){
					
					schoolID																= StringUtils.equals(request.getName().trim(),"School ID")?request.getValue().trim():schoolID;
					classID																	= StringUtils.equals(request.getName().trim(),"Class ID")?request.getValue().trim():classID;
					className																= StringUtils.equals(request.getName().trim(),"Class Name")?request.getValue().trim():className;
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
					
					/**
					 * Retrieve values from multiple select
					 */
					if(StringUtils.equals(request.getName().trim(),"Subjects")){
						subject																= request.getValue().trim();
						subjects.add(subject);
					}
				}
					
				
				studentDomain.setUserID(userDomain.getId());
				studentDomain.setSchoolID(Long.valueOf(schoolID));
				studentDomain.setClassID(Long.valueOf(classID));
				studentDomain.setClassName(className);
				studentDomain.setStatus(inactiveStatus);
				studentDomain.setFirstName(firstName);
				studentDomain.setLastName(lastName);
				
				studentDomain.setSex(sex);
				studentDomain.setDateOfBirth(new SimpleDateFormat("dd/MM/yyyy").parse(dateOfBirth));
				studentDomain.setAge(Integer.valueOf(age));
				studentDomain.setMobileNumber(mobileNumber);
				
				studentDomain.setEmailAddress(emailAddress);
				studentDomain.setCountryOfOrigin(countryOfOrigin);
				studentDomain.setIdNumber(idNumber);
				studentDomain.setCountryOfResidence(countryOfResidence);
				
				studentDomain.setProvince(province);
				studentDomain.setCity(city);
				studentDomain.setAddress(address);
				studentDomain.setSuburb(suburb);
				
				studentDomain.setPostalCode(postalCode);
				studentDomain.setCreatedBy(createdBy);
				studentDomain.setModifiedBy(createdBy);
				studentDomain.setCreatedDate(new Date());
				studentDomain.setModifiedDate(new Date());
				
				studentDomain																	= studentRepository.save(studentDomain);
				String studentName																= firstName+" "+lastName;
				
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered student");
				logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sending login details to new user");
				
				StudentSubjectRegistrationHelper  studentSubjectRegistrationHelper				= new StudentSubjectRegistrationHelper();
				response																		= studentSubjectRegistrationHelper.saveStudentSubjectDetails(session, subjects, Long.valueOf(schoolID),Long.valueOf(classID),className, studentDomain.getId(),studentName);
				
				
				
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
