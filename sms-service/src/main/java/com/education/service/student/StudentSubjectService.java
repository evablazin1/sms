package com.education.service.student;


import java.util.List;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.education.domain.student.StudentSubjectDomain;
import com.education.repository.student.StudentSubjectRepository;


@Service
@RemoteProxy(name="studentSubjectService")
public class StudentSubjectService {
	
	@Autowired
	StudentSubjectRepository studentSubjectRepository;

	@RemoteMethod
	public List<StudentSubjectDomain> retrieveListOfSubjects(Long schoolID,Long classID,Long studentID){
	
		List<StudentSubjectDomain> listOfSubjects							= 	studentSubjectRepository.findBySchoolIDAndClassIDAndStudentID(schoolID,classID,studentID);
		return listOfSubjects;
	}
	
	
	@RemoteMethod
	public List<StudentSubjectDomain> retrieveListOfStudents(Long schoolID,Long classID,Long subjectID){
	
		List<StudentSubjectDomain> listOfStudents							= 	studentSubjectRepository.findBySchoolIDAndClassIDAndSubjectID(schoolID,classID,subjectID);
		return listOfStudents;
	}
	
}
