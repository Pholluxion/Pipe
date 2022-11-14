package com.pipe.pipechatprojet.control.modelo;

import lombok.*;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name ="mensajes")
public class Mensaje {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name = "emisor")
    private String senderName;

    @Column(name = "receptor")
    private String receiverName;

    @Column(name = "mensaje")
    private String mensaje;

    @Column(name = "fecha")
    private String date;

    @Column(name = "status")
    private Status status;

}
