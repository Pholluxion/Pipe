package com.phollux.suggest.exceptions;

import lombok.Data;

import java.util.Date;

@Data
public class ErrorObject {
    private int statusCode;
    private String statusMessage;
    private Date date;
}
