package com.kh.campingez.common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CampingEzUtils {
	public static String getPagebar(int cPage, int limit, int totalContent, String url) {
		StringBuffer pagebar = new StringBuffer();
		url += url.contains("?") ? "&cPage=" : "?cPage=";
		
		final int pagebarSize = 10;
		final int totalPage = (int)Math.ceil((double)totalContent / limit);
		final int pagebarStart = ((cPage - 1) / pagebarSize) * pagebarSize + 1;
		final int pagebarEnd = pagebarStart + pagebarSize - 1;
		int pageNo = pagebarStart;
		
		pagebar.append("<ul>\n");
		
		if(cPage == 1) {
	
		} else {
			pagebar.append("<span class='paging' id='page"+ (pageNo - 1) + "'>이전</span>\n");
		}
		
		while(pageNo <= pagebarEnd && pageNo <= totalPage) {
			if(pageNo == cPage) {
				pagebar.append("<span class='paging' id='page" + pageNo + "'>" + pageNo + "</span>\n");
			} else {
				pagebar.append("<span class='paging' id='page" + pageNo + "'>" + pageNo + "</span>\n");
			}
			pageNo++;
		}
		
		if(pageNo > totalPage) {
			
		} else {
			pagebar.append("<span class='paging' id='page" + pageNo + "'>다음</span>\n");
		}
		pagebar.append("</ul>");
		
		return pagebar.toString();
	}
	
	public static String getPagebar2(int cPage, int limit, int totalContent, String url) {
		StringBuffer pagebar = new StringBuffer();
		url += "?cPage="; // spring/board/boardList.do?cPage=
		
		final int pagebarSize = 5;
		final int totalPage = (int) Math.ceil((double) totalContent / limit);
		final int pagebarStart = ((cPage -1) / pagebarSize) * pagebarSize + 1;
		final int pagebarEnd = pagebarStart + pagebarSize - 1;
		int pageNo = pagebarStart;
		
		pagebar.append("<ul class=\"pagination justify-content-center\">\n");
		
		// previous
		if(pageNo == 1) {
			pagebar.append("<li class=\"page-item disabled\">\n"
					+ "      <a class=\"page-link\" href=\"#\" aria-label=\"Previous\">\n"
					+ "        <span aria-hidden=\"true\">&laquo;</span>\n"
					+ "        <span class=\"sr-only\">Previous</span>\n"
					+ "      </a>\n"
					+ "    </li>");
		}
		else {
			pagebar.append("<li class=\"page-item\">\n"
					+ "      <a class=\"page-link\" href=\"" + url + (pageNo - 1) + "\" aria-label=\"Previous\">\n"
					+ "        <span aria-hidden=\"true\">&laquo;</span>\n"
					+ "        <span class=\"sr-only\">Previous</span>\n"
					+ "      </a>\n"
					+ "    </li>");
		}
		
		// pageNo
		while(pageNo <= pagebarEnd && pageNo <= totalPage) {
			if(pageNo == cPage) {
				pagebar.append("<li class=\"page-item active\"><a class=\"page-link\" href=\"#\">"+ pageNo + "</a></li>\n");
			}
			else {
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\""+ url + pageNo +"\">"+ pageNo +"</a></li>\n");
			}
			pageNo++;
		}
		
		// next
		if(pageNo > totalPage) {
			pagebar.append("<li class=\"page-item disabled\">\n"
					+ "      <a class=\"page-link\" href=\"#\" aria-label=\"Next\">\n"
					+ "        <span aria-hidden=\"true\">&raquo;</span>\n"
					+ "        <span class=\"sr-only\">Next</span>\n"
					+ "      </a>\n"
					+ "    </li>\n");
		}
		else {
			pagebar.append("<li class=\"page-item\">\n"
					+ "      <a class=\"page-link\" href=\""+ url + pageNo +"\" aria-label=\"Next\">\n"
					+ "        <span aria-hidden=\"true\">&raquo;</span>\n"
					+ "        <span class=\"sr-only\">Next</span>\n"
					+ "      </a>\n"
					+ "    </li>\n");
		}
		
		pagebar.append("</ul>");
		
		return pagebar.toString();
}
	
	public static String getRenamedFilename(String originalFilename) {
		// 확장자추출
		int beginIndex = originalFilename.lastIndexOf(".");
		String ext = "";
		if(beginIndex > -1) 
			ext = originalFilename.substring(beginIndex); // .txt
		
		// 새이름 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		DecimalFormat df = new DecimalFormat("000");
		return sdf.format(new Date()) + df.format(Math.random() * 1000) + ext;
	}
	
}
