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
		<script type="text/javascript" src="<c:url value="/dwr/interface/schoolService.js"/>"></script>
		
		<script type="text/javascript" src="<c:url value="/assets/js/yav.js"/>" ></script>
		<script type="text/javascript" src="<c:url value="/assets/js/yav-config.js"/>" ></script>
		<script type="text/javascript" src="<c:url value="/assets/js/bootstrap.js"/>" ></script>
	</jsp:attribute>
	<jsp:body>
		  <div class="span4"></div>
				<div class="span7">
				<h3>List of Schools</h3>
						<table class="table table-striped table-hover" >
							<tr>
								<td><label class="control-label" for="country"><Strong class="text-error span3">Country:</Strong></label>
							
									   <div class="controls" id="countryInput">
										   <!-- Dynamically populate countries -->
									   </div>
									<span class="innerError" id="errorsDiv_country" style="color:red;"></span>
								</td>
								<td id="provinceBlock" style="display:none"><label class="control-label" for="province"><Strong class="text-error span3">Province/Region :</Strong></label>
									<div class="controls" id="provinceInput">
										<!-- Dynamically populate provinces -->
									</div>
									<span class="innerError" id="errorsDiv_province" style="color:red;"></span>
								</td>
								<td id="cityBlock" style="display:none"><label class="control-label" for="city"><Strong class="text-error span3">City :</Strong></label>
								
									<div class="controls" id="cityInput">
										<!-- Dynamically populate cities -->
								    </div>
									<span class="innerError" id="errorsDiv_city" style="color:red;"></span>
								</td>
							</tr>
						</table>

						<table id="schoolTable" class="table table-striped table-hover" style="display:none">
						<thead>
						<th>No.</th><th>Name of School</th><th>Address</th><th>Action</th>
						</thead>
						<tbody id="schoolTableBody">
						
						</tbody>
					
						</table>
					
					<div id="loading" style="display:none;position:absolute;top:50%;left:40%"><img src="<c:url value="/assets/images/loading.gif"/>" /></div>
				</div>
		  <div class="span4"></div>
		  <script type="text/javascript">

		  //DatePicker
		  $(document).ready(function() {
				
				//Populate list of countries via DWR
				countryService.getAllCoutries({callback:function(dataFromServer){
						var  listOfCountries    			 =	"<select id='country' name='Country' >";
							 listOfCountries    			 += "<option value=''>Select a country</option>";
					$.each(dataFromServer, function (index,value){		
						     listOfCountries    			+= "<option value='"+value.countryName+"' code='"+value.countryCode+"'>"+value.countryName+"</option>";
					});
							 listOfCountries    			 +=	"</select>";
					$("#countryInput").append(listOfCountries);
				}});
		  });	
			

		  $("#country").live('change', function() {
			  	
			    
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
		    
		    $("#city").live("change", function() {
		    	if($(this).is('select')){

		    		var country										=	$("#country").val();
		    		var province									=	$("#province").val();
		    		var city										=	$("#city").val();
		    		
		    		
				   //Populate list of schools via DWR
					schoolService.retrieveSchoolsByLocation(country,province,city,{callback:function(dataFromServer){
						  var   listOfSchools						= "<tr>";								
						 $.each(dataFromServer, function (index,value){	
					     var url								    = "<c:url value='/teacher/register-teacher?schoolID="+value.id+"'/>"; 
						     listOfSchools						   += "<td>"+ ++index +"</td><td>"+value.nameOfSchool+"</td><td>"+value.address+"</td>";
						     listOfSchools						   += "<td><a href='"+url+"'><button class='btn btn-success'><Strong>Register Teachers</Strong></button></a></td>";			
						     index++;
						 });
						 	 listOfSchools						   += "</tr>";
						
						 $("#schoolTableBody").append(listOfSchools);
						 $("#schoolTable").show();
					}});//end DWR call
				}//end if statement
		    });
		    
		    

			  //Submit Form
			  function registerSchool(formID){
				 $(".error").text("");
				   if(validateForm(formID)){
					   var schoolName		= $("#schoolName").val();
					   
					   //AJAX post
					   var formData  		= JSON.stringify($("#"+formID).serializeArray());
					   console.log(formData);
							$.ajax ({
			    				url			: "/sms/restful/register-school?schoolName="+schoolName,
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
			  
			  
			  //Form Validation
			  function validateForm(formID){
				   //validation rules
			        var validationRules 		= new Array();

			        validationRules[0] 			= "country|required|Please select a country"; 
			        validationRules[1] 			= "city|required|Please enter a city";
			        validationRules[2] 			= "province|required|Please select a province"; 
			        validationRules[3] 			= "address|required|Please enter an address";
			        validationRules[4] 			= "suburb|required|Please enter a suburb";
			        validationRules[5] 			= "postalCode|required|Please enter a postal code";
			        validationRules[6] 			= "schoolName|required|Please enter the name of school";
			        
				return yav.performCheck(formID,validationRules,'inline');
			  }
			  
			  
			  //Ajax Loader
			  $( document ).ajaxStart(function() {
				  $( "#loading" ).show();
			   });
			  
			  $(document).ajaxComplete(function(){
				  $( "#loading" ).hide();
				}); 
			  
		  
		  </script>
	</jsp:body>
</template:base-page-layout>