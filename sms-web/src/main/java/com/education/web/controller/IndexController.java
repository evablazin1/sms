package com.education.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.education.repository.EntityRepository;

@Controller
public class IndexController {
	
	@Autowired
	EntityRepository entityRepository;
	
	private static final Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	
	/**
	 * 
	 * @return
	 */
	@RequestMapping(value={"/","index"})
	public String index(){
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> index controller");
		return "index/index"; 
	}

}
