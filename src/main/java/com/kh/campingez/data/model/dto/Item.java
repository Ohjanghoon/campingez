package com.kh.campingez.data.model.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Item {
    private String baseDate;
    private String baseTime;
    private String category;
    private int nx;
    private int ny;
    //private double obsrValue;
    private String fcstDate;
    private String fcstTime;
    private String fcstValue;
}
