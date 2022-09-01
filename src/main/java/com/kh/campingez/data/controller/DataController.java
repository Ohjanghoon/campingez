package com.kh.campingez.data.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.campingez.data.model.service.DataService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/data")
public class DataController {

	@Autowired
	DataService dataService;
	
	@GetMapping("/data.do")
	public void data() {}
	
	@GetMapping("/weather.do")
	public ResponseEntity<?> weather(@RequestParam @DateTimeFormat(pattern = "yyyyMMdd") LocalDate date, @RequestParam String time){
		log.debug("time = {}", time);
		log.debug("date = {}", date.format(DateTimeFormatter.ofPattern("yyyyMMdd")));
		log.debug("test = {}", dataService.getWeather(date, time));
//		log.debug("test = {}", dataService.getWeather(date, time).getBody().getItems());
		
		return null;
//		return ResponseEntity.status(HttpStatus.OK)
//				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE) // contentType=application/json; charset=utf-8
//				.body(dataService.getWeather(date).getBody().getItems());
	}
}
