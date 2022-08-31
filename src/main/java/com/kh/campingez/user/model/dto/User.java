package com.kh.campingez.user.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class User {

	private String userId;
	@NonNull
	private String userName;
	@NonNull
	private String password;
	@NonNull
	private String email;
	@NonNull
	private String phone;
	@NonNull
	private Gender gender;
	private int yellowCard;
	private int point;
	private int enabled;
	private LocalDateTime enrollDate;
	private String enrollType;
}