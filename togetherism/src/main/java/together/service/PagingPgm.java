package together.service;

public class PagingPgm {

	   
	private int listcount;            	// 데이터 갯수
	private int limit;         			// 화면에 출력할 데이터 갯수
	private int pagePerBlk = 10;    	// 블럭당 페이지 갯수 (1개의 블럭당 10개의 페이지)
	private int page;      				// 현재 페이지 번호
	private int startPage;         		// 각 블럭의 시작 페이지
	private int endPage;            	// 각 블럭의 끝 페이지
	private int totalPage;         		// 총 페이지 수
	   

	public PagingPgm(int listcount, int limit, int page) {
		this.listcount = listcount;
		this.limit = limit;
		this.page = page;

		
		totalPage = (int) Math.ceil((double) listcount / limit); // 올림
		startPage = page - (page - 1) % pagePerBlk;	// 1,  11, 21...
		endPage = startPage + pagePerBlk - 1; // 10, 20, 30...
		if (endPage > totalPage)
			endPage = totalPage;

	}

	public int getListcount() {
		return listcount;
	}

	public void setListcount(int listcount) {
		this.listcount = listcount;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public int getPagePerBlk() {
		return pagePerBlk;
	}

	public void setPagePerBlk(int pagePerBlk) {
		this.pagePerBlk = pagePerBlk;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	

}

