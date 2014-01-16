package com.education.repository.users;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.education.domain.users.UserGroupDomain;

public interface UserGroupRepository  extends JpaRepository<UserGroupDomain,Long>,PagingAndSortingRepository<UserGroupDomain, Long> {
	
	@Query("select ugd.groupName from UserGroupDomain ugd where ugd.userID=:userID")
	public List<String> retrieveUserGroup(@Param("userID") Long userID);

}
