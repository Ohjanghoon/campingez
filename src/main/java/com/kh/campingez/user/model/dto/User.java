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
