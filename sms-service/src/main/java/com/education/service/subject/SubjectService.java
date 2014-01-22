package com.education.service.subject;

import java.util.List;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.education.domain.subject.SubjectDomain;
import com.education.repository.subject.SubjectRepository;

@Service
@RemoteProxy(name="subjectService")
public class SubjectService {
	
	@Autowired
	SubjectRepository subjectRepository;
	
	private static final Logger logger 								= LoggerFactory.getLogger(SubjectService.class);
	
	@RemoteMethod
	public List<SubjectDomain> retrieveListOfSubjects(Long schoolID,Long classID){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to retrieve list of subjects");
		List<SubjectDomain> listOfSubjects							=	subjectRepository.findBySchoolIDAndClassID(schoolID, classID);
		
		return listOfSubjects;
	}
}
