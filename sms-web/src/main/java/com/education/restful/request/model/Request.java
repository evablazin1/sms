package com.education.restful.request.model;

public class Request {
	
	private String name;
	private String value;
	
	public Request(){

	}
	
	public String getName() {
		return name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public void setName(String name) {
		this.name = name;
	}

}
