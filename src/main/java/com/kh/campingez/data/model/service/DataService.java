package com.kh.campingez.data.model.service;

import java.time.LocalDate;

import org.springframework.http.HttpEntity;

import com.kh.campingez.data.model.dto.Response;

public interface DataService {

	Response getWeather(LocalDate date, String time);

}
