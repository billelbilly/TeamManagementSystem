package com.biginformatique.helpdesk.dao;

import java.io.File;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.persistence.EntityManager;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.biginformatique.helpdesk.models.Ticket;
import com.biginformatique.helpdesk.models.User;
import com.biginformatique.helpdesk.util.HibernateUtil;

public class TicketDao {

	public TicketDao() {

	}

	public void saveTicket(Ticket ticket) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			// start a transaction
			transaction = session.beginTransaction();

			session.save(ticket);
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
	}

	public List getTicketsByUserDao(User user) {

		// Think how to join with user Table here to get the User who created the ticket
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		List allTickets = null;
		List currentUserTickets = null;
		List assignedTickets = null;

		try {

			// start a transaction
			transaction = session.beginTransaction();
			if (user.getEtat() == 2) {
				Query query = session.createQuery(
						"SELECT T.id, T.Objet, T.Details, T.Etat,T.Severity, T.createDateTime, T.user, T.Attachment FROM Ticket T WHERE T.user= :user")
						.setParameter("user", user);
				allTickets = query.list();
				// commit transaction
				transaction.commit();

			} else if (user.getEtat() == 1) {
				Query query = session.createQuery(
						"SELECT T.id, T.Objet, T.Details, T.Etat,T.Severity, T.createDateTime, T.user,T.Attachment FROM Ticket T ");
				allTickets = query.list();
				// commit transaction
				transaction.commit();
			} else {
				Query query = session.createQuery(
						"SELECT  T.id, T.Objet, T.Details, T.Etat,T.Severity, T.createDateTime, T.user,T.Attachment FROM Ticket T, TicketUser TU"
								+ " WHERE (T.ticket_id= TU.ticket_id AND T.AssignedTo= :username)");
				query.setParameter("username", user.getUsername());
				assignedTickets = query.list();

				query = session.createQuery(
						"SELECT  T.id, T.Objet, T.Details, T.Etat,T.Severity, T.createDateTime, T.user,T.Attachment FROM Ticket T"
								+ " WHERE T.user= :user");
				query.setParameter("user", user);
				currentUserTickets = query.list();

				// commit transaction
				transaction.commit();

				allTickets = (List) Stream.concat(assignedTickets.stream(), currentUserTickets.stream())
						.collect(Collectors.toList());

			}

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		} finally {
			session.close();
		}

		return allTickets;

	}

	public List getAllTicketsDao() {

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		List allTickets = null;

		try {

			// start a transaction
			transaction = session.beginTransaction();

			Query query = session.createQuery(
					"SELECT T.id, T.Objet, T.Details, T.Etat,T.Severity, T.createDateTime,T.AssignedTo,T.ClosedBy FROM Ticket T");
			allTickets = query.list();
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

		return allTickets;

	}

	public Ticket getTicketById(String ticketId) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		Ticket ticket = null;
		try {
			// start a transaction
			transaction = session.beginTransaction();

			ticket = (Ticket) session.get(Ticket.class, Integer.parseInt(ticketId));

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		} finally {
			session.close();
		}
		return ticket;
	}

	public boolean updateTicketDao(Ticket ticket) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		int result = 0;

		try {
			// start a transaction
			transaction = session.beginTransaction();
			if (ticket.getAttachment() != null) {
				String updateticket = "UPDATE Ticket T set T.Objet= :objet, T.Details= :detail, T.Etat= :etat, T.Severity= :severity, T.user= :user,T.ClosedBy= :ClosedBy ,T.Attachment= :attachment WHERE ticket_id= :ticketId";
				Query query = session.createQuery(updateticket);
				query.setParameter("objet", ticket.getObjet());
				query.setParameter("detail", ticket.getDetails());
				query.setParameter("etat", ticket.getEtat());
				query.setParameter("severity", ticket.getSeverity());
				query.setParameter("user", ticket.getUser());
				query.setParameter("ticketId", ticket.getTicket_id());
				query.setParameter("ClosedBy", ticket.getClosedBy());
				query.setParameter("attachment", ticket.getAttachment());

				result = query.executeUpdate();

			} else {
				String updateticket = "UPDATE Ticket T set T.Objet= :objet, T.Details= :detail, T.Etat= :etat, T.Severity= :severity, T.user= :user,T.ClosedBy= :ClosedBy WHERE ticket_id= :ticketId";
				Query query = session.createQuery(updateticket);
				query.setParameter("objet", ticket.getObjet());
				query.setParameter("detail", ticket.getDetails());
				query.setParameter("etat", ticket.getEtat());
				query.setParameter("severity", ticket.getSeverity());
				query.setParameter("user", ticket.getUser());
				query.setParameter("ticketId", ticket.getTicket_id());
				query.setParameter("ClosedBy", ticket.getClosedBy());

				result = query.executeUpdate();

			}

			if (result != 0) {
				// commit transaction
				transaction.commit();
				return true;
			}

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

		return false;

	}

	public List filtreTicketDao(String filtre, User user) {

		// Think how to join with user Table here to get the User who created the ticket
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		List filtreTickets = null;

		try {

			// start a transaction
			transaction = session.beginTransaction();

			if (user.getEtat() == 1) {
				Query query = session.createQuery(
						"SELECT T.id, T.Objet, T.Details, T.Etat,T.Severity, T.createDateTime, T.user,T.Attachment FROM Ticket T WHERE T.Etat= :filtre");
				query.setParameter("filtre", filtre);
				filtreTickets = query.list();
				// commit transaction
				transaction.commit();

			} else if (user.getEtat() == 2) {
				Query query = session.createQuery(
						"SELECT T.id, T.Objet, T.Details, T.Etat,T.Severity, T.createDateTime, T.user,T.Attachment FROM Ticket T WHERE T.Etat= :filtre and T.user= :user ");
				query.setParameter("filtre", filtre);
				query.setParameter("user", user);
				filtreTickets = query.list();
				// commit transaction
				transaction.commit();

			} else {

				Query query = session.createQuery(
						"SELECT  T.id, T.Objet, T.Details, T.Etat,T.Severity, T.createDateTime, T.user,T.Attachment FROM Ticket T, TicketUser TU"
								+ " WHERE (T.Etat= :filtre AND T.ticket_id= TU.ticket_id AND T.AssignedTo= :username)");
				query.setParameter("username", user.getUsername());
				query.setParameter("filtre", filtre);
				List assignedTickets = query.list();

				query = session.createQuery(
						"SELECT  T.id, T.Objet, T.Details, T.Etat,T.Severity, T.createDateTime, T.user,T.Attachment FROM Ticket T"
								+ " WHERE T.Etat= :filtre AND T.user= :user");
				query.setParameter("user", user);
				query.setParameter("filtre", filtre);
				List currentUserTickets = query.list();

				// commit transaction
				transaction.commit();

				filtreTickets = (List) Stream.concat(assignedTickets.stream(), currentUserTickets.stream())
						.collect(Collectors.toList());

			}

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		} finally {
			session.close();
		}

		return filtreTickets;
	}

	public boolean deleteTicketDao(String ticket_id) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		EntityManager em = session.getEntityManagerFactory().createEntityManager();
		boolean ticketRemoved = false;
		try {
			em.getTransaction().begin();
			Ticket ticketToDelete = em.find(Ticket.class, Integer.parseInt(ticket_id));

			String deleteAssociatedResponses = "DELETE FROM responses WHERE ticket_id = :ticketId";
			Query query = (Query) em.createNativeQuery(deleteAssociatedResponses);
			query.setParameter("ticketId", ticketToDelete.getId());
			query.executeUpdate();

			String deleteAssigned = "DELETE FROM ticket_user WHERE ticket_id = :ticketId";
			query = (Query) em.createNativeQuery(deleteAssigned);
			query.setParameter("ticketId", ticketToDelete.getId());
			query.executeUpdate();

			String deletePlanif = "DELETE FROM planification WHERE ticket_id = :ticketId";
			query = (Query) em.createNativeQuery(deletePlanif);
			query.setParameter("ticketId", ticketToDelete.getId());
			query.executeUpdate();

			if (ticketToDelete.getAttachment() != null) {
				try {
					File f = new File(ticketToDelete.getAttachment());
					f.delete();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			em.remove(ticketToDelete);
			// commit EntityManager Transaction
			em.getTransaction().commit();
			ticketRemoved = true;

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			session.close();
		}
		return ticketRemoved;
	}

	public void updateTicketStatus(Ticket ticket) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		// start a transaction
		transaction = session.beginTransaction();
		String updateTicketStatus = "UPDATE Ticket T set T.Etat= :etat WHERE ticket_id= :ticketId";
		Query query = session.createQuery(updateTicketStatus);
		query.setParameter("etat", ticket.getEtat());
		query.setParameter("ticketId", ticket.getTicket_id());
		query.executeUpdate();
		// commit transaction
		transaction.commit();

	}

}
