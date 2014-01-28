package com.education.service.student;


import java.util.List;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.education.domain.student.StudentDomain;
import com.education.repository.student.StudentRepository;


@Service
@RemoteProxy(name="studentService")
public class StudentService {
	
	@Autowired
	StudentRepository studentRepository;

	@RemoteMethod
	public List<StudentDomain> retrieveListOfStudents(Long schoolID,Long classID){
	
		List<StudentDomain> listOfStudents							= 	studentRepository.findBySchoolIDAndClassID(schoolID,classID);
		return listOfStudents;
	}
	
}
