package com.phollux.userdata.controllers;

import com.phollux.userdata.dtos.UserDto;
import com.phollux.userdata.services.UserDataService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path = "/api/userdata")
public class UserController {

    private final UserDataService userService;

    @Autowired
    public UserController(UserDataService userServiceImpl) {
        this.userService = userServiceImpl;
    }

    @PostMapping(path = "/save")
    public ResponseEntity<UserDto> saveUser(@RequestBody UserDto userDto){
        return new ResponseEntity<>(userService.setUser(userDto), HttpStatus.CREATED);
    }

    @PutMapping(path = "/update")
    public ResponseEntity<UserDto> updateUser(@RequestBody UserDto userDto){
        return new ResponseEntity<>(userService.updateUserByEmail(userDto), HttpStatus.OK);
    }

    @GetMapping(path = "/get")
    public ResponseEntity<UserDto> getUser(@RequestParam(value = "email", required = true) String email){
        return new ResponseEntity<>(userService.getUserByEmail(email), HttpStatus.OK);
    }

    @DeleteMapping(path = "/delete")
    public ResponseEntity<Boolean> deleteUser(@RequestParam(value = "email", required = true) String email){
        return new ResponseEntity<>(userService.deleteUserByEmail(email), HttpStatus.OK);
    }

}
