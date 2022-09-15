package com.kh.campingez.inquire.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class InquireEntity {

	private String inqNo;
	private String categoryId;
	private String inqWriter;
	private String inqTitle;
	private String inqContent;
	private LocalDateTime inqDate;
	private LocalDateTime inqUpdatedDate;
}
