package com.education.repository.admin;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.education.domain.admin.AdminDomain;

public interface AdminRepository extends JpaRepository<AdminDomain,Long>,PagingAndSortingRepository<AdminDomain, Long> {

}
