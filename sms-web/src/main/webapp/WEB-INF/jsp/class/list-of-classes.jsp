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
		<script type="text/javascript" src="<c:url value="/dwr/interface/teacherService.js"/>"></script>
	</jsp:attribute>
	<jsp:body>
		  <div class="span4"></div>
				<div class="span7">
				<h3>List of Teachers</h3>
						<table id="classTable" class="table table-striped table-hover" style="display:none;">
							<thead>
								<th>No.</th><th>Name of class</th><th>Class Teacher</th><th>Actions</th>
							</thead>
							<tbody id="classTableBody">
							</tbody>
						</table>
					 <div id="emptyDiv" style="display:none">There are no classes registered yet.Please register class(es) for this school below</div>
					<div id="loading" style="display:none;position:absolute;top:50%;left:40%"><img src="<c:url value="/assets/images/loading.gif"/>" /></div>
				<div class="btn-group pull-right">
						<a href="<c:url value='/class/register-class?schoolID=${schoolID}'/>">
							<button id="register" class="btn btn-success" >
								<Strong> Register Class<i class="icon-hand-right icon-white"></i> </Strong>
							</button>
						</a>
				</div>
				</div>
		  <div class="span4"></div>
		  <script type="text/javascript">

		  $(document).ready(function() {
			  var schoolID										= <c:out value="${schoolID}" />;
			  
			  classService.retrieveListOfClasses(schoolID,{callback:function(dataFromServer){
				 if (!$.isEmptyObject(dataFromServer)){
					 var classTeacher							= "";
					var listOfClasses              			    = "<tr>";
					  $.each(dataFromServer,function(index,value){
						  teacherService.getTeacher(value.id,{callback:function(dataFromServer){
						        classTeacher					= dataFromServer.title+" "+dataFromServer.firstName+" "+dataFromServer.lastName;
						  }});
						  listOfClasses    					   += "<td>"+ ++index +"</td><td>"+value.className+"</td><td>"+classTeacher+"</td>"; 	      
						  listOfClasses						   += "<td><a href=''><button class='btn btn-success'><Strong>Teacher</Strong></button></a></td>";   
					  });
					      listOfClasses              		   += "</tr>";
					  
					  $("#classTableBody").append(listOfClasses);
					  $("#classTable").show();
				  }else{
					  $("#emptyDiv").show();
				  }
			  }});
		  });	
		  </script>
	</jsp:body>
</template:base-page-layout>