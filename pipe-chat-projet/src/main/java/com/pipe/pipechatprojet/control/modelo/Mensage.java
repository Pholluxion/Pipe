package com.pipe.pipechatprojet.control.modelo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString

public class Mensage {
    private String senderName;
    private String receiverName;
    private String mensage;
    private String date;
    private Status status;

}
