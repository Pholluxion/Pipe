package com.phollux.suggest.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Table(name = "suggest")
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class SuggestEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String nombre;
    private String correo;
    private String descripcion; 
}
