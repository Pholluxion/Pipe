package com.pipe.pipechatprojet.control.modelo;

import lombok.*;
import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
//creacion de la clase mensajes
public class Mensaje {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    private String senderName;

    private String receiverName;

    private String mensaje;

    private String date;

    private Status status;

}
