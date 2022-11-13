package com.pipe.pipechatprojet.control;


import com.pipe.pipechatprojet.control.modelo.Mensage;
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
    
    @MessageMapping("/mensage")// /app/mensage
    @SendTo("/chat/public")
    public Mensage receivePublicMensage(@Payload Mensage mensage){
        return mensage;
    }
    
    @MessageMapping("/private-mensage")
    private Mensage receivePrivateMensage(@Payload Mensage mensage){
        simpMessagingTemplate.convertAndSendToUser(mensage.getReceiverName(),"/private",mensage);// /user/cristian/private
        return mensage;
    }
}
