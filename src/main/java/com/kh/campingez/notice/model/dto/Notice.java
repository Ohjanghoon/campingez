package com.kh.campingez.notice.model.dto;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Notice extends NoticeEntity{
	private int photoCount;
	private List<NoticePhoto> photos = new ArrayList<>();
	
	public Notice(String noticeNo, String categoryId, String noticeTitle, String noticeContent, LocalDate noticeDate,
			String noticeType, int photoCount) {
		super(noticeNo, categoryId, noticeTitle, noticeContent, noticeDate, noticeType);
		this.photoCount = photoCount;
	}
	
	public void add(NoticePhoto photo) {
		this.photos.add(photo);
	}
}
