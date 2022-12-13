package com.phollux.auth.controllers;

import com.phollux.auth.dto.LoginDto;
import com.phollux.auth.dto.RegisterDto;
import com.phollux.auth.exceptions.UserNotFoundException;
import com.phollux.auth.models.UserEntity;
import com.phollux.auth.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

   private final UserRepository userRepository;

   @Autowired
    public AuthController(UserRepository userRepository) {

        this.userRepository = userRepository;


   }

    @PostMapping(path = "register")
    public ResponseEntity<String> register(@RequestBody RegisterDto registerDto){
        if(userRepository.existsByEmail(registerDto.getEmail())){
            throw new UserNotFoundException("El correo electrónico ya existe");
        }

        UserEntity user = new UserEntity();
        user.setEmail(registerDto.getEmail());
        user.setPassword(registerDto.getPassword());
        user.setUsername(registerDto.getUsername());

        userRepository.save(user);

        return new ResponseEntity<>("Usuario registrado",HttpStatus.OK);

    }

    @PostMapping(path = "login")
    public ResponseEntity<String> login(@RequestBody LoginDto loginDto){
       try {

        Optional<UserEntity> user = userRepository.findByEmail(loginDto.getEmail());

           assert user.orElse(null) != null;
           if(loginDto.getPassword().equals(user.orElse(null).getPassword())){
            return new ResponseEntity<>( user.orElse(null).getUsername(),HttpStatus.OK);
        }else{
            return new ResponseEntity<>( "Correo o contraseña incorrectos",HttpStatus.BAD_REQUEST);
        }

       }catch (Exception ex){
           throw new UserNotFoundException("El usuario no se encuentra registrado");
       }



    }
}
