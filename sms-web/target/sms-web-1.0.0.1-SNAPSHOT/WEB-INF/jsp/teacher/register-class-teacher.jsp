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
		<script type="text/javascript" src="<c:url value="/dwr/interface/classService.js"/>"></script>
		
		<script type="text/javascript" src="<c:url value="/assets/js/yav.js"/>" ></script>
		<script type="text/javascript" src="<c:url value="/assets/js/yav-config.js"/>" ></script>
		<script type="text/javascript" src="<c:url value="/assets/js/bootstrap.js"/>" ></script>
	</jsp:attribute>
	<jsp:body>
		  <div class="span4"></div>
				<div class="span7">
				<h3>Register a class teacher</h3>
					<form class="form-horizontal" id="classTeacherRegistrationForm" >
						<table class="table table-striped table-hover" >
							<tr>
								<td><label class="control-label" for="class"><Strong class="text-error span3">Class:</Strong></label></td>
									<td>
									   <div class="controls">
									      <select id="classID" name="Class ID">
									      <option value="">Select a class</option>
									      <!-- Dynamically populate classes -->
									      
									      </select>
									   </div>
									<span class="innerError" id="errorsDiv_classID" style="color:red;"></span>
								</td>
							</tr>
						</table>
	 					
						<input type="hidden" name="School ID" value="${schoolID}" />
						<input type="hidden" name="Class Teacher ID" value="${teacherID}" />
						<input type="hidden" name="Class Teacher Name" value="${classTeacherName}" />
						<input type="hidden" id="className" name="Class Name" />
						
						<div class="btn-group pull-left">
						    <input id="reset" type="reset" class="btn btn-success" />
						</div>
					</form>
					<div id="emptyDiv" style="display:none">There are no classes registered for this school yet.Please register a class below</div>
					<div class="btn-group pull-right">
							<button id="register" class="btn btn-success" onClick="javascript:registerClassTeacher('classTeacherRegistrationForm');" >
								<Strong> Register <i class="icon-hand-right icon-white"></i> </Strong>
							</button>
							<a href="<c:url value='/classs/register-class?schoolID=${schoolID}' />" id="registerClass" style="display:none">
								<button class="btn btn-success">
									<Strong> Register Class<i class="icon-hand-right icon-white"></i> </Strong>
								</button>
							</a>
					</div>
					<div id="loading" style="display:none;position:absolute;top:50%;left:40%"><img src="<c:url value="/assets/images/loading.gif"/>" /></div>
				</div>
		  <div class="span4"></div>
		  <script type="text/javascript">	
		  
		  var schoolID											= <c:out value="${schoolID}" />; 
		  var teacherID											= <c:out value="${teacherID}" />; 
		  
		  $(document).ready(function() {
			  classService.retrieveListOfClasses(schoolID,{callback:function(dataFromServer){
				  
				  if (!$.isEmptyObject(dataFromServer)){
					var listOfClasses              			    = "";
					  $.each(dataFromServer,function(index,value){
					   	  listOfClasses    					   += "<option value='"+value.id+"'>"+value.className+"</option>"; 	   
					  });
					  $("#classID").append(listOfClasses);
				   }else{
					   $("#emptyDiv,#registerClass").show();
					   $("#classTeacherRegistrationForm,#register").hide();
				   }
			  }});
		  });
		  
		  
		  //Submit Form
			  function registerClassTeacher(formID){
				  
				 $(".error").text("");
				   if(validateForm(formID)){
					   var className							= $("#classID").find(":selected").text();
					   $("#className").val(className);
					   
					   
					   //AJAX post
					   var formData  							= JSON.stringify($("#"+formID).serializeArray());
					   console.log(formData);
							$.ajax ({
			    				url			: "/sms/restful/register-class-teacher",
			    				type		: "POST",
			    				data		: formData,
			    				dataType	: "json",
			   		 			contentType	: "application/json; charset=utf-8",
			    				success		: function(dataFromServer){
									if(dataFromServer.status=="Saved"){
										window.location = "<c:url value='/teacher/list-of-classes?schoolID="+schoolID+"&teacherID="+teacherID+"' />";
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
						validationRules[0] 			= "classID|required|Please select a class"; 
			        
				return yav.performCheck(formID,validationRules,'inline');
			  }
			  
			  
		  
		  </script>
	</jsp:body>
</template:base-page-layout>