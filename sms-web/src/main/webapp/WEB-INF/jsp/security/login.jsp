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
		
		<script type="text/javascript" src="<c:url value="/assets/js/yav.js"/>" ></script>
		<script type="text/javascript" src="<c:url value="/assets/js/yav-config.js"/>" ></script>
		<script type="text/javascript" src="<c:url value="/assets/js/bootstrap.js"/>" ></script>
	</jsp:attribute>
	<jsp:body>
		  <div class="span2"></div>
				<div class="span7">
				<h3>Login</h3>
					<form:form class="form-horizontal" id="loginForm" commandName="loginModel" >
						<table class="table table-striped table-hover" >
							<tr>
							    <td><label class="control-label" for="profileNumber"><Strong class="text-error span3">Profile Number :</Strong></label></td>
								<td>
									<div class="controls">
									<form:input id="profileNumber" path="profileNumber" placeholder="Enter your profile number" /></div>
									<span class="innerError" id="errorsDiv_profileNumber" style="color:red;"></span>
								</td>
							</tr>
							<tr>
							    <td><label class="control-label" for="pinNumber"><Strong class="text-error span3">Pin Number :</Strong></label></td>
								<td>
									<div class="controls">
									<form:password id="pinNumber" path="pinNumber" placeholder="Enter your Pin Number" /></div>
									<span class="innerError" id="errorsDiv_pinNumber" style="color:red;"></span>
									<span style="color:red;">${loginModel.message}</span>
								</td>
							</tr>
						</table>
						<div class="btn-group pull-right">
							<button id="login" class="btn btn-success" /><Strong> Login <i class="icon-hand-right icon-white"></i> </Strong></button>
						</div>
					</form:form>
				</div>
		  <div class="span2"></div>
	</jsp:body>
</template:base-page-layout>