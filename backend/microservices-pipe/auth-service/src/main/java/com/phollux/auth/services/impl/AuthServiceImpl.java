package com.phollux.auth.services.impl;

import com.phollux.auth.dto.AuthResponseDto;
import com.phollux.auth.dto.LoginDto;
import com.phollux.auth.dto.RegisterDto;
import com.phollux.auth.dto.UserDto;
import com.phollux.auth.exceptions.PasswordNotMatchException;
import com.phollux.auth.exceptions.UserNotFoundException;
import com.phollux.auth.models.UserEntity;
import com.phollux.auth.repositories.UserRepository;
import com.phollux.auth.services.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;


import java.util.*;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Optional;

@Service
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;
    private final WebClient.Builder webClientBuilder;

    @Autowired
    public AuthServiceImpl(UserRepository userRepository, WebClient.Builder webClientBuilder) {
        this.userRepository = userRepository;
        this.webClientBuilder = webClientBuilder;
    }


    @Override
    public AuthResponseDto login(LoginDto loginDto) {
        try {

            Optional<UserEntity> user = userRepository.findByEmail(loginDto.getEmail());

            if (user.isEmpty()) {
                throw new UserNotFoundException("User not found");
            } else if (loginDto.getPassword().equals(user.orElse(null).getPassword())) {
                AuthResponseDto authResponseDto = new AuthResponseDto();

                authResponseDto.setMessage("Bienvenido");
                authResponseDto.setStatus(HttpStatus.OK.value());

                String url = "http://userdata-service/api/userdata/get?email=" + loginDto.getEmail().toString();

                UserDto userData = webClientBuilder.build().get().uri(url).retrieve().bodyToMono(UserDto.class).block();
                authResponseDto.setUserDto(userData);



                return authResponseDto;
            } else {
                throw new PasswordNotMatchException("incorrect password or email");
            }

        } catch (Exception ex) {
            throw new UserNotFoundException("User not found EX");
        }


    }
    @Override
    public String generateToken() {

        String VIDEOSDK_API_KEY = "";
        String VIDEOSDK_SECRET_KEY = "";

        Map<String, Object> payload = new HashMap<>();

        payload.put("apikey", VIDEOSDK_API_KEY);
        payload.put("permissions", new String[]{"allow_join", "allow_mod"});

        return Jwts.builder().setClaims(payload)
                .setExpiration(new Date(System.currentTimeMillis() + 86400 * 1000))
                .signWith(SignatureAlgorithm.HS256, VIDEOSDK_SECRET_KEY.getBytes()).compact();
    }


    @Override
    public AuthResponseDto register(RegisterDto registerDto) {

        UserEntity user = new UserEntity();
        user.setEmail(registerDto.getEmail());
        user.setPassword(registerDto.getPassword());
        user.setUsername(registerDto.getUsername());

        userRepository.save(user);

        AuthResponseDto authResponseDto = new AuthResponseDto();

        authResponseDto.setMessage("Registered");
        authResponseDto.setStatus(HttpStatus.CREATED.value());

        String url = "http://userdata-service/api/userdata/save";

        UserDto userDto = new UserDto();

        userDto.setName(registerDto.getUsername());
        userDto.setEmail(registerDto.getEmail());

        UserDto userData = webClientBuilder.build().post().uri(url).bodyValue(userDto).retrieve().bodyToMono(UserDto.class).block();

        authResponseDto.setUserDto(userData);

        return authResponseDto;
    }
}
