package com.education.web.helper;

import java.util.Date;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.education.domain.school.SchoolDomain;
import com.education.repository.school.SchoolRepository;
import com.education.web.restful.request.model.Request;
import com.education.web.restful.response.model.Response;
import com.education.web.security.SecurityHelper;

@Component("SchoolRegistrationHelper")
public class SchoolRegistrationHelper {
	
	@Autowired
	SchoolRepository schoolrepository;
	
	@Value("${inactive.status}")
	private String inactivestatus;
	
	
	private static String inActiveStatus;
	private static SchoolRepository schoolRepository;
	
	private static final Logger logger 												= LoggerFactory.getLogger(SchoolRegistrationHelper.class);
	
	
	/**
	 * To initialize an instance of the autowired dependencies,because you cant autowire a static dependency
	 */
	@PostConstruct
	public void initializeDependency(){
		 
		inActiveStatus																	= this.inactivestatus;
		schoolRepository																= this.schoolrepository;
	}
	
	
	/**
	 * 
	 * @param requests
	 * @param schoolName
	 * @param createdBy
	 * @return
	 */
	public Response saveSchoolDetails(HttpSession session,Request[] requests){
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Registering school details ");
		
		Response response								   								= new Response();
		SchoolDomain schoolDomain														= new SchoolDomain();	
		String createdBy																= !StringUtils.isEmpty((String)session.getAttribute(SecurityHelper.USER_NAME))?(String)session.getAttribute(SecurityHelper.USER_NAME):"Super-Admin";
		
		
		try{
			
			/**
			 * Save details to school table
			 */
			
			String nameOfSchool															= "";
			String address																= "";
			String suburb																= "";
			String postalCode															= "";

			String city																	= "";
			String province																= "";
			String country																= "";
			
			
			
			/**
			 * Retrieve and set variables from the request object
			 */
			for(Request request : requests){
				nameOfSchool															= StringUtils.equals(request.getName().trim(),"Name of School")?request.getValue().trim():nameOfSchool;
				address																	= StringUtils.equals(request.getName().trim(),"Address")?request.getValue().trim():address;
				suburb																	= StringUtils.equals(request.getName().trim(),"Suburb")?request.getValue().trim():suburb;
				postalCode																= StringUtils.equals(request.getName().trim(),"Postal Code")?request.getValue().trim():postalCode;
				
				city																	= StringUtils.equals(request.getName().trim(),"City")?request.getValue().trim():city;
				province																= StringUtils.equals(request.getName().trim(),"Province")?request.getValue().trim():province;
				country																	= StringUtils.equals(request.getName().trim(),"Country")?request.getValue().trim():country;
			}
			
			schoolDomain.setNameOfSchool(nameOfSchool);
			schoolDomain.setAddress(address);
			schoolDomain.setSuburb(suburb);
			schoolDomain.setPostalCode(postalCode);
			
			schoolDomain.setCity(city);
			schoolDomain.setProvince(province);
			schoolDomain.setCountry(country);
			schoolDomain.setStatus(inActiveStatus);
			
			schoolDomain.setCreatedBy(createdBy);
			schoolDomain.setModifiedBy(createdBy);
			schoolDomain.setCreatedDate(new Date());
			schoolDomain.setModifiedDate(new Date());
			
			schoolRepository.save(schoolDomain);

			logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> successfully registered school");
			
			response.setStatus("Saved");
			response.setMessage("Details have been successfully saved to the Database.");
			
		}catch(Exception ex){
			
			logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + ex.toString());
			
			response.setStatus("Not Saved");
			response.setMessage("Due to technical diffculities,leads were not successfully saved to the Database. Please try again later.");
		}
		
		return response;
		
	}

}
