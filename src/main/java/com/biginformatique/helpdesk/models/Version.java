package com.biginformatique.helpdesk.models;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Table(name = "version")
public class Version implements Serializable {
	
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "version_id")
    private int version_id;
	
	@Column(name = "nom_version")
    private String nomVersion;
	
	@ManyToMany(mappedBy = "versions")
	private List<Logiciel> projects;
	

	public int getVersion_id() {
		return version_id;
	}

	public void setVersion_id(int version_id) {
		this.version_id = version_id;
	}

	public String getNomVersion() {
		return nomVersion;
	}

	public void setNomVersion(String nomVersion) {
		this.nomVersion = nomVersion;
	}
	
	

}
