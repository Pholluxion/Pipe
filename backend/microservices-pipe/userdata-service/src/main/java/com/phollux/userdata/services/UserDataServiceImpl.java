package com.phollux.userdata.services;

import com.phollux.userdata.dtos.UserDto;
import com.phollux.userdata.exceptions.UserFoundException;
import com.phollux.userdata.exceptions.UserNotFoundException;
import com.phollux.userdata.models.User;
import com.phollux.userdata.repositories.UserDataRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserDataServiceImpl implements UserDataService {


    private final UserDataRepository userRepository;

    @Autowired
    public UserDataServiceImpl(UserDataRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDto setUser(UserDto user) {

        Optional<User> dbUser = userRepository.findByEmail(user.getEmail());

        if (dbUser.isEmpty()) {
            return mapEntityToDto(userRepository.save(mapDtoToEntity(user)));
        } else {
            throw new UserFoundException("User found");
        }


    }

    @Override
    public UserDto getUserByEmail(String email) {
        return mapEntityToDto(userRepository.findByEmail(email).orElseThrow(() -> new UserNotFoundException("User not found")));
    }

    @Override
    public UserDto updateUserByEmail(UserDto userDto) {
        User user = userRepository.findByEmail(userDto.getEmail()).orElseThrow(() -> new UserNotFoundException("User not found"));

        user.setSex(userDto.getSex());
        user.setName(userDto.getName());
        user.setEmail(userDto.getEmail());
        user.setCellPhone(userDto.getCellPhone());
        user.setOccupation(userDto.getOccupation());

        return mapEntityToDto(userRepository.save(user));
    }

    @Override
    public boolean deleteUserByEmail(String email) {

        User user = userRepository.findByEmail(email).orElseThrow(() -> new UserNotFoundException("User not found"));

        try {
            userRepository.deleteById(user.getId());
            return true;
        } catch (Exception ex) {
            return false;
        }
    }


    UserDto mapEntityToDto(User user) {
        UserDto userDto = new UserDto();

        userDto.setId(user.getId());
        userDto.setSex(user.getSex());
        userDto.setName(user.getName());
        userDto.setEmail(user.getEmail());
        userDto.setCellPhone(user.getCellPhone());
        userDto.setOccupation(user.getOccupation());

        return userDto;
    }

    User mapDtoToEntity(UserDto userDto) {

        User userEntity = new User();

        userEntity.setId(userDto.getId());
        userEntity.setSex(userDto.getSex());
        userEntity.setName(userDto.getName());
        userEntity.setEmail(userDto.getEmail());
        userEntity.setCellPhone(userDto.getCellPhone());
        userEntity.setOccupation(userDto.getOccupation());

        return userEntity;
    }

}
