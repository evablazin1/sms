<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="template" tagdir="/WEB-INF/tags" %>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp" %>
<template:base-page-layout>
	<jsp:attribute name="css">
	    <!-- Bootstrap core CSS -->
	  	<link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/bootstrap.css"/>" />
	    <link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/jquery-ui.css"/>" />
	    <link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/half-slider.css"/>" />
	</jsp:attribute>
		<jsp:attribute name="script">
	     <script type="text/javascript" src="<c:url value="/assets/js/jquery-1.10.2.min.js"/>" ></script>
	     <script type="text/javascript" src="<c:url value="/assets/js/jquery-1.6.1-allscripts.js"/>" ></script>
	     <script type="text/javascript" src="<c:url value="/assets/js/jquery-ui.min.js"/>" ></script>
	     
	    <!-- DWR Specific Mapping -->
		<script type="text/javascript" src="<c:url value="/dwr/engine.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/dwr/util.js"/>"></script>
		
		<!-- Attribute Services -->
		<script type="text/javascript" src="<c:url value="/dwr/interface/countryService.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/dwr/interface/provinceService.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/dwr/interface/cityService.js"/>"></script>
		
		<script type="text/javascript" src="<c:url value="/assets/js/yav.js"/>" ></script>
		<script type="text/javascript" src="<c:url value="/assets/js/yav-config.js"/>" ></script>
		<script type="text/javascript" src="<c:url value="/assets/js/bootstrap.js"/>" ></script>
	</jsp:attribute>
	<jsp:body>
		  <div class="span4"></div>
				<div class="span7">
				<h3>User Registration</h3>
					<form class="form-horizontal" id="agentRegistrationForm" >
						<table class="table table-striped table-hover" >
							<tr>
							    <td><label class="control-label" for="role"><Strong class="text-error span3">Role :</Strong></label></td>
								<td>
									<div class="controls">
										<select id="role" name="Role">
											<option value="">Select Role</option>
											<c:forEach items="${groups}" var="group" >
											  <option value="${group}">${group}</option>
											</c:forEach>
										</select>
									</div>
									<span class="innerError" id="errorsDiv_role" style="color:red;"></span>
								</td>
							</tr>
							<tr>
							    <td><label class="control-label" for="firstName"><Strong class="text-error span3">First Name :</Strong></label></td>
								<td>
									<div class="controls"><input type="text" id="firstName" name="First Name" placeholder="Enter your first name" /></div>
									<span class="innerError" id="errorsDiv_firstName" style="color:red;"></span>
								</td>
							</tr>
							<tr>
							    <td><label class="control-label" for="lastName"><Strong class="text-error span3">Last Name :</Strong></label></td>
								<td>
									<div class="controls"><input type="text" id="lastName" name="Last Name" placeholder="Enter your Last name" /></div>
									<span class="innerError" id="errorsDiv_lastName" style="color:red;"></span>
								</td>
							</tr>
							<tr>
							    <td><label class="control-label" for="sex"><Strong class="text-error span3">Sex :</Strong></label></td>
								<td>
									<div class="controls">
										<select id="sex" name="Sex">
											<option value="">Select a sex</option>
											<option value="Female">Female</option>
											<option value="Male">Male</option>
										</select>
									</div>
									<span class="innerError" id="errorsDiv_sex" style="color:red;"></span>
								</td>
							</tr>
							<tr>
							    <td><label class="control-label" for="dateOfBirth"><Strong class="text-error span3">Date of Birth :</Strong></label></td>
								<td>
									<div class="controls">
										<input type="text" id="dateOfBirth" name="Date of Birth" placeholder="Enter your date of birth" />
										<input type="hidden" id="age" name="Age"  />
									</div>
									<span class="innerError" id="errorsDiv_dateOfBirth" style="color:red;"></span>
								</td>
							</tr>
							<tr>
								<td><label class="control-label" for="countryOfOrigin"><Strong class="text-error span3">Country of Origin :</Strong></label></td>
									<td>
									   <div class="controls">
											<select id="countryOfOrigin" name="Country of Origin" >
																<option value="">Select Country</option>
																  <option value="Afghanistan" >Afghanistan</option>
																  <option value="Albania">Albania</option>
																  <option value="Algeria">Algeria</option>
																  <option value="American Samoa">American Samoa</option>
																  <option value="Andorra">Andorra</option>
																  <option value="Angola">Angola</option>
																  <option value="Anguilla">Anguilla</option>
																  <option value="Antarctica">Antarctica</option>
																  <option value="Antigua and Barbuda">Antigua and Barbuda</option>
																  <option value="Argentina">Argentina</option>
																  <option value="Armenia">Armenia</option>
																  <option value="Aruba">Aruba</option>
																  <option value="Australia">Australia</option>
																  <option value="Austria">Austria</option>
																  <option value="Azerbaijan">Azerbaijan</option>
																  <option value="Bahamas">Bahamas</option>
																  <option value="Bahrain">Bahrain</option>
																  <option value="Bangladesh">Bangladesh</option>
																  <option value="Barbados">Barbados</option>
																  <option value="Belarus">Belarus</option>
																  <option value="Belgium">Belgium</option>
																  <option value="Belize">Belize</option>
																  <option value="Benin">Benin</option>
																  <option value="Bermuda">Bermuda</option>
																  <option value="Bhutan">Bhutan</option>
																  <option value="Bolivia">Bolivia</option>
																  <option value="Bosnia &amp; Herzegovina">Bosnia &amp; Herzegovina</option>
																  <option value="Botswana">Botswana</option>
																  <option value="Bouvet Island">Bouvet Island</option>
																  <option value="Brazil">Brazil</option>
																  <option value="British Indian Ocean Territory">British Indian Ocean 
																	Territory</option>
																  <option value="British Virgin Islands">British Virgin Islands</option>
																  <option value="Brunei">Brunei</option>
																  <option value="Bulgaria">Bulgaria</option>
																  <option value="Burkina Faso">Burkina Faso</option>
																  <option value="Burundi">Burundi</option>
																  <option value="Cambodia">Cambodia</option>
																  <option value="Cameroon">Cameroon</option>
																  <option value="Canada">Canada</option>
																  <option value="Cape Verde">Cape Verde</option>
																  <option value="Cayman Islands">Cayman Islands</option>
																  <option value="Central African Republic">Central African Republic</option>
																  <option value="Chad">Chad</option>
																  <option value="Chile">Chile</option>
																  <option value="China">China</option>
																  <option value="Christmas Island">Christmas Island</option>
																  <option value="Cocos Island">Cocos Island</option>
																  <option value="Colombia">Colombia</option>
																  <option value="Comoros">Comoros</option>
																  <option value="Congo">Congo</option>
																  <option value="Cook Islands">Cook Islands</option>
																  <option value="Costa Rica">Costa Rica</option>
																  <option value="Croatia">Croatia</option>
																  <option value="Cuba">Cuba</option>
																  <option value="Cyprus">Cyprus</option>
																  <option value="Czech Republic">Czech Republic</option>
																  <option value="Denmark">Denmark</option>
																  <option value="Djibouti">Djibouti</option>
																  <option value="Dominica">Dominica</option>
																  <option value="Dominican Republic">Dominican Republic</option>
																  <option value="East Timor">East Timor</option>
																  <option value="Eucador">Eucador</option>
																  <option value="Eygpt">Eygpt</option>
																  <option value="El Salavador">El Salavador</option>
																  <option value="Equatorial Guinea">Equatorial Guinea</option>
																  <option value="Eritrea">Eritrea</option>
																  <option value="Estonia">Estonia</option>
																  <option value="Ethiopia">Ethiopia</option>
																  <option value="Falkland Islands">Falkland Islands</option>
																  <option value="Faroe Islands">Faroe Islands</option>
																  <option value="Fiji">Fiji</option>
																  <option value="Finland">Finland</option>
																  <option value="France">France</option>
																  <option value="French Guiana">French Guiana</option>
																  <option value="French Polynesia">French Polynesia</option>
																  <option value="French Southern Territories">French Southern Territories</option>
																  <option value="Gabon">Gabon</option>
																  <option value="Gambia">Gambia</option>
																  <option value="Georgia">Georgia</option>
																  <option value="Germany">Germany</option>
																  <option value="Ghana">Ghana</option>
																  <option value="Gibraltar">Gibraltar</option>
																  <option value="Greece">Greece</option>
																  <option value="Greenland">Greenland</option>
																  <option value="Grenada">Grenada</option>
																  <option value="Guadeloupe">Guadeloupe</option>
																  <option value="Guam">Guam</option>
																  <option value="Gutemala">Gutemala</option>
																  <option value="Guinea">Guinea</option>
																  <option value="Guinea-Bissau">Guinea-Bissau</option>
																  <option value="Guyana">Guyana</option>
																  <option value="Haiti">Haiti</option>
																  <option value="Heard &amp; McDonald Islands">Heard &amp; McDonald 
																	Islands</option>
																  <option value="Honduras">Honduras</option>
																  <option value="Hong Kong">Hong Kong</option>
																  <option value="Hungary">Hungary</option>
																  <option value="Iceland">Iceland</option>
																  <option value="India">India</option>
																  <option value="Indonesia">Indonesia</option>
																  <option value="Iran">Iran</option>
																  <option value="Iraq">Iraq</option>
																  <option value="Ireland">Ireland</option>
																  <option value="Israel">Israel</option>
																  <option value="Italy">Italy</option>
																  <option value="Ivory Coast">Ivory Coast</option>
																  <option value="Jamaica">Jamaica</option>
																  <option value="Japan">Japan</option>
																  <option value="Jordan">Jordan</option>
																  <option value="Kazakhstan">Kazakhstan</option>
																  <option value="Kenya">Kenya</option>
																  <option value="Kiribati">Kiribati</option>
																  <option value="Korea, North">Korea, North</option>
																  <option value="Korea, South">Korea, South</option>
																  <option value="Kuwait">Kuwait</option>
																  <option value="Kyrgyzstan">Kyrgyzstan</option>
																  <option value="Laos">Laos</option>
																  <option value="Latvia">Latvia</option>
																  <option value="Lebanon">Lebanon</option>
																  <option value="Lesotho">Lesotho</option>
																  <option value="Liberia">Liberia</option>
																  <option value="Libya">Libya</option>
																  <option value="Liechtenstein">Liechtenstein</option>
																  <option value="Lithuania">Lithuania</option>
																  <option value="Luxembourg">Luxembourg</option>
																  <option value="Macau">Macau</option>
																  <option value="Macedonia, Former Yugoslav Rep. of">Macedonia, Former 
																	Yugoslav Rep. of</option>
																  <option value="Madagascar">Madagascar</option>
																  <option value="Malawi">Malawi</option>
																  <option value="Malaysia">Malaysia</option>
																  <option value="Maldives">Maldives</option>
																  <option value="Mali">Mali</option>
																  <option value="Malta">Malta</option>
																  <option value="Marshall Islands">Marshall Islands</option>
																  <option value="Matinique">Matinique</option>
																  <option value="Mauritania">Mauritania</option>
																  <option value="Mauritius">Mauritius</option>
																  <option value="Mayotte">Mayotte</option>
																  <option value="Mexico">Mexico</option>
																  <option value="Micronesia, Federated States of">Micronesia, Federated 
																	States of</option>
																  <option value="Moldova">Moldova</option>
																  <option value="Monaco">Monaco</option>
																  <option value="Mongolia">Mongolia</option>
																  <option value="Montserrat">Montserrat</option>
																  <option value="Morocco">Morocco</option>
																  <option value="Mozambique">Mozambique</option>
																  <option value="Myanmar">Myanmar</option>
																  <option value="Namibia">Namibia</option>
																  <option value="Nauru">Nauru</option>
																  <option value="Nepal">Nepal</option>
																  <option value="Netherlands">Netherlands</option>
																  <option value="Netherlands Antilles">Netherlands Antilles</option>
																  <option value="New Caledonia">New Caledonia</option>
																  <option value="New Zealand">New Zealand</option>
																  <option value="Nicaragua">Nicaragua</option>
																  <option value="Niger">Niger</option>
																  <option value="Nigeria">Nigeria</option>
																  <option value="Niue">Niue</option>
																  <option value="Norfolk Island">Norfolk Island</option>
																  <option value="Northern Mariana Islands">Northern Mariana Islands</option>
																  <option value="Norway">Norway</option>
																  <option value="Oman">Oman</option>
																  <option value="Pakistan">Pakistan</option>
																  <option value="Palau">Palau</option>
																  <option value="Panama">Panama</option>
																  <option value="Paupau New Guinea">Paupau New Guinea</option>
																  <option value="Paraguay">Paraguay</option>
																  <option value="Peru">Peru</option>
																  <option value="Phillipines">Phillipines</option>
																  <option value="Pitcairn Islands">Pitcairn Islands</option>
																  <option value="Poland">Poland</option>
																  <option value="Portugal">Portugal</option>
																  <option value="Puerto Rico">Puerto Rico</option>
																  <option value="Quatar">Quatar</option>
																  <option value="Reunion">Reunion</option>
																  <option value="Romania">Romania</option>
																  <option value="Russia">Russia</option>
																  <option value="Rwanda">Rwanda</option>
																  <option value="S. Georgia and S. Wandwich Isls.">S. Georgia and S. 
																	Wandwich Isls.</option>
																  <option value="Saint Kitts &amp; Nevis">Saint Kitts &amp; Nevis</option>
																  <option value="Saint Vincent &amp; The Grenadines">Saint Vincent &amp; 
																	The Grenadines</option>
																  <option value="Samoa">Samoa</option>
																  <option value="San Marino">San Marino</option>
																  <option value="Sao Tome &amp; Principe">Sao Tome &amp; Principe</option>
																  <option value="Saudi Arabia">Saudi Arabia</option>
																  <option value="Senegal">Senegal</option>
																  <option value="Seychelles">Seychelles</option>
																  <option value="Sierria Leone">Sierria Leone</option>
																  <option value="Singapore">Singapore</option>
																  <option value="Slovakia">Slovakia</option>
																  <option value="Slovenia">Slovenia</option>
																  <option value="South Africa">South Africa</option>
																  <option value="Spain">Spain</option>
																  <option value="Sri Lanka">Sri Lanka</option>
																  <option value="St. Helena">St. Helena</option>
																  <option value="St. Pierre &amp; Miquelon">St. Pierre &amp; Miquelon</option>
																  <option value="Sudan">Sudan</option>
																  <option value="Suriname">Suriname</option>
																  <option value="Svabard &amp; Jan Mayen Islands">Svabard &amp; Jan 
																	Mayen Islands</option>
																  <option value="Swaziland">Swaziland</option>
																  <option value="Sweden">Sweden</option>
																  <option value="Switzerland">Switzerland</option>
																  <option value="Syria">Syria</option>
																  <option value="Taiwan">Taiwan</option>
																  <option value="Tajikistan">Tajikistan</option>
																  <option value="Tanzania">Tanzania</option>
																  <option value="Thailand">Thailand</option>
																  <option value="Togo">Togo</option>
																  <option value="Tokelau">Tokelau</option>
																  <option value="Tonga">Tonga</option>
																  <option value="Trinidad &amp; Tobago">Trinidad &amp; Tobago</option>
																  <option value="Tunisia">Tunisia</option>
																  <option value="Turkey">Turkey</option>
																  <option value="Turkemistan">Turkemistan</option>
																  <option value="Turks &amp; Caicos Island">Turks &amp; Caicos Island</option>
																  <option value="Tuvalu">Tuvalu</option>
																  <option value="U.S.A.">U.S.A.</option>
																  <option value="U.S. Minor Outlying Islands">U.S. Minor Outlying Islands</option>
																  <option value="Uganda">Uganda</option>
																  <option value="Ukraine">Ukraine</option>
																  <option value="United Arab Emirates">United Arab Emirates</option>
																  <option value="United Kingdom">United Kingdom</option>
																  <option value="Uruguay">Uruguay</option>
																  <option value="Uzbekistan">Uzbekistan</option>
																  <option value="Vanuatu">Vanuatu</option>
																  <option value="Vatican City">Vatican City</option>
																  <option value="Venezula">Venezula</option>
																  <option value="Vietnam">Vietnam</option>
																  <option value="Virgin Island">Virgin Island</option>
																  <option value="Wallis and Futuna Island">Wallis and Futuna Island</option>
																  <option value="Western Sahara">Western Sahara</option>
																  <option value="Yemen">Yemen</option>
																  <option value="Yugoslavia (Former)">Yugoslavia (Former)</option>
																  <option value="Zaire">Zaire</option>
																  <option value="Zambia">Zambia</option>
																  <option value="Zimbabwe">Zimbabwe</option>
											</select>
									   </div>
									<span class="innerError" id="errorsDiv_countryOfOrigin" style="color:red;"></span>
								</td>
							</tr>
							<tr>
							    <td><label class="control-label" for="idNumber"><Strong class="text-error span3">Passport/ID Nmuber :</Strong></label></td>
								<td>
									<div class="controls"><input type="text" id="idNumber" name="Passport/ID Number" placeholder="Enter your identification number" /></div>
									<span class="innerError" id="errorsDiv_idNumber" style="color:red;"></span>
								</td>
							</tr>
					
					
							<tr>
								<td><label class="control-label"><h4>Contact Information</h4></label></td>
							</tr>
					
							
							
							
							<tr>
								<td><label class="control-label" for="address"><Strong class="text-error span3">Address :</Strong></label></td>
								<td>
									<div class="controls"><textarea id="address" name="Address" placeholder="Address " row="3"></textarea></div>
									<span class="innerError" id="errorsDiv_address" style="color:red;"></span>
								</td>
							</tr>
							<tr>
								<td><label class="control-label" for="suburb"><Strong class="text-error span3">Suburb :</Strong></label></td>
								<td>
									<div class="controls"><input type="text" id="suburb" name="Suburb" placeholder="Suburb"  /></div>
									<span class="innerError" id="errorsDiv_suburb" style="color:red;"></span>
								</td>
							</tr>
							<tr>
								<td><label class="control-label" for="postalCode"><Strong class="text-error span3">Postal/Zip Code :</Strong></label></td>
								<td>
									<div class="controls"><input type="text" id="postalCode" name="Postal Code" placeholder="Postal/Zip Code"  /></div>
									<span class="innerError" id="errorsDiv_postalCode" style="color:red;"></span>
								</td>
	 						</tr>
							<tr>
								<td><label class="control-label" for="city"><Strong class="text-error span3">City :</Strong></label></td>
								<td>
									<div class="controls"><input type="text" id="city" name="City" placeholder="City"/></div>
									<span class="innerError" id="errorsDiv_city" style="color:red;"></span>
								</td>
							</tr>
							<tr>
								<td><label class="control-label" for="province"><Strong class="text-error span3">Province/Region :</Strong></label></td>
								<td>
									<div class="controls">
										<select id="province" name="Province">
											<option value="">Select a province</option>
											<option value="Eastern Cape">Eastern Cape</option>
											<option value="Free State">Free State</option>
											<option value="Gauteng">Gauteng</option>
											<option value="KwaZulu-Natal">KwaZulu-Natal</option>
											<option value="Limpopo">Limpopo</option>
											<option value="Mpumalanga">Mpumalanga</option>
											<option value="North West">North West</option>
											<option value="Northern Cape">Northern Cape</option>
											<option value="Western Cape">Western Cape</option>
										</select>
									</div>
									<span class="innerError" id="errorsDiv_province" style="color:red;"></span>
								</td>
							</tr>
							<tr>
								<td><label class="control-label" for="mobileNumber"><Strong class="text-error span3">Mobile Number :</Strong></label></td>
								<td>
									<div class="controls"><input type="text" id="mobileNumber" name="Mobile Number" placeholder="Mobile Number" /></div>
									<span class="innerError" id="errorsDiv_mobileNumber" style="color:red;"></span> 
								</td>
							</tr>
							<tr>
								<td><label class="control-label" for="emailAddress"><Strong class="text-error span3">Email Address :</Strong></label></td>
								<td>
									<div class="controls"><input type="text" id="emailAddress" name="Email Address" placeholder="someone@example.com" /></div>
									<span class="innerError" id="errorsDiv_emailAddress" style="color:red;"></span>
								</td>
		    				</tr>
						</table>
						<div class="btn-group pull-left">
						    <input id="reset" type="reset" class="btn btn-success" />
						</div>
					</form>
					<div class="btn-group pull-right">
							<button id="register" class="btn btn-success" onClick="javascript:registerAgent('agentRegistrationForm');" >
								<Strong> Register <i class="icon-hand-right icon-white"></i> </Strong>
							</button>
					</div>
					<div id="loading" style="display:none;position:absolute;top:50%;left:40%"><img src="<c:url value="/assets/images/loading.gif"/>" /></div>
				</div>
		  <div class="span4"></div>
		  <script type="text/javascript">

		  $(document).ready(function() {
				$("#dateOfBirth").datepicker({dateFormat: "mm/dd/yy",changeMonth: true,changeYear: true}); 
			});
		  
		  $( document ).ajaxStart(function() {
			  $( "#loading" ).show();
		   });
		  
		  $(document).ajaxComplete(function(){
			  $( "#loading" ).hide();
			}); 
		  
		  
		  
		  function registerAgent(formID){
			 $(".error").text("");
			   if(validateForm(formID)){
				   
				   //populate age field from date of birth
				   var age				=	getAge($("#dateOfBirth").val());
				   $("#age").val(age);
				   
				   //determine username and role
				   var role				=	$("#role").val();
				   var email		    =	$("#emailAddress").val();
				   var phone		    =	$("#mobileNumber").val();
				  
				   
				   //AJAX post
				   var formData  		= JSON.stringify($("#"+formID).serializeArray());
				   console.log(formData);
						$.ajax ({
		    				url			: "/sms/restful/register-user?role="+role+"&email="+email+"&phone="+phone,
		    				type		: "POST",
		    				data		: formData,
		    				dataType	: "json",
		   		 			contentType	: "application/json; charset=utf-8",
		    				success		: function(dataFromServer){
								if(dataFromServer.status=="Saved"){
								   alert("saved");
								}
								if(dataFromServer.status=="Not Saved"){
									alert("not saved");
								}
		        			   
		    				}
		   		 		});
				   return true;
			   }else{
				   return false;
			   }
		  }
		  
		  
		  
		  
		  
		  function validateForm(formID){
			   //validation rules
		        var validationRules 		= new Array();

		        validationRules[0] 			= "role|required|Please select a role";
		        validationRules[1] 			= "firstName|required|Please enter a first name";
		       
				validationRules[2] 			= "lastName|required|Please enter a last name"; 
		        validationRules[3] 			= "sex|required|Please select a sex";
		        
		        validationRules[4] 			= "dateOfBirth|required|Please enter a date of birth";
		        validationRules[5] 			= "countryOfOrigin|required|Please select a country of origin"; 
		        
		        validationRules[6] 			= "idNumber|required|Please enter an identification or passport number";
		        validationRules[7] 			= "address|required|Please enter an address";
		        
		        validationRules[8] 			= "suburb|required|Please enter a suburb";
		        validationRules[9] 			= "postalCode|required|Please enter a postal code";
		        
		        validationRules[10] 		= "city|required|Please enter a city";
		        validationRules[11] 		= "province|required|Please select a province"; 
		        
		        validationRules[12] 		= "mobileNumber|required|Please enter your mobile number";
		        validationRules[13] 		= "mobileNumber|numeric|Your mobile number needs to be numeric e.g. 0718238889";
		        
		        validationRules[14] 		= "mobileNumber|minlength|10|Your mobile number must be 10 digits long e.g. 0718238889";
		        validationRules[15]  		= "emailAddress|required|Please enter an email address";
		        validationRules[16]  		= "emailAddress|email|Please enter a valid email address";
		        
		        return yav.performCheck(formID,validationRules,'inline');
		  }
		  
		  
		  function getAge(dateOfBirth) 
		  {
		      var today 					= new Date();
		      var birthDate 				= new Date(dateOfBirth);
		      
		      var age 						= today.getFullYear() - birthDate.getFullYear();
		      var month 					= today.getMonth() - birthDate.getMonth();
		      if (month < 0 || (month === 0 && today.getDate() < birthDate.getDate())) 
		      {
		          age--;
		      }

		      return age;
		  }
		  </script>
	</jsp:body>
</template:base-page-layout>