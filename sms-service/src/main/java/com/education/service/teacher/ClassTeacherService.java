package com.education.service.teacher;

import java.util.List;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.education.domain.teacher.ClassTeacherDomain;
import com.education.repository.teacher.ClassTeacherRepository;

@Service
@RemoteProxy(name="classTeacherService")
public class ClassTeacherService {
	
	
	@Autowired
	ClassTeacherRepository classTeacherRepository;
	
	@RemoteMethod
	public List<ClassTeacherDomain> retrieveListOfClasses(Long schoolID,Long teacherID){
		
		List<ClassTeacherDomain> listOfTeachers				=  classTeacherRepository.findBySchoolIDAndTeacherID(schoolID,teacherID);
		return listOfTeachers;
	}
}
