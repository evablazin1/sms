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
					<form class="form-horizontal" id="adminRegistrationForm" >
						<table class="table table-striped table-hover" >
							<tr>
							    <td><label class="control-label" for="role"><Strong class="text-error span3">Group :</Strong></label></td>
								<td>
									<div class="controls">
										<select id="groupName" name="Group Name">
											<option value="">Select Group</option>
											<c:forEach items="${groups}" var="group" >
											  <option value="${group}">${group}</option>
											</c:forEach>
										</select>
									</div>
									<span class="innerError" id="errorsDiv_groupName" style="color:red;"></span>
								</td>
							</tr>
							
							<tr>
							    <td><label class="control-label" for="title"><Strong class="text-error span3">Title :</Strong></label></td>
								<td>
									<div class="controls">
										<select id="title" name="Title">
											<option value="">Select Title</option>
											<c:forEach items="${titles}" var="title" >
											  <option value="${title}">${title}</option>
											</c:forEach>
										</select>
									</div>
									<span class="innerError" id="errorsDiv_title" style="color:red;"></span>
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
		    				
		    				<tr>
							    <td><label class="control-label" for="idNumber"><Strong class="text-error span3">Passport/ID Nmuber :</Strong></label></td>
								<td>
									<div class="controls"><input type="text" id="idNumber" name="Passport/ID Number" placeholder="Enter your identification number" /></div>
									<span class="innerError" id="errorsDiv_idNumber" style="color:red;"></span>
								</td>
							</tr>
		    				
							<tr>
								<td><label class="control-label" for="countryOfOrigin"><Strong class="text-error span3">Country of Origin :</Strong></label></td>
									<td>
									   <div class="controls" >
										 <select id="countryOfOrigin" name="Country of Origin" >
											 <!-- Dynamically populate countries -->
										 </select>
									   </div>
									<span class="innerError" id="errorsDiv_countryOfOrigin" style="color:red;"></span>
								</td>
							</tr>
							

							<tr>
								<td><label class="control-label"><h4>Contact Information</h4></label></td><td></td>
							</tr>
					
					
							<tr>
								<td><label class="control-label" for="countryOfResidence"><Strong class="text-error span3">Country of Residence :</Strong></label></td>
									<td>
									   <div class="controls">
									     <select id="countryOfResidence" name="Country of Residence" >
											 <!-- Dynamically populate countries -->
										 </select>
									   </div>
									<span class="innerError" id="errorsDiv_countryOfResidence" style="color:red;"></span>
								</td>
							</tr>
							
							<tr id="provinceBlock" style="display:none">
								<td><label class="control-label" for="province"><Strong class="text-error span3">Province/Region :</Strong></label></td>
								<td>
									<div class="controls" id="provinceInput">
										<!-- Dynamically populate provinces -->
									</div>
									<span class="innerError" id="errorsDiv_province" style="color:red;"></span>
								</td>
							</tr>
							
							<tr id="cityBlock" style="display:none">
								<td><label class="control-label" for="city"><Strong class="text-error span3">City :</Strong></label></td>
								<td>
									<div class="controls" id="cityInput">
										<!-- Dynamically populate cities -->
								    </div>
									<span class="innerError" id="errorsDiv_city" style="color:red;"></span>
								</td>
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
					
						</table>
						<div class="btn-group pull-left">
						    <input id="reset" type="reset" class="btn btn-success" />
						</div>
					</form>
					<div class="btn-group pull-right">
							<button id="register" class="btn btn-success" onClick="javascript:registerAdmin('adminRegistrationForm');" >
								<Strong> Register <i class="icon-hand-right icon-white"></i> </Strong>
							</button>
					</div>
					<div id="loading" style="display:none;position:absolute;top:50%;left:40%"><img src="<c:url value="/assets/images/loading.gif"/>" /></div>
				</div>
		  <div class="span4"></div>
		  <script type="text/javascript">

		  $(document).ready(function() {
				$("#dateOfBirth").datepicker({dateFormat: "mm/dd/yy",changeMonth: true,changeYear: true}); 
				
				//Populate list of countries via DWR
				countryService.getAllCoutries({callback:function(dataFromServer){
						var  listOfCountries    			 = "<option value=''>Select a country</option>";
					$.each(dataFromServer, function (index,value){		
						     listOfCountries    			+= "<option value='"+value.countryName+"' code='"+value.countryCode+"'>"+value.countryName+"</option>";
					});
					$("#countryOfOrigin,#countryOfResidence").append(listOfCountries);
				}});
			});
		  
		  
		  $("#countryOfResidence").live('change', function() {
			  	
			    
			  	var countryCode							 =	$(this).find(":selected").attr('code');
			    var province;
			    var city;
			    $("#provinceInput,#cityInput").empty();
				
			    //Populate list of provinces via DWR
				provinceService.getProvincesByCountryCode(countryCode,{callback:function(dataFromServer){
					
					  if (!$.isEmptyObject(dataFromServer)){
						  		$("#cityBlock").hide();
						  	    
						  		province					 = "<select id='province' name='Province' >";
						        province    	   			+= "<option value=''>Select a province</option>";
					     
						    $.each(dataFromServer, function (index,value){		
						    	province    	   		    += "<option value='"+value.provinceName+"' code='"+value.provinceCode+"'>"+value.provinceName+"</option>";
							});
						        province					+= "</select>";
					  }else{
						        province				     = "<input type='text' id='province' name='Province' placeholder='Enter a Province/Region' />";
						        city	     			     = "<input type='text' id='city' name='City' placeholder='Enter a City' />";
						    
						        $("#cityInput").append(city);
						        $("#cityBlock").show();
						        
						   }		
					  $("#provinceInput").append(province);
					  $("#provinceBlock").show();
				}});
			});
		  
		  
		    $("#province").live("change", function() {
		    	if($(this).is('select')){
		    		var provinceCode							 =	$(this).find(":selected").attr('code');
		    	    var city;
		    	    
		    	    $("#cityInput").empty();
				   
					//Populate list of cities via DWR
					cityService.getCitiesByProvinceCode(provinceCode,{callback:function(dataFromServer){
						        city					 = "<select id='city' name='City' >";
						        city    	   			+= "<option value=''>Select a city</option>";
						        
						  $.each(dataFromServer, function (index,value){		
						    	city    	   		    += "<option value='"+value.cityName+"'>"+value.cityName+"</option>";
							});
						        city					+= "</select>";
						        
						  $("#cityInput").append(city);
						  $("#cityBlock").show();
				    }});//end DWR call
			    }//end if statement
		    });
		  
		  $( document ).ajaxStart(function() {
			  $( "#loading" ).show();
		   });
		  
		  $(document).ajaxComplete(function(){
			  $( "#loading" ).hide();
			}); 
		  
		  
		  
		  function registerAdmin(formID){
			 $(".error").text("");
			   if(validateForm(formID)){
				   
				   //populate age field from date of birth
				   var age				=	getAge($("#dateOfBirth").val());
				   $("#age").val(age);
				   
				   //AJAX post
				   var formData  		= JSON.stringify($("#"+formID).serializeArray());
				   console.log(formData);
						$.ajax ({
		    				url			: "/sms/restful/register-system-admin",
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

		        validationRules[0] 			= "groupName|required|Please select a Group";
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
		        validationRules[17] 		= "countryOfResidence|required|Please select your country of residence";
		        validationRules[18] 		= "title|required|Please select a title";
		        
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