package com.phollux.profile.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Table(name = "profile")
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class ProfileEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String nombre;
    private String correo;
    private String descripcion;
    private String foto;
}
