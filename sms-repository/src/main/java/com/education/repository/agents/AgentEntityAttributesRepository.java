package com.education.repository.agents;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.education.domain.agents.AgentEntityAttributesDomain;

public interface AgentEntityAttributesRepository extends JpaRepository<AgentEntityAttributesDomain,Long>,PagingAndSortingRepository<AgentEntityAttributesDomain, Long>{

}
