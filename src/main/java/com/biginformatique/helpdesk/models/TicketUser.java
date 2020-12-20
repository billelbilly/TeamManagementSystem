package com.biginformatique.helpdesk.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "ticket_user")
public class TicketUser {
	@Id
	@Column(name = "ticket_id")
	private int ticket_id;
	
	@Column(name = "user_id")
	private int user_id;
	

	public TicketUser() {
		// TODO Auto-generated constructor stub
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getTicket_id() {
		return ticket_id;
	}

	public void setTicket_id(int ticket_id) {
		this.ticket_id = ticket_id;
	}
	
	

}
