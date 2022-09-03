package com.kh.campingez.notice.model.dto;

import java.time.LocalDate;

import org.springframework.lang.NonNull;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@RequiredArgsConstructor
public class NoticePhoto {
	private int noticePhotoNo;
	private String noticeNo;
	@NonNull
	private String noticeOriginalFilename;
	@NonNull
	private String noticeRenamedFilename;
}
