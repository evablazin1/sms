<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="template" tagdir="/WEB-INF/tags" %>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp" %>
<template:base-page-layout>
	<jsp:body>
		<div class="row">
		  <div class="span2"></div>
				<div class="span7">
				<h5>Welcome ${AUTHENTICATED_USER_NAME}</h5>
				<h3>Landing Page</h3>
				</div>
		  <div class="span2"></div>
		 </div>
	</jsp:body>
</template:base-page-layout>