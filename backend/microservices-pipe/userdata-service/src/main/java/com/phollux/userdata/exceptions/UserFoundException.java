package com.phollux.userdata.exceptions;

public class UserFoundException extends  RuntimeException{
    public static final long serialVersionUID = 1;
    public UserFoundException(String message) {
        super(message);
    }
}
