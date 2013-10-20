package com.education.web.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class SecurityInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(SecurityInterceptor.class);
	
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}
	
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
			
			super.postHandle(request, response, handler, modelAndView);
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		
		HttpSession session 									= request.getSession();
		String requestURL   									= request.getRequestURL().toString();
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Security Check: Request -> " + requestURL + " Request Path -> " + request.getContextPath() + " Request Content Type -> " + request.getContentType() );
		
		if(StringUtils.containsIgnoreCase(requestURL, "assets")|| StringUtils.containsIgnoreCase(requestURL, "login" ) || StringUtils.containsIgnoreCase(requestURL, "logout" ))
			return true;
		
		//check if we have a logged in user
		if(!SecurityHelper.isAuthenticated(session)){
			logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> No user has been authorised yet, redirecting to authorization");
			response.sendRedirect( request.getContextPath().concat("/login") );
			return false;
		}else{
			logger.debug(">>>>>>>>>>>>>>>>>>>>> There is an authorised user, continue with request");
			return super.preHandle(request, response, handler);
		}
	}

}
