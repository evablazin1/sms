package com.education.service.classes;

import java.util.List;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.education.domain.classes.ClassDomain;
import com.education.repository.classes.ClassRepository;

@Service
@RemoteProxy(name="classService")
public class ClassService {
	
	@Autowired
	ClassRepository classRepository;
	
	private static final Logger logger = LoggerFactory.getLogger(ClassService.class);
	
	@RemoteMethod
	public List<ClassDomain> retrieveListOfClasses(Long schoolID){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to retrieve classes for school with ID : "+ schoolID );
		
		List<ClassDomain> listOfClasses						= 	classRepository.findBySchoolID(schoolID);
		return listOfClasses;
	}
		

}
