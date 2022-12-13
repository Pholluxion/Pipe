package com.phollux.userdata.services;

import com.phollux.userdata.dtos.UserDto;

public interface UserDataService {
    public UserDto setUser(UserDto user);
    public UserDto getUserByEmail(String email);
    public UserDto updateUserByEmail(UserDto userDto);
    public boolean deleteUserByEmail(String email);
}
