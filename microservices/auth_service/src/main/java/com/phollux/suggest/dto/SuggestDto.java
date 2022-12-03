package com.phollux.suggest.dto;

import lombok.Data;

@Data
public class SuggestDto {
    private long id;
    private String nombre;
    private String correo;
    private String descripcion;
    private String foto;
}
