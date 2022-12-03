package com.phollux.profile.controllers;

import com.phollux.profile.dto.ProfileDto;
import com.phollux.profile.exceptions.ProfileNotFoundException;
import com.phollux.profile.models.ProfileEntity;
import com.phollux.profile.repositories.ProfileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/profile")
public class ProfileController {

    private final ProfileRepository profileRepository;

    @Autowired
    public ProfileController(ProfileRepository profileRepository) {

        this.profileRepository = profileRepository;

    }

    @PostMapping(path = "search")
    public ResponseEntity<ProfileEntity> search(@RequestBody ProfileDto profileDto) {
        ProfileEntity perfil = profileRepository.findById(profileDto.getId());
        if (perfil == null) {
            throw new ProfileNotFoundException("El perfil que está buscando no existe");
        }
        return new ResponseEntity<ProfileEntity>(perfil, HttpStatus.OK);
    }

    @PostMapping(path = "add")
    public ResponseEntity<String> add(@RequestBody ProfileDto profileDto) {
        ProfileEntity profile = new ProfileEntity();
        profile.setCorreo(profileDto.getCorreo());
        profile.setDescripcion(profileDto.getDescripcion());
        profile.setFoto(profileDto.getFoto());
        profile.setNombre(profileDto.getNombre());

        profileRepository.save(profile);
        return new ResponseEntity<>("Perfil registrado", HttpStatus.OK);

    }

    @PostMapping(path = "edit")
    public ResponseEntity<String> edit(@RequestBody ProfileDto profileDto) {
        ProfileEntity perfil = profileRepository.findById(profileDto.getId());
        if (perfil == null)
            return new ResponseEntity<>("El perfil no se encuentra registrado", HttpStatus.NOT_FOUND);
        else {
            perfil.setCorreo(profileDto.getCorreo());
            perfil.setDescripcion(profileDto.getDescripcion());
            perfil.setFoto(profileDto.getFoto());
            perfil.setNombre(profileDto.getNombre());
            profileRepository.save(perfil);
        }
        return new ResponseEntity<>("El perfil se ha editado con exito", HttpStatus.OK);
    }

    @PostMapping(path = "delete")
    public ResponseEntity<String> delete(@RequestBody ProfileDto profileDto) {
        ProfileEntity perfil = profileRepository.findById(profileDto.getId());
        if (perfil == null)
            return new ResponseEntity<>("El perfil no se encuentra registrado", HttpStatus.NOT_FOUND);
        profileRepository.delete(perfil);   
        return new ResponseEntity<>("El perfil se ha eliminado con exito", HttpStatus.OK);
    }
}
