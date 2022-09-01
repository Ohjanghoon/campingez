package com.kh.campingez.campzone.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.campingez.campzone.model.service.CampZoneService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/camp")
public class CampZoneController {
	
	@Autowired
	private CampZoneService campService;
}
