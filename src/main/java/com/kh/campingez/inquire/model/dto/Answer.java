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
public class Answer {

	private String answerNo;
	private String inqNo;
	private String answerContent;
	private LocalDateTime answerDate;
	
}
