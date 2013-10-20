package com.education.repository.users;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.education.domain.users.UserDomain;

public interface UserRepository extends JpaRepository<UserDomain,Long>,PagingAndSortingRepository<UserDomain, Long>{
	
	public UserDomain findByUsername(String username);
	
}
