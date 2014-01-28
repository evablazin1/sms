package com.education.service.classes;

import java.util.List;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.education.domain.classes.ClassSubjectDomain;
import com.education.repository.classes.ClassSubjectRepository;

@Service
@RemoteProxy(name="classSubjectService")
public class ClassSubjectService {
	
	@Autowired
	ClassSubjectRepository classSubjectRepository;
	
	/**
	 * 
	 * @param schoolID
	 * @param subjectID
	 * @return
	 */
	@RemoteMethod
	public List<ClassSubjectDomain> retrieveListOfClasses(Long schoolID,Long subjectID){
	
		List<ClassSubjectDomain> listOfClasses						= 	classSubjectRepository.findBySchoolIDAndSubjectID(schoolID,subjectID);
		return listOfClasses;
	}
		
	
	/**
	 * 
	 * @param schoolID
	 * @param classID
	 * @return
	 */
	@RemoteMethod
	public List<ClassSubjectDomain> retrieveListOfSubjects(Long schoolID,Long classID){
	
		List<ClassSubjectDomain> listOfClasses						= 	classSubjectRepository.findBySchoolIDAndClassID(schoolID,classID);
		return listOfClasses;
	}

}
