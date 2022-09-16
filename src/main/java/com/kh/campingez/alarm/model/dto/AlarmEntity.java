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
	protected int alrId; 
	protected String userId; // 발신자
	@NonNull
	protected String targetUserId; // 수신자
	protected String alrContentId;
	protected AlarmType alrType;
	protected String alrMessage;
	protected String alrUrl;
	protected LocalDateTime alrDatetime; // 알림 발생일시
	protected LocalDateTime alrReadDatetime; // 알림 확인일시
}
