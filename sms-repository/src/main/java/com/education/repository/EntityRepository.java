package com.education.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.education.domain.EntityDomain;

public interface EntityRepository extends JpaRepository<EntityDomain,Long>,PagingAndSortingRepository<EntityDomain, Long> {

}
