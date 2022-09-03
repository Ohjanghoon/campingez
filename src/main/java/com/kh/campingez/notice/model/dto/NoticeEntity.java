package com.kh.campingez.notice.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NoticeEntity {
	private String noticeNo;
	private String categoryId;
	private String noticeTitle;
	private String noticeContent;
	private LocalDate noticeDate;
	private String noticeType;
}
