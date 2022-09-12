package com.kh.campingez.admin.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Stats extends StatsEntity{
	private int visitDateCount;
	private String month;
	private String totalPrice;
	private LocalDate resDate;
}
