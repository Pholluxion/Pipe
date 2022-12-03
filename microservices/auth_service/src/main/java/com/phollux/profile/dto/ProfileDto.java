package com.phollux.profile.dto;

import lombok.Data;

@Data
public class ProfileDto {
    private long id;
    private String nombre;
    private String correo;
    private String descripcion;
    private String foto;
}
