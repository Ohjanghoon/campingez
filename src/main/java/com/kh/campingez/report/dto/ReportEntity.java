package com.kh.campingez.report.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReportEntity {
	private int reportNo;
	private String commNo;
	private String userId;
	private String reportContent;
	private LocalDateTime reportDate;
	private String reportType;
	private String reportAction;
}
