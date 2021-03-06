package com.education.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.education.domain.EntityAttributesDomain;

public interface EntityAttributesRepository extends JpaRepository<EntityAttributesDomain,Long>,PagingAndSortingRepository<EntityAttributesDomain, Long> {

}
