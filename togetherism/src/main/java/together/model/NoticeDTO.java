package together.model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class NoticeDTO {
	
	private int notice_num;
	private String manager_email;
	private String notice_title;
	private Date notice_reg_date;
	private String notice_content;
	private String notice_file;

}
