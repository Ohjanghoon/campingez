package com.kh.campingez.ws.payload;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PayLoad {
	private Type type;
	private String from;
	private String to;
	private String msg;
	private long time;
	private String chatTradeNo;
}
