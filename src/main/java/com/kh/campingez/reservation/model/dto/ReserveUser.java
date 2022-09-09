package com.kh.campingez.reservation.model.dto;

import com.kh.campingez.user.model.dto.User;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReserveUser {

	private Reservation reservation;
	private User user;
}
