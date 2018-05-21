package com.spring.henallux.IG3_EquipementsSportif_PWOO_POZZI.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/catalogue")
public class CatalogueController {
    @RequestMapping(method = RequestMethod.GET)
    public String home(Model model) {
        model.addAttribute("title", "Catalogue Page");
        return "integrated:catalogue";
    }

}