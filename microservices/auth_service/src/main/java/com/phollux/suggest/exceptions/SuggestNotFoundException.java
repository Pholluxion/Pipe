package com.phollux.suggest.exceptions;

public class SuggestNotFoundException extends  RuntimeException{
    public static final long serialVersionUID = 1;
    public SuggestNotFoundException(String message) {
        super(message);
    }
}
