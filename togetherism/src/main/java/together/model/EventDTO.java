package together.model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EventDTO {
	private int event_num;
	private int club_num;
	private String club_host_email;
	private String event_title;
	private Date event_reg_date;
	private Date event_date;
	private String event_info;
	private String event_file;
	private String event_spot_long;
	private String event_spot_lat;
	private String event_region;
	
	// page
	private int startRow;
	private int endRow;
	
	// 검색
	private String keyword;
	// 미리보기
	private String preview;

}

