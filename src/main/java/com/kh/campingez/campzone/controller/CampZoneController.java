package com.kh.campingez.campzone.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.campingez.campzone.model.dto.CampZone;
import com.kh.campingez.campzone.model.service.CampZoneService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/camp")
public class CampZoneController {
	
	@Autowired
	private CampZoneService campService;
	
	@GetMapping("/selectCampZone.do")
	public ResponseEntity<?> selectCampZone(@RequestParam String resNo){
		String zoneCode = resNo.substring(0, 2);
		
		CampZone campZone = campService.selectCampZone(zoneCode);
		log.debug("campZone = {}", campZone);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(campZone);
	}
	
	@GetMapping("/info")
	public void campInfo() {}

}
