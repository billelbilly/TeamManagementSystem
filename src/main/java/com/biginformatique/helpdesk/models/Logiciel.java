package com.biginformatique.helpdesk.models;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Table(name = "logiciel")
public class Logiciel implements Serializable {
	
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "logiciel_id")
    private int logiciel_id;

	@Column(name = "nom_logiciel")
    private String nomLogiciel;
	
	
	 @ManyToMany(cascade = { CascadeType.ALL })
	    @JoinTable(
	        name = "logiciel_version", 
	        joinColumns = { @JoinColumn(name = "logiciel_id") }, 
	        inverseJoinColumns = { @JoinColumn(name = "version_id") }
	    )
	private List<Version> versions;
	
	public int getLogiciel_id() {
		return logiciel_id;
	}


	public void setLogiciel_id(int logiciel_id) {
		this.logiciel_id = logiciel_id;
	}


	public String getNomLogiciel() {
		return nomLogiciel;
	}


	public void setNomLogiciel(String nomLogiciel) {
		this.nomLogiciel = nomLogiciel;
	}
	

}
