<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="template" tagdir="/WEB-INF/tags" %>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp" %>
<template:base-page-layout>
	<jsp:body>
		  <div class="span2"></div>
				<div class="span7">
				<h3>Login</h3>
					<form:form class="form-horizontal" id="loginForm" commandName="loginModel" >
						<table class="table table-striped table-hover" >
							<tr>
							    <td><label class="control-label" for="username"><Strong class="text-error span3">Username :</Strong></label></td>
								<td>
									<div class="controls">
									<form:input id="username" path="username" placeholder="Enter your username" /></div>
									<span class="innerError" id="errorsDiv_username" style="color:red;"></span>
								</td>
							</tr>
							<tr>
							    <td><label class="control-label" for="password"><Strong class="text-error span3">Password :</Strong></label></td>
								<td>
									<div class="controls">
									<form:password id="password" path="password" placeholder="Enter your password" /></div>
									<span class="innerError" id="errorsDiv_password" style="color:red;"></span>
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