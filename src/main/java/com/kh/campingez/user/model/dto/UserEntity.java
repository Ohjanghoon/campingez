package com.kh.campingez.user.model.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.NonNull;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserEntity {

	protected String userId;
	@NonNull
	protected String userName;
	@NonNull
	protected String password;
	@NonNull
	protected String email;
	@NonNull
	protected String phone;
	@NonNull
	protected Gender gender;
	protected int yellowCard;
	protected int point;
	protected boolean enabled;
	protected LocalDateTime enrollDate;
	protected String enrollType;
}
