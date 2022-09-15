package com.kh.campingez.alarm.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AlarmEntity {
	@NonNull
	private int alrId; 
	private String userId; // 발신자
	@NonNull
	private String targetUserId; // 수신자
	private String alrContentId;
	private AlarmType alrType;
	private String alrMessage;
	private String alrUrl;
	private LocalDateTime alrDatetime; // 알림 발생일시
	private LocalDateTime alrReadDatetime; // 알림 확인일시
}
