package com.phollux.auth.controllers;

import com.phollux.auth.dto.AuthResponseDto;
import com.phollux.auth.dto.LoginDto;
import com.phollux.auth.dto.RegisterDto;
import com.phollux.auth.services.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthService authService;

    @Autowired
    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping(path = "register")
    public ResponseEntity<AuthResponseDto> register(@RequestBody RegisterDto registerDto) {
        return new ResponseEntity<>(authService.register(registerDto), HttpStatus.CREATED);
    }

    @PostMapping(path = "login")
    public ResponseEntity<AuthResponseDto> login(@RequestBody LoginDto loginDto) {
        return ResponseEntity.ok().body(authService.login(loginDto));
    }
    @GetMapping(path = "token")
    public ResponseEntity<String> generateToken(){
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("token",
                authService.generateToken());

        return ResponseEntity.ok().headers(responseHeaders).body("");
    }
}
