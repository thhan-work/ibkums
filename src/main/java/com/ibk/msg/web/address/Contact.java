package com.ibk.msg.web.address;

import java.util.Date;

import lombok.Data;

@Data
public class Contact {
	private String catSeq;
	private String grpSeq;
	private String emplId;
	private String empl_Id;
	private String firstName;
	private String middleName;
	private String lastName;
	private String nickname;
	private String socialNo;
	private String sex;
	private String birthday;
	private String yinyang;
	private String eMail1;
	private String eMail2;
	private String mobile;
	private String homeZip;
	private String homeState;
	private String homeAddr1;
	private String homeAddr2;
	private String homePhone;
	private String homeFax;
	private String vocation;
	private String company;
	private String department;
	private String title;
	private String comZip;
	private String comState;
	private String comAddr1;
	private String comAddr2;
	private String comPhone;
	private String comFax;
	private String comWww;
	private String peWww;
	private String weddingDate;
	private String hobby;
	private String dmAddr;
	private String remark;
	private String contactShareYn;
	private Date regdate;
	private Integer targetGrpSeq;
	
	@Override
	public String toString() {
		return "Xcontact [catSeq=" + catSeq + ", grpSeq=" + grpSeq
				+ ", emplId=" + emplId + ", firstName=" + firstName
				+ ", middleName=" + middleName + ", lastName=" + lastName
				+ ", nickname=" + nickname + ", socialNo=" + socialNo
				+ ", sex=" + sex + ", birthday=" + birthday + ", yinyang="
				+ yinyang + ", eMail1=" + eMail1 + ", eMail2=" + eMail2
				+ ", mobile=" + mobile + ", homeZip=" + homeZip
				+ ", homeState=" + homeState + ", homeAddr1=" + homeAddr1
				+ ", homeAddr2=" + homeAddr2 + ", homePhone=" + homePhone
				+ ", homeFax=" + homeFax + ", vocation=" + vocation
				+ ", company=" + company + ", department=" + department
				+ ", title=" + title + ", comZip=" + comZip + ", comState="
				+ comState + ", comAddr1=" + comAddr1 + ", comAddr2="
				+ comAddr2 + ", comPhone=" + comPhone + ", comFax=" + comFax
				+ ", comWww=" + comWww + ", peWww=" + peWww + ", weddingDate="
				+ weddingDate + ", hobby=" + hobby + ", dmAddr=" + dmAddr
				+ ", remark=" + remark + ", contactShareYn=" + contactShareYn
				+ ", regdate=" + regdate + "]";
	}
	
	public String geteMail1() {
		return eMail1;
	}

	public void seteMail1(String eMail1) {
		this.eMail1 = eMail1;
	}

	public String geteMail2() {
		return eMail2;
	}

	public void seteMail2(String eMail2) {
		this.eMail2 = eMail2;
	}
	
}
