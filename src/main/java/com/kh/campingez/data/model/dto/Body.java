package com.kh.campingez.data.model.dto;

import java.util.List;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Body {
	private String dataType;
	private int numOfRows;
	private int pageNo;
	private int totalCount;
	private List<Item> items;
	
}
