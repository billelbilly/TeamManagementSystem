package com.biginformatique.helpdesk.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.biginformatique.helpdesk.util.HibernateUtil;

public class StatisticsDao {

	public int[] getNumberTicketsDao() {

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		 int[] nbrTickets = new int[3];
		int nbrFermer=0;
		int nbrAssign=0;
		int nbropen=0;
		
		try {
			// start a transaction
			transaction = session.beginTransaction();
			Query query = session.createQuery(
					"FROM Ticket T WHERE T.Etat='fermer'");
			nbrFermer = query.getResultList().size();
			query = session.createQuery(
					"FROM Ticket T WHERE T.Etat='assigné'");
			nbrAssign = query.getResultList().size();
			query = session.createQuery(
					"FROM Ticket T WHERE T.Etat='créé'");
			nbropen = query.getResultList().size();
			nbrTickets[0]=nbrFermer;
			nbrTickets[1]=nbrAssign;
			nbrTickets[2]=nbropen;
			
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
		return nbrTickets;

	}

}
