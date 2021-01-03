package com.biginformatique.helpdesk.models;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;


import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "tickets")
public class Ticket implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ticket_id")
	private int ticket_id;

	@Column(name = "objet")
	private String Objet;

	@Column(name = "details")
	private String Details;

	@Column(name = "etat")
	private String Etat;

	@Column(name = "severity")
	private String Severity;
	
	@Column(name = "assigned_to")
	private String AssignedTo;
	
	@Column(name = "closed_by")
	private String ClosedBy;
	
	@Column(name = "attachment_path")
	private String Attachment;

	@CreationTimestamp
    private LocalDateTime createDateTime;

	@UpdateTimestamp
    private LocalDateTime closedDateTime;
	
	@UpdateTimestamp
    private LocalDateTime assignedDateTime;

	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false, insertable = true)
	private User user;
	
	@OneToMany(fetch = FetchType.EAGER,mappedBy="ticket")
	 @Fetch(value = FetchMode.SUBSELECT)
    private List<Response> response;
	
	 @OneToOne(mappedBy = "ticket")
	    private Planification planification;
	
	//Assign To logic
//	@OneToOne()
//    @JoinTable(name = "ticket_user", 
//      joinColumns = 
//        { @JoinColumn(name = "ticket_id") },
//      inverseJoinColumns = 
//        {@JoinColumn(name = "user_id") })
//    private User userAssigned;

//	public User getUserAssigned() {
//		return userAssigned;
//	}
//
//	public void setUserAssigned(User userAssigned) {
//		this.userAssigned = userAssigned;
//	}

	public int getTicket_id() {
		return ticket_id;
	}

	public void setTicket_id(int ticket_id) {
		this.ticket_id = ticket_id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Ticket() {

	}

	public Ticket(String etat) {
		this.Etat = etat;
	}

	public int getId() {
		return ticket_id;
	}

	public void setId(int id) {
		this.ticket_id = id;
	}

	public String getObjet() {
		return Objet;
	}

	public void setObjet(String objet) {
		Objet = objet;
	}

	public String getDetails() {
		return Details;
	}

	public void setDetails(String details) {
		Details = details;
	}

	public String getEtat() {
		return Etat;
	}

	public void setEtat(String etat) {
		Etat = etat;
	}

	public String getSeverity() {
		return Severity;
	}

	public void setSeverity(String severity) {
		Severity = severity;
	}
	
	public String getAttachment() {
		return Attachment;
	}

	public void setAttachment(String attachment) {
		Attachment = attachment;
	}
	
	public String getAssignedTo() {
		return AssignedTo;
	}

	public void setAssignedTo(String assignedTo) {
		AssignedTo = assignedTo;
	}

	public String getClosedBy() {
		return ClosedBy;
	}

	public void setClosedBy(String closedBy) {
		ClosedBy = closedBy;
	}

	public LocalDateTime getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(LocalDateTime createDateTime) {
		this.createDateTime = createDateTime;
	}

	public LocalDateTime getClosedDateTime() {
		return closedDateTime;
	}

	public void setClosedDateTime(LocalDateTime closedDateTime) {
		this.closedDateTime = closedDateTime;
	}

	public List<Response> getResponse() {
		return response;
	}

	public void setResponse(List<Response> response) {
		this.response = response;
	}

	public Planification getPlanification() {
		return planification;
	}

	public void setPlanification(Planification planification) {
		this.planification = planification;
	}

	public LocalDateTime getAssignedDateTime() {
		return assignedDateTime;
	}

	public void setAssignedDateTime(LocalDateTime assignedDateTime) {
		this.assignedDateTime = assignedDateTime;
	}
	
	

}
