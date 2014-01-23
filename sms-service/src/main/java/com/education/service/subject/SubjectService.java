package com.education.service.subject;


import java.util.List;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.education.domain.subject.SubjectDomain;
import com.education.repository.subject.SubjectRepository;


@Service
@RemoteProxy(name="subjectService")
public class SubjectService {
	
	@Autowired
	SubjectRepository subjectRepository;

	@RemoteMethod
	public List<SubjectDomain> retrieveListOfSubjects(Long schoolID){
	
		List<SubjectDomain> listOfSubjects							= 	subjectRepository.findBySchoolID(schoolID);
		return listOfSubjects;
	}
	
}
