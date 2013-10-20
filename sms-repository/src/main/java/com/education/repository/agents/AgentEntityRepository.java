package com.education.repository.agents;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.education.domain.agents.AgentEntityDomain;

public interface AgentEntityRepository extends JpaRepository<AgentEntityDomain,Long>,PagingAndSortingRepository<AgentEntityDomain, Long>{

	@Query("SELECT ead.attributeValue from AgentEntityDomain ed,AgentEntityAttributesDomain ead " +
			  "WHERE ed.userID=:id AND ed.id=ead.agentEntityID AND ead.attribute in ('First Name','Last Name')")
	public List<String> findUsersFullName(@Param ("id") Long id);
}
