package together.model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Photo_BoardDTO {
	private int photo_num;
	private int club_num;
	private String photo_member_email;
	private Date photo_date;
	private String photo_content;
	private String photo_file;

}
