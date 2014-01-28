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
		<script type="text/javascript" src="<c:url value="/dwr/interface/classSubjectService.js"/>"></script>
	</jsp:attribute>
	<jsp:body>
		  <div class="span4"></div>
				<div class="span7">
				<h3>List of classes</h3>
						<table id="classTable" class="table table-striped table-hover" style="display:none;">
							<thead>
								<th>No.</th><th>Name of class</th><th>Actions</th>
							</thead>
							<tbody id="classTableBody">
							</tbody>
						</table>
					 <div id="emptyDiv" style="display:none">There are no classes registered to offer this subject yet.Please register a class for this subject below</div>
					<div id="loading" style="display:none;position:absolute;top:50%;left:40%"><img src="<c:url value="/assets/images/loading.gif"/>" /></div>
				    <div class="btn-group pull-right" id="buttonDiv" style="display:none;">
						<a href="<c:url value='/class/list-of-classes?schoolID=${schoolID}'/>">
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
			  var subjectID										= <c:out value="${subjectID}" />;
			  
			  classSubjectService.retrieveListOfClasses(schoolID,subjectID,{callback:function(dataFromServer){
				 if (!$.isEmptyObject(dataFromServer)){
					var listOfClasses              			    = "";
					  $.each(dataFromServer,function(index,value){
					  var studentUrl						    = "<c:url value='/subject/student-subject?schoolID="+schoolID+"&classID="+value.classID+"&subjectID="+subjectID+"'/>";
					  
					      listOfClasses              		   += "<tr>";
					   	  listOfClasses    					   += "<td>"+ ++index +"</td><td>"+value.className+"</td>"; 
						  listOfClasses						   += "<td><a href='"+studentUrl+"'><button class='btn btn-success'><Strong>Students</Strong></button></a></td>"; 
						  listOfClasses              		   += "</tr>";
					  });
					      
					  
					  $("#classTableBody").append(listOfClasses);
					  $("#classTable").show();
				  }else{
					  $("#emptyDiv,#buttonDiv").show();
				  }
			  }});
		  });	
		  </script>
	</jsp:body>
</template:base-page-layout>