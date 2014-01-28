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
		<script type="text/javascript" src="<c:url value="/dwr/interface/studentSubjectService.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/dwr/interface/classSubjectService.js"/>"></script>
	     
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
								<td><label class="control-label" for="subjects"><Strong class="text-error span3">Subjects Offered :</Strong></label></td>
									<td>
									   <div class="controls" id="subjectInput">
										 	<!-- Dynamically populate subjects -->
									   </div>
									<span class="innerError" id="errorsDiv_subjects" style="color:red;"></span>
								</td>
							</tr>
	 					</table>
						<input type="hidden" name="School ID" value="${schoolID}" />
						<input type="hidden" name="Class ID" value="${classID}" />
						<input type="hidden" name="Student ID" value="${studentID}" />
						<input type="hidden" name="Class Name" value="${className}" />
						<input type="hidden" name="Student Name" value="${studentName}" />
						
						<div class="btn-group pull-left" id="resetButton">
						    <input id="reset" type="reset" class="btn btn-success" />
						</div>
					</form>
					<div id="emptyDiv" style="display:none">There are no new subjects to be registered for this student.</div>
					
					<div class="btn-group pull-right" >
							<button id="registerButton" class="btn btn-success" onClick="javascript:registerSubject('subjectRegistrationForm');" >
								<Strong> Register <i class="icon-hand-right icon-white"></i> </Strong>
							</button>
							<a href="<c:url value='/student/list-of-subjects?schoolID=${schoolID}&classID=${classID}&studentID=${studentID}' />" id="backButton" style="display:none;">
								<button class="btn btn-success"  >
									<Strong> Back <i class="icon-hand-right icon-white"></i> </Strong>
								</button>
							</a>
					</div>

					<div id="loading" style="display:none;position:absolute;top:50%;left:40%"><img src="<c:url value="/assets/images/loading.gif"/>" /></div>
				</div>
		  <div class="span4"></div>
		  <script type="text/javascript">
		  	  var schoolID												= <c:out value="${schoolID}" />; 
		  	  var classID												= <c:out value="${classID}" />; 
		  	  var studentID												= <c:out value="${studentID}" />; 
		  	  
			  $(document).ready(function(){
				  
				  var subjectsOffered									= new Array();
				  
				  //Retrieve subjects already registered for this student
				  studentSubjectService.retrieveListOfSubjects(schoolID,classID,studentID,{callback:function(dataFromServer){
					  if (!$.isEmptyObject(dataFromServer)){
						  $.each(dataFromServer,function(index,value){
							  subjectsOffered.push(value.subjectID);
						  });
					  }
				  }});
				  
				  
				  classSubjectService.retrieveListOfSubjects(schoolID,classID,{callback:function(dataFromServer){
					  		var subjectsExist								= false;
							var listOfSubjects              			    = "<select id='subjects' name='Subjects' multiple='multiple' size='4' >";
								$.each(dataFromServer,function(index,value){
								  //check if subject has already been registered for this student.
								  if($.inArray(value.subjectID,subjectsOffered) == -1){
									  listOfSubjects              			+= "<option value='"+value.subjectID+"'>"+value.subjectName+"</option>";  
									  subjectsExist							= true;
								  }
							         
							   });
								listOfSubjects              			    += "</select>";
							
								//If there are no new subjects to be registered
								if(subjectsExist){
									  $("#subjectInput").append(listOfSubjects);
								  }else{
									  $("#emptyDiv,#backButton").show();
									  $("#subjectRegistrationForm,#registerButton").hide();
									  
								  }
							  
				 }});
			   });
		  	  
		  	  
			  //Submit Form
			  function registerSubject(formID){ 
				 $(".error").text("");
				   if(validateForm(formID)){
					   
					   //AJAX post
					   var formData  		= JSON.stringify($("#"+formID).serializeArray());
					   console.log(formData);
							$.ajax ({
			    				url			: "/sms/restful/register-student-subject",
			    				type		: "POST",
			    				data		: formData,
			    				dataType	: "json",
			   		 			contentType	: "application/json; charset=utf-8",
			    				success		: function(dataFromServer){
									if(dataFromServer.status=="Saved"){
										window.location = "<c:url value='/student/list-of-subjects?schoolID="+schoolID+"&classID="+classID+"&studentID="+studentID+"' />";
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
						validationRules[0] 			= "subjects|required|Please enter a subject name"; 
			        
				return yav.performCheck(formID,validationRules,'inline');
			  }
			  
			  
		  
		  </script>
	</jsp:body>
</template:base-page-layout>