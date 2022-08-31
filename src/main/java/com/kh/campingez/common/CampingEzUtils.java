package com.kh.campingez.common;

public class CampingEzUtils {
	public static String getPagebar(int cPage, int limit, int totalContent, String url) {
		StringBuffer pagebar = new StringBuffer();
		url += "?cPage=";
		
		final int pagebarSize = 10;
		final int totalPage = (int)Math.ceil((double)totalContent / limit);
		final int pagebarStart = ((cPage - 1) / pagebarSize) * pagebarSize + 1;
		final int pagebarEnd = pagebarStart + pagebarSize - 1;
		int pageNo = pagebarStart;
		
		pagebar.append("<ul>\n");
		
		if(cPage == 1) {
	
		} else {
			pagebar.append("<a href='" + url + (pageNo - 1) + "'>이전</a>");
		}
		
		while(pageNo <= pagebarEnd && pageNo <= totalPage) {
			if(pageNo == cPage) {
				pagebar.append("<span>" + pageNo + "</span>");
			} else {
				pagebar.append("<a href='"+ url + pageNo +"'></a>");
			}
			pageNo++;
		}
		
		if(pageNo > totalPage) {
			
		} else {
			pagebar.append("<a href='"+ url + pageNo +"'></a>");
		}
		pagebar.append("</ul>");
		
		return pagebar.toString();
	}
}
