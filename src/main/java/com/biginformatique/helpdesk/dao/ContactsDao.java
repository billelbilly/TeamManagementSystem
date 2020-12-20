package com.biginformatique.helpdesk.dao;

import java.util.List;

import javax.persistence.EntityManager;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.biginformatique.helpdesk.models.Contact;
import com.biginformatique.helpdesk.util.HibernateUtil;

public class ContactsDao {

	public ContactsDao() {
		
	}
	
	public boolean saveContactDao(Contact contact) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			// start a transaction
			transaction = session.beginTransaction();

			session.save(contact);
			// commit transaction
			transaction.commit();
			return true;
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

	public List getContactsDao() {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		List allcontacts = null;

		try {

			// start a transaction
			transaction = session.beginTransaction();

			Query query = session.createQuery(
					"SELECT C.contact_id, C.Nom, C.Email, C.Objet,C.Message FROM Contact C");
			allcontacts = query.list();
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

		return allcontacts;
	}

	public boolean deleteContactDao(String contact_id) {
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		EntityManager em=session.getEntityManagerFactory().createEntityManager();
		boolean contactRemoved=false;
		try {
			 em.getTransaction().begin();
			 Contact contactToDelete = em.find(Contact.class, Integer.parseInt(contact_id));
			em.remove(contactToDelete);
			// commit EntityManager Transaction			
			em.getTransaction().commit();
			contactRemoved=true;
		

		} catch (Exception e) {
			
			e.printStackTrace();
		} finally {
			session.close();
		}
		return contactRemoved;
	}

}
