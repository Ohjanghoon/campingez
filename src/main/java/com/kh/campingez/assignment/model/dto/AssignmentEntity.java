package com.kh.campingez.assignment.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AssignmentEntity {
	
	private String assignNo;
	private String userId;
	private String resNo;
	private String assignTitle;
	private String assignContent;
    private int assignPrice;
    private LocalDateTime assignDate;
    private int assignLikeCount;
    private AssignState assignState;
}
