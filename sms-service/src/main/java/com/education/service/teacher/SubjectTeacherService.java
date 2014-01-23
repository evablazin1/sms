package com.education.service.teacher;

import java.util.List;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.education.domain.teacher.SubjectTeacherDomain;
import com.education.repository.teacher.SubjectTeacherRepository;

@Service
@RemoteProxy(name="subjectTeacherService")
public class SubjectTeacherService {
	
	
	@Autowired
	SubjectTeacherRepository subjectTeacherRepository;

	@RemoteMethod
	public List<SubjectTeacherDomain> retrieveListOfSubjects(Long schoolID,Long teacherID){

		List<SubjectTeacherDomain> listOfSubjects				=  subjectTeacherRepository.findBySchoolIDAndTeacherID(schoolID,teacherID);
		return listOfSubjects;
	}
}
