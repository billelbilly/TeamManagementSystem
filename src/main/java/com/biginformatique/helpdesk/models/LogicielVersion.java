package com.biginformatique.helpdesk.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "logiciel_version")
public class LogicielVersion {
	
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "logiciel_version_id")
	private int logiciel_version_id;
	
	@Column(name = "logiciel_id")
	private int logiciel_id;
	
	@Column(name = "version_id")
	private int version_id;

	public int getLogiciel_version_id() {
		return logiciel_version_id;
	}

	public void setLogiciel_version_id(int logiciel_version_id) {
		this.logiciel_version_id = logiciel_version_id;
	}

	public int getLogiciel_id() {
		return logiciel_id;
	}

	public void setLogiciel_id(int logiciel_id) {
		this.logiciel_id = logiciel_id;
	}

	public int getVersion_id() {
		return version_id;
	}

	public void setVersion_id(int version_id) {
		this.version_id = version_id;
	}
	

}
