package com.biginformatique.helpdesk.models;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;



@Entity
@Table(name = "planification")
public class Planification implements Serializable{
	
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "planif_id")
    private int planifId;
	
	@Column(name = "date_debut_planif")
    private LocalDate dateDebutPlanif;
	
	@Column(name = "date_fin_planif")
    private LocalDate dateFinPlanif;
	
	@Column(name = "date_debut_realise")
    private LocalDate dateDebutRealise;
	
	@Column(name = "date_fin_realise")
    private LocalDate dateFinRealise;
	
	@Column(name = "observation")
    private String Observation;
	
	@OneToOne
    @JoinColumn(name = "ticket_id",unique = true)
    private Ticket ticket;
	
	

	public Ticket getTicket() {
		return ticket;
	}



	public void setTicket(Ticket ticket) {
		this.ticket = ticket;
	}



	public int getPlanifId() {
		return planifId;
	}



	public void setPlanifId(int planifId) {
		this.planifId = planifId;
	}



	public LocalDate getDateDebutPlanif() {
		return dateDebutPlanif;
	}



	public void setDateDebutPlanif(LocalDate dateDebutPlanif) {
		this.dateDebutPlanif = dateDebutPlanif;
	}



	public LocalDate getDateFinPlanif() {
		return dateFinPlanif;
	}



	public void setDateFinPlanif(LocalDate dateFinPlanif) {
		this.dateFinPlanif = dateFinPlanif;
	}



	public LocalDate getDateDebutRealise() {
		return dateDebutRealise;
	}



	public void setDateDebutRealise(LocalDate dateDebutRealise) {
		this.dateDebutRealise = dateDebutRealise;
	}



	public LocalDate getDateFinRealise() {
		return dateFinRealise;
	}



	public void setDateFinRealise(LocalDate dateFinRealise) {
		this.dateFinRealise = dateFinRealise;
	}



	public String getObservation() {
		return Observation;
	}



	public void setObservation(String observation) {
		Observation = observation;
	}



	public Planification() {
		// TODO Auto-generated constructor stub
	}

}
