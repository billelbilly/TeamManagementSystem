package com.biginformatique.helpdesk.models;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "responses")
public class Response implements Serializable{

	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "response_id")
    private int responseId;
	
	public Ticket getTicket() {
		return ticket;
	}

	public void setTicket(Ticket ticket) {
		this.ticket = ticket;
	}

	@Column(name = "response")
	@Type(type="text")
    private String Response;
	
	@CreationTimestamp
    private LocalDateTime createDateTime;
	
	@ManyToOne
	@JoinColumn(name = "ticket_id", nullable = false, insertable = true)
	private Ticket ticket;
	
	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false, insertable = true)
	private User user;


	public Response() {
		// TODO Auto-generated constructor stub
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getResponseId() {
		return responseId;
	}

	public void setResponseId(int responseId) {
		this.responseId = responseId;
	}

	public String getResponse() {
		return Response;
	}

	public void setResponse(String response) {
		Response = response;
	}


}
