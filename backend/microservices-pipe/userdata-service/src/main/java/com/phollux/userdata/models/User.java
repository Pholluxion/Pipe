package com.phollux.userdata.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {

    @Id
    private String id;
    
    private String name;
    private String email;
    private String cellPhone;
    private String sex;
    private String occupation;

}
