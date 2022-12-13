package com.phollux.userdata.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDto {
    @Id
    private String id;
    private String name;
    private String email;
    private String cellPhone;
    private String sex;
    private String occupation;

}
