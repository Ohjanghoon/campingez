package com.kh.campingez.community.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.kh.campingez.trade.model.dto.TradePhoto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Community extends CommunityEntity {
	
	private int photoCount;
	private List<CommunityPhoto> photos = new ArrayList<>();
	
	public Community(String commNo, String userId, String categoryId, String commTitle, String commContent,
			LocalDateTime commDate, int readCount, int reportCount,
			isDelete isDelete, int likeCount, int photoCount) {
		super(commNo, userId, categoryId, commTitle, commContent, commDate, readCount, reportCount, isDelete, likeCount);
		this.photoCount = photoCount;
	}
	
	public void add(CommunityPhoto attach) {
		this.photos.add(attach);
	}

}
