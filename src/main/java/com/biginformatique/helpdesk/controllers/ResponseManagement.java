package com.biginformatique.helpdesk.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biginformatique.helpdesk.dao.ResponseDao;
import com.biginformatique.helpdesk.dao.SettingsDao;
import com.biginformatique.helpdesk.dao.TicketDao;
import com.biginformatique.helpdesk.dao.UserDao;
import com.biginformatique.helpdesk.models.MailingAttachSettings;
import com.biginformatique.helpdesk.models.Response;
import com.biginformatique.helpdesk.models.Ticket;
import com.biginformatique.helpdesk.models.User;
import com.biginformatique.helpdesk.util.EmailUtility;
import com.biginformatique.helpdesk.util.EncryptDecryptPassword;

import top.jfunc.json.impl.JSONObject;

@WebServlet("/ResponseManagement")
public class ResponseManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TicketDao ticketDao;
	private ResponseDao responseDao;
	private UserDao userDao;
	private SettingsDao settingsDao;
	private String host;
	private String smtp;
	private String port;
	private String email;
	private String name;
	private String pass;
	private EncryptDecryptPassword decryptPassword;

	public ResponseManagement() {
		super();

	}

	public void init(ServletConfig config) throws ServletException {
		ticketDao = new TicketDao();
		responseDao = new ResponseDao();
		userDao = new UserDao();
		settingsDao = new SettingsDao();
		try {
			decryptPassword = new EncryptDecryptPassword();
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		switch (action) {
		case "/getResponses":
			try {
				getResponseByTicketId(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			break;

		default:
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		switch (action) {
		case "/CreateResponse":
			saveResponse(request, response);

			break;

		default:
			break;
		}

	}

	private void saveResponse(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String responseDetail = request.getParameter("response");
		String ticketId = request.getParameter("ticket_id");
		String username = request.getParameter("usersession");
		Ticket ticket = null;
		User user = null;
		MailingAttachSettings settings = null;
		user = userDao.getUserByUsername(username);
		Response resp = new Response();
		ticket = ticketDao.getTicketById(ticketId);
		resp.setResponse(responseDetail);
		resp.setTicket(ticket);
		resp.setUser(user);

		// Send email notification to the user who had been assigned the ticket
		String subject = "Nouvelle Réponse";
		// Add more info to the content such Ticket number software in question ...
		String content = "Bonjour,<br><br>Une nouvelle réponse a été ajouter pour le Tiquet N°=" + ticketId
				+ ", de la part du Client: @"+username+". Merci d'en jeter un oeil";
		content += "<br><br>Cordialement.";

		// reads SMTP server setting from DB
		settings = settingsDao.getInitialSettingsDao();
		host = settings.getHost();
		smtp = settings.getSmtp();
		port = settings.getPort();
		email = settings.getEmail();
		name = settings.getNom();
		pass = settings.getPassword();
		pass = decryptPassword.decrypt(pass);

		if (responseDao.saveResponse(resp)) {
			// Send Email Notification to the Ticket Creator here
			try {
				// get user who create the ticket
				User ticketCreator=userDao.getUserById(ticket.getUser().getUser_id());
				String recipientCreator=ticketCreator.getEmail();
				EmailUtility.sendEmail(smtp, port, email, name, pass, recipientCreator, subject, content);
			} catch (Exception e) {

				e.printStackTrace();
			}
			if (ticket.getAssignedTo()!=null) {
				
				// Send Email Notification to the Assigned User here
				try {
					User userAssigned=userDao.getUserByUsername(ticket.getAssignedTo());
					String recipientAssigned=userAssigned.getEmail();
					EmailUtility.sendEmail(smtp, port, email, name, pass, recipientAssigned, subject, content);
				} catch (Exception e) {

					e.printStackTrace();
				}
				
			} 
			JSONObject jo = new JSONObject();
			jo.put("success", "true");
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jo.toString());

		}else {
			JSONObject jo = new JSONObject();
			jo.put("success", "false");
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jo.toString());		
		}

	}

	private void getResponseByTicketId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String ticketId = request.getParameter("ticket_id");
		Ticket ticket = null;
		ticket = ticketDao.getTicketById(ticketId);
		List Responses = responseDao.getResponseByTicket(ticket);

		JSONObject jo = new JSONObject();
		jo.put("responses", Responses);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jo.toString());

	}

}
