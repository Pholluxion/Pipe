package com.phollux.profile.exceptions;

public class ProfileNotFoundException extends  RuntimeException{
    public static final long serialVersionUID = 1;
    public ProfileNotFoundException(String message) {
        super(message);
    }
}
