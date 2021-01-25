package com.biginformatique.helpdesk.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Type;


@Entity
@Table(name = "contacts")
public class Contact implements Serializable{
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "contact_id")
	private int contact_id;
	
	@Column(name = "nom")
	private String Nom;
	
	@Column(name = "email")
	private String Email;
	
	@Column(name = "objet")
	private String Objet;
	
	@Column(name = "message")
	@Type(type="text")
	private String Message;
	
	

	public int getContact_id() {
		return contact_id;
	}



	public void setContact_id(int contact_id) {
		this.contact_id = contact_id;
	}



	public String getNom() {
		return Nom;
	}



	public void setNom(String nom) {
		Nom = nom;
	}



	public String getEmail() {
		return Email;
	}



	public void setEmail(String email) {
		Email = email;
	}



	public String getObjet() {
		return Objet;
	}



	public void setObjet(String objet) {
		Objet = objet;
	}



	public String getMessage() {
		return Message;
	}



	public void setMessage(String message) {
		Message = message;
	}



	public Contact() {
	
	}

}
