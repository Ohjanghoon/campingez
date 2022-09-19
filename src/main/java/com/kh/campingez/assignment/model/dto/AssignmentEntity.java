package com.kh.campingez.assignment.model.dto;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

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
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime assignDate;
    private int assignLikeCount;
    private AssignState assignState;
    private String assignTransfer;
}
