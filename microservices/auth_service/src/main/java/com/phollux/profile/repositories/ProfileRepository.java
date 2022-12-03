package com.phollux.profile.repositories;

import com.phollux.profile.models.ProfileEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ProfileRepository extends JpaRepository<ProfileEntity,Integer> {
    Optional<ProfileEntity> findByEmail(String email);
    boolean existsByEmail(String email);
    ProfileEntity findById(long id);
    
}
