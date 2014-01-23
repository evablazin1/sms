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
								<th>No.</th><th>Name of School</th><th>Address</th><th>Actions</th>
							</thead>
							<tbody id="schoolTableBody">
							<!-- Dynamically populate List of schools -->
							</tbody>
						</table>
						<div id="emptyDiv" style="display:none">There are no schools registered yet.Please register a school below</div>
						<hr>
						<div id="loading" style="display:none;position:absolute;top:50%;left:40%"><img src="<c:url value="/assets/images/loading.gif"/>" /></div>
						<div class="btn-group pull-right">
							<a href="<c:url value='/school/register-school'/>">
								<button id="register" class="btn btn-success" >
									<Strong> Register School <i class="icon-hand-right icon-white"></i> </Strong>
								</button>
							</a>
						</div>
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
		    		$("#schoolTableBody").empty();
		    		
		    			var country											=	$("#country").val();
		    			var province										=	$("#province").val();
		    			var city											=	$("#city").val();
		    		
		    		
				   //Populate list of schools via DWR
					schoolService.retrieveSchoolsByLocation(country,province,city,{callback:function(dataFromServer){
					  if (!$.isEmptyObject(dataFromServer)){	
						 	 var   listOfSchools							= "";
						 $.each(dataFromServer, function (index,value){	
						     var   teacherUrl						        =  "<c:url value='/teacher/list-of-teachers?schoolID="+value.id+"'/>"; 
						     var   classUrl						        	=  "<c:url value='/class/list-of-classes?schoolID="+value.id+"'/>"; 
						     var   subjectUrl						        =  "<c:url value='/subject/list-of-subjects?schoolID="+value.id+"'/>";
						     
						     	   listOfSchools							+=  "<tr>";
							       listOfSchools						   	+= "<td>"+ ++index +"</td><td>"+value.nameOfSchool+"</td><td>"+value.address+"</td>";
							       listOfSchools						   	+= "<td><a href='"+teacherUrl+"'><button class='btn btn-success'><Strong>Teachers</Strong></button></a>";		
							       listOfSchools						   	+= "<a href='"+classUrl+"'><button class='btn btn-success'><Strong>Classes</Strong></button></a>";
							       listOfSchools						   	+= "<a href='"+subjectUrl+"'><button class='btn btn-success'><Strong>Subjects</Strong></button></a></td>";
							       listOfSchools						   	+= "</tr>";
						 });
						 
						 $("#schoolTableBody").append(listOfSchools);
						 $("#schoolTable").show();
						 $("#emptyDiv").hide();
					  }else{
						  $("#schoolTable").hide();
						  $("#emptyDiv").show();
					  }
					}});//end DWR call
				}//end if statement
		    });
		    			    			  
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