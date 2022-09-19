package com.kh.campingez.community.model.dto;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@RequiredArgsConstructor
@AllArgsConstructor
public class CommunityPhoto {
			
		private int commPhotoNo;
		private String commNo;
		@NonNull
		private String originalFilename;
		@NonNull
		private String renamedFilename;
}
