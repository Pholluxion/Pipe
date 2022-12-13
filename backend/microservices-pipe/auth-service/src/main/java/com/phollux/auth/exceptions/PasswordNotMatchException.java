package com.phollux.auth.exceptions;

public class PasswordNotMatchException extends  RuntimeException{
    public static final long serialVersionUID = 1;
    public PasswordNotMatchException(String message) {
        super(message);
    }
}
