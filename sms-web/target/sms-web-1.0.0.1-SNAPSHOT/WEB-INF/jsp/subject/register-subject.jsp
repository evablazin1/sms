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
		<script type="text/javascript" src="<c:url value="/dwr/interface/teacherService.js"/>"></script>
		
		<script type="text/javascript" src="<c:url value="/assets/js/yav.js"/>" ></script>
		<script type="text/javascript" src="<c:url value="/assets/js/yav-config.js"/>" ></script>
		<script type="text/javascript" src="<c:url value="/assets/js/bootstrap.js"/>" ></script>
	</jsp:attribute>
	<jsp:body>
		  <div class="span4"></div>
				<div class="span7">
				<h3>Subject Registration</h3>
					<form class="form-horizontal" id="subjectRegistrationForm" >
						<table class="table table-striped table-hover" >
							<tr>
								<td><label class="control-label" for="subjectName"><Strong class="text-error span3">Subject Name :</Strong></label></td>
								<td>
									<div class="controls"><input type="text" id="subjectName" name="Subject Name" placeholder="Enter Subject Name"  /></div>
									<span class="innerError" id="errorsDiv_subjectName" style="color:red;"></span>
								</td>
	 						</tr>
	 						
	 						<tr>
							    <td><label class="control-label" for="subjectTeacher"><Strong class="text-error span3">Subject Teacher :</Strong></label></td>
								<td>
									<div class="controls">
										<select id="subjectTeacher" name="Subject Teacher">
										</select>
									</div>
								</td>
							</tr>
	 					</table>
						<input type="hidden" name="School ID" value="${schoolID}" />
						<input type="hidden" name="Class ID" value="${classID}" />
						<input type="hidden" name="Class Name" value="${className}" />
						<input type="hidden" id="subjectTeacherName" name="Subject Teacher Name" value="" />
						<div class="btn-group pull-left">
						    <input id="reset" type="reset" class="btn btn-success" />
						</div>
					</form>
					<div class="btn-group pull-right">
							<button id="register" class="btn btn-success" onClick="javascript:registerSubject('subjectRegistrationForm');" >
								<Strong> Register <i class="icon-hand-right icon-white"></i> </Strong>
							</button>
					</div>
					<div id="loading" style="display:none;position:absolute;top:50%;left:40%"><img src="<c:url value="/assets/images/loading.gif"/>" /></div>
				</div>
		  <div class="span4"></div>
		  <script type="text/javascript">

		  $(document).ready(function() {
				var schoolID								  = <c:out value="${schoolID}" />
				
				teacherService.retrieveListOfTeachers(schoolID,{callback:function(dataFromServer){
						var	 listOfTeachers    			      = "<option value=''>Select a Subject Teacher</option>";
					
					$.each(dataFromServer, function (index,value){		
						     listOfTeachers    			     += "<option value='"+value.id+"'>"+value.title+" "+value.firstName+" "+value.lastName+"</option>";
					});
					$("#subjectTeacher").append(listOfTeachers);
				
				}});
		  });	
			

	   
			  //Submit Form
			  function registerSubject(formID){ 
				 $(".error").text("");
				   if(validateForm(formID)){
					   
					   var subjectTeacherName		= $("#subjectTeacher").find(":selected").text();
					   $("#subjectTeacherName").val(subjectTeacherName);
					   
					   //AJAX post
					   var formData  		= JSON.stringify($("#"+formID).serializeArray());
					   console.log(formData);
							$.ajax ({
			    				url			: "/sms/restful/register-subject",
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
			        var validationRules 			= new Array();
						validationRules[0] 			= "subjectName|required|Please enter a subject name"; 
						validationRules[1] 			= "subjectTeacher|required|Please select a subject teacher";
			        
				return yav.performCheck(formID,validationRules,'inline');
			  }
			  
			  
		  
		  </script>
	</jsp:body>
</template:base-page-layout>