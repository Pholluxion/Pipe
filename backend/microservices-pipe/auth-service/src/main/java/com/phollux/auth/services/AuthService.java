package com.phollux.auth.services;

import com.phollux.auth.dto.AuthResponseDto;
import com.phollux.auth.dto.LoginDto;
import com.phollux.auth.dto.RegisterDto;

public interface AuthService {

    public AuthResponseDto login(LoginDto loginDto);
    public AuthResponseDto register(RegisterDto loginDto);

}
