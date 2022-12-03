package com.phollux.profile.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import java.util.Date;

@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(ProfileNotFoundException.class)
    public ResponseEntity<ErrorObject> userNotFound(ProfileNotFoundException ex, WebRequest request){
        ErrorObject errorObject = new ErrorObject();
        errorObject.setStatusCode(HttpStatus.NOT_FOUND.value());
        errorObject.setStatusMessage(ex.getMessage());
        errorObject.setDate(new Date());
        return new ResponseEntity<ErrorObject>(errorObject,HttpStatus.NOT_FOUND);
    }
}
