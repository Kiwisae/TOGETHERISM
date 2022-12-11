package together.model;

import lombok.Getter;
import lombok.Setter;


@Setter
@Getter
public class ReportDTO {
	
	private int report_num; 
	private String member_email; 		//(신고당하는 사람)
	private String report_member_email; //(신고하는 사람)
	private String report_reason;
}