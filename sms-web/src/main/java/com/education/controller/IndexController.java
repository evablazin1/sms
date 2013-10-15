package com.education.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {
	
	/**
	 * 
	 * @return
	 */
	@RequestMapping(value={"/","index"})
	public String index(){
		return "index/index"; 
	}

}
