package com.phollux.userdata.repositories;

import com.phollux.userdata.models.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserDataRepository extends MongoRepository<User,String> {
    Optional<User> findByEmail(String email);
}
