package com.phollux.suggest.repositories;

import com.phollux.suggest.models.SuggestEntity;
import org.springframework.data.jpa.repository.JpaRepository;
 

public interface SuggestRepository extends JpaRepository<SuggestEntity,Integer> {
    SuggestEntity findById(long id);
}
