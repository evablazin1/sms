package com.education.repository.system.admin;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.education.domain.system.admin.SystemAdminEntityAttributesDomain;

public interface SystemAdminEntityAttributesRepository extends JpaRepository<SystemAdminEntityAttributesDomain,Long>,PagingAndSortingRepository<SystemAdminEntityAttributesDomain, Long> {

}
