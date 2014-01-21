package com.education.service.teacher;

import java.util.List;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.education.domain.teacher.TeacherDomain;
import com.education.repository.teacher.TeacherRepository;

@Service
@RemoteProxy(name="teacherService")
public class TeacherService {
	
	
	@Autowired
	TeacherRepository teacherRepository;
	
	private static final Logger logger = LoggerFactory.getLogger(TeacherService.class);
	
	@RemoteMethod
	public List<TeacherDomain> retrieveListOfTeachers(Long schoolID){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to retrieve teachers for school with ID : "+ schoolID );
		
		List<TeacherDomain> listOfTeachers				=  teacherRepository.findBySchoolID(schoolID);
		return listOfTeachers;
	}
	
	@RemoteMethod
	public TeacherDomain getTeacher(Long schoolID){
		
		logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> about to retrieve teachers for school with ID : "+ schoolID );
		
		TeacherDomain teacherDomain						=  teacherRepository.findOne(schoolID);
		return teacherDomain;
	}
	
	

}
