package com.kh.campingez.report.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Report extends ReportEntity {
	private String categoryName;
	private String commUserId;
	private int totalReport;
	private String isBlacklist;
}
