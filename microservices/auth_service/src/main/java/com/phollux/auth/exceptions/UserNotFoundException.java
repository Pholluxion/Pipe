package com.phollux.auth.exceptions;

public class UserNotFoundException extends  RuntimeException{
    public static final long serialVersionUID = 1;
    public UserNotFoundException(String message) {
        super(message);
    }
}
