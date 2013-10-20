package com.education.repository.system.admin;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import com.education.domain.system.admin.SystemAdminEntityDomain;

public interface SystemAdminEntityRepository extends JpaRepository<SystemAdminEntityDomain,Long>,PagingAndSortingRepository<SystemAdminEntityDomain, Long> {

	@Query("SELECT ead.attributeValue from SystemAdminEntityDomain ed,SystemAdminEntityAttributesDomain ead " +
			  "WHERE ed.userID=:id AND ed.id=ead.adminEntityID AND ead.attribute in ('First Name','Last Name')")
	public List<String> findUsersFullName(@Param ("id") Long id);
}
