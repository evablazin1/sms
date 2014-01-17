package com.education.repository.system.admin;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.education.domain.system.admin.SystemAdminDomain;

public interface SystemAdminRepository extends JpaRepository<SystemAdminDomain,Long>,PagingAndSortingRepository<SystemAdminDomain, Long> {

}
