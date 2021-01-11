package com.biginformatique.helpdesk.dao;

import java.util.List;

import javax.persistence.EntityManager;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.biginformatique.helpdesk.models.Logiciel;
import com.biginformatique.helpdesk.models.MailingAttachSettings;
import com.biginformatique.helpdesk.util.HibernateUtil;

public class SettingsDao {

	public boolean saveMailingAttachSettings(MailingAttachSettings mailingAttachSettings) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		MailingAttachSettings settings = null;
		boolean saved = false;
		try {
			// start a transaction
			transaction = session.beginTransaction();

			// get an settings object
			settings = (MailingAttachSettings) session.createQuery("from MailingAttachSettings S").getSingleResult();

			String updateSettings = "UPDATE MailingAttachSettings S set S.host = :host,"
					+ "S.smtp= :smtp, S.port= :port, S.nom= :nom, S.password= :password, S.attchpath= :attchpath WHERE id = :setting_id";
			Query query = session.createQuery(updateSettings);
			query.setParameter("setting_id", settings.getSetting_id());
			query.setParameter("host", mailingAttachSettings.getHost());
			query.setParameter("smtp", mailingAttachSettings.getSmtp());
			query.setParameter("port", mailingAttachSettings.getPort());
			query.setParameter("nom", mailingAttachSettings.getNom());
			query.setParameter("password", mailingAttachSettings.getPassword());
			query.setParameter("attchpath", mailingAttachSettings.getAttchpath());
			query.executeUpdate();
			// commit transaction
			transaction.commit();
			saved = true;

		} catch (Exception e) {
			
			if (settings == null) {
				// save the settings object
				session.save(mailingAttachSettings);
				// commit transaction
				transaction.commit();
				saved = true;
			}else {
				if (transaction != null) {
					transaction.rollback();
				}
				e.printStackTrace();
			}
			
		} finally {
			session.close();
		}
		return saved;
	}

	public MailingAttachSettings getInitialSettingsDao() {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		MailingAttachSettings settings = null;
		try {
			// start a transaction
			transaction = session.beginTransaction();

			// get an settings object
			settings = (MailingAttachSettings) session.createQuery("from MailingAttachSettings S").getSingleResult();

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			session.close();
		}
		return settings;
	}
	
	public List getSettingsListDao() {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		List listSettings = null;

		try {

			// start a transaction
			transaction = session.beginTransaction();

			Query query = session.createQuery(
					"SELECT S.setting_id, S.host, S.smtp,S.port, S.email,S.nom,S.attchpath FROM MailingAttachSettings S");
			listSettings = query.list();
			// commit transaction
			transaction.commit();

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		} finally {
			session.close();
		}

		return listSettings;
	}
	
	public boolean EditMailAttachSettingsDao(MailingAttachSettings mailingAttachSettings) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			// start a transaction
			transaction = session.beginTransaction();
			if (mailingAttachSettings.getPassword() != null) {

				String updateUser = "UPDATE MailingAttachSettings S set S.host= :host, S.smtp= :smtp, S.port= :port, S.email= :email, S.nom = :nom, S.password= :password, S.attchpath= :attchpath WHERE setting_id = :setting_id";
				Query query = session.createQuery(updateUser);
				query.setParameter("host", mailingAttachSettings.getHost());
				query.setParameter("smtp", mailingAttachSettings.getSmtp());
				query.setParameter("port", mailingAttachSettings.getPort());
				query.setParameter("email", mailingAttachSettings.getEmail());
				query.setParameter("nom", mailingAttachSettings.getNom());
				query.setParameter("password", mailingAttachSettings.getPassword());
				query.setParameter("attchpath", mailingAttachSettings.getAttchpath());
				query.setParameter("setting_id", mailingAttachSettings.getSetting_id());
				
				int result = query.executeUpdate();

				if (result != 0) {
					// commit transaction
					transaction.commit();
					return true;
				}
			}else {
				String updateUser = "UPDATE MailingAttachSettings S set S.host= :host, S.smtp= :smtp, S.port= :port, S.email= :email, S.nom = :nom, S.attchpath= :attchpath WHERE setting_id = :setting_id";
				Query query = session.createQuery(updateUser);
				query.setParameter("host", mailingAttachSettings.getHost());
				query.setParameter("smtp", mailingAttachSettings.getSmtp());
				query.setParameter("port", mailingAttachSettings.getPort());
				query.setParameter("email", mailingAttachSettings.getEmail());
				query.setParameter("nom", mailingAttachSettings.getNom());
				query.setParameter("attchpath", mailingAttachSettings.getAttchpath());
				query.setParameter("setting_id", mailingAttachSettings.getSetting_id());
				int result = query.executeUpdate();

				if (result != 0) {
					// commit transaction
					transaction.commit();
					return true;
				}
				
			}


		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		} finally {
			session.close();
		}
		return false;
		
	}

	public void LogicielVersionDao(Logiciel logiciel) {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		EntityManager em = session.getEntityManagerFactory().createEntityManager();

		try {
			  em.getTransaction().begin();
			  em.persist(logiciel);
			  em.getTransaction().commit();

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			session.close();
		}
	
		
	}

	public void VersionDao() {
		// TODO Auto-generated method stub
		
	}

	public void LogicielDao() {
		// TODO Auto-generated method stub
		
	}

}
