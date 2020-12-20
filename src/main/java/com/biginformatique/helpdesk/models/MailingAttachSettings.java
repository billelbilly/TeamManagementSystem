package com.biginformatique.helpdesk.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Mailing_Attachment_Settings")
public class MailingAttachSettings implements Serializable {
	
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "setting_id")
    private int setting_id;
	
	@Column(name = "host")
    private String host;
	
	@Column(name = "smtp")
    private String smtp;


	@Column(name = "port")
    private String port;
	
	@Column(name = "email")
    private String email;

	@Column(name = "nom")
    private String nom;
	
	@Column(name = "password")
    private String password;
	
	@Column(name = "attchpath")
    private String attchpath;
	
	

	public int getSetting_id() {
		return setting_id;
	}



	public void setSetting_id(int setting_id) {
		this.setting_id = setting_id;
	}



	public String getHost() {
		return host;
	}



	public void setHost(String host) {
		this.host = host;
	}



	public String getPort() {
		return port;
	}



	public void setPort(String port) {
		this.port = port;
	}



	public String getNom() {
		return nom;
	}



	public void setNom(String nom) {
		this.nom = nom;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public String getAttchpath() {
		return attchpath;
	}



	public void setAttchpath(String attchpath) {
		this.attchpath = attchpath;
	}



	public MailingAttachSettings() {
		
	}
	
	public String getSmtp() {
		return smtp;
	}



	public void setSmtp(String smtp) {
		this.smtp = smtp;
	}
	
	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}

}
