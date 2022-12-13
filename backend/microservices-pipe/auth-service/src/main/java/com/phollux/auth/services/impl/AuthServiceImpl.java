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

import java.util.Optional;

@Service
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;
    private final WebClient webClient;

    @Autowired
    public AuthServiceImpl(UserRepository userRepository, WebClient webClient) {
        this.userRepository = userRepository;
        this.webClient = webClient;
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

                String url = "http://localhost:8080/api/userdata/get?email=" + loginDto.getEmail().toString();

                UserDto userData = webClient.get().uri(url).retrieve().bodyToMono(UserDto.class).block();
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
    public AuthResponseDto register(RegisterDto registerDto) {

        UserEntity user = new UserEntity();
        user.setEmail(registerDto.getEmail());
        user.setPassword(registerDto.getPassword());
        user.setUsername(registerDto.getUsername());

        userRepository.save(user);

        AuthResponseDto authResponseDto = new AuthResponseDto();

        authResponseDto.setMessage("Registered");
        authResponseDto.setStatus(HttpStatus.CREATED.value());

        String url = "http://localhost:8080/api/userdata/save";

        UserDto userDto = new UserDto();

        userDto.setName(registerDto.getUsername());
        userDto.setEmail(registerDto.getEmail());

        UserDto userData = webClient.post().uri(url).bodyValue(userDto) .retrieve().bodyToMono(UserDto.class).block();
        
        authResponseDto.setUserDto(userData);

        return authResponseDto;
    }
}
