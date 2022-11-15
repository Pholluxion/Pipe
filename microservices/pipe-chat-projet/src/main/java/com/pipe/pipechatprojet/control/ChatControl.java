package com.pipe.pipechatprojet.control;


import com.pipe.pipechatprojet.control.modelo.Mensaje;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Controller
public class ChatControl {
    
    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;
    
    @MessageMapping("/mensaje")// /app/mensaje
    @SendTo("/chat/public")
    public Mensaje receivePublicMensaje(@Payload Mensaje mensaje){
        return mensaje;
    }
    
    @MessageMapping("/private-mensage")
    private Mensaje receivePrivateMensaje(@Payload Mensaje mensaje){
        simpMessagingTemplate.convertAndSendToUser(mensaje.getReceiverName(),"/private", mensaje);// /user/cristian/private
        return mensaje;
    }
}
