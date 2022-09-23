package com.kh.campingez.community.model.dto;

public enum CommentLevel {
	COMMENT(1), REPLY(2);
	
	private int value;
	
	CommentLevel(int value){
		this.value = value;
	}
	
	public int getValue() {
		return this.value;
	}
	
	public static CommentLevel valueOf(int value) {
		switch(value) {
		case 1 : return COMMENT;
		case 2 : return REPLY;
		default : throw new AssertionError("Unknown CommentLevel : " + value);
		}
	}
}
