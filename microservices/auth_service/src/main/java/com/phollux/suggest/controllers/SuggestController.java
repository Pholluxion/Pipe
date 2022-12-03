package com.phollux.suggest.controllers;

import com.phollux.suggest.dto.SuggestDto;
import com.phollux.suggest.exceptions.SuggestNotFoundException;
import com.phollux.suggest.models.SuggestEntity;
import com.phollux.suggest.repositories.SuggestRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/suggest")
public class SuggestController {

    private final SuggestRepository suggestRepository;

    @Autowired
    public SuggestController(SuggestRepository suggestRepository) {

        this.suggestRepository = suggestRepository;

    }

    @PostMapping(path = "add")
    public ResponseEntity<String> add(@RequestBody SuggestDto suggestDto) {
        SuggestEntity suggest = new SuggestEntity();
        suggest.setCorreo(suggestDto.getCorreo());
        suggest.setDescripcion(suggestDto.getDescripcion());
        suggest.setNombre(suggestDto.getNombre());

        suggestRepository.save(suggest);
        return new ResponseEntity<>("Sugerencia registrada", HttpStatus.OK);
    }

    /**
     * @param suggestDto
     * @return List suggest
     */
    @PostMapping(path = "search")
    public ResponseEntity<List<SuggestEntity>> search(@RequestBody SuggestDto suggestDto) {
        List<SuggestEntity> suggestList = suggestRepository.findAll();
        if (suggestList.size() == 0)
            throw new SuggestNotFoundException("No hay sugerencias para mostrar.");
        return new ResponseEntity<List<SuggestEntity>>(suggestList, HttpStatus.OK);
    }

    @DeleteMapping(path = "delete")
    public ResponseEntity<String> delete(@RequestBody SuggestDto suggestDto) {
        SuggestEntity suggest = suggestRepository.findById(suggestDto.getId());
        if (suggest == null)
            return new ResponseEntity<>("La sugerencia no se encuentra registrada", HttpStatus.NOT_FOUND);
        suggestRepository.delete(suggest);
        return new ResponseEntity<>("La sugerencia se ha eliminado con exito", HttpStatus.OK);
    }

}
