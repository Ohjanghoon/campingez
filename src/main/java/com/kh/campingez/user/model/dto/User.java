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

	@NonNull
	protected String memberId;
	@NonNull
	protected String password;
	@NonNull
	protected String name;
	protected Gender gender;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	protected LocalDate birthday;
	protected String email;
	@NonNull
	protected String phone;
	protected String address;
	protected String[] hobby;
	protected LocalDateTime createdAt;
	protected LocalDateTime updatedAt;
	protected boolean enabled;
}
