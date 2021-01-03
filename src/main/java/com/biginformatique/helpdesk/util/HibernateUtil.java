package com.biginformatique.helpdesk.util;

import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import com.biginformatique.helpdesk.models.Contact;
import com.biginformatique.helpdesk.models.MailingAttachSettings;
import com.biginformatique.helpdesk.models.Planification;
import com.biginformatique.helpdesk.models.Response;
import com.biginformatique.helpdesk.models.Ticket;
import com.biginformatique.helpdesk.models.TicketUser;
import com.biginformatique.helpdesk.models.User;

public class HibernateUtil {

	private static SessionFactory sessionFactory;

	public static SessionFactory getSessionFactory() {
		if (sessionFactory == null) {
			try {
				Configuration configuration = new Configuration();

				// Hibernate settings equivalent to hibernate.cfg.xml's properties
				Properties settings = new Properties();
				settings.put(Environment.DRIVER, "com.mysql.jdbc.Driver");
				settings.put(Environment.URL,
						"jdbc:mysql://localhost:3307/helpdesk?allowPublicKeyRetrieval=true&useSSL=false&useTimezone=true&serverTimezone=GMT%2B1&useLegacyDatetimeCode=false&useUnicode=true&characterEncoding=utf8");
				settings.put(Environment.USER, "root");
				settings.put(Environment.PASS, "root");
				settings.put(Environment.DIALECT, "org.hibernate.dialect.MySQL8Dialect");

				settings.put(Environment.SHOW_SQL, "true");

				settings.put(Environment.CURRENT_SESSION_CONTEXT_CLASS, "thread");

				settings.put(Environment.HBM2DDL_AUTO, "update");

				configuration.setProperties(settings);
				configuration.addAnnotatedClass(User.class);
				configuration.addAnnotatedClass(Ticket.class);
				configuration.addAnnotatedClass(Response.class);
				configuration.addAnnotatedClass(TicketUser.class);
				configuration.addAnnotatedClass(Planification.class);
				configuration.addAnnotatedClass(Contact.class);
				configuration.addAnnotatedClass(MailingAttachSettings.class);

				ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
						.applySettings(configuration.getProperties()).build();
				System.out.println("Hibernate Java Config serviceRegistry created");
				sessionFactory = configuration.buildSessionFactory(serviceRegistry);
				return sessionFactory;

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return sessionFactory;
	}

}
