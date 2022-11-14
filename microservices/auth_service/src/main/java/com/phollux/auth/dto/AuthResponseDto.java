package com.phollux.auth.dto;

import lombok.Data;

@Data
public class AuthResponseDto {
    private String accessToken ;
    private String tokenType = "Beaner";

    public AuthResponseDto(String accessToken) {
        this.accessToken = accessToken;
    }
}
