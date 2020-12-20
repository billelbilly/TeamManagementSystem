package com.biginformatique.helpdesk.controllers;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;

import com.biginformatique.helpdesk.dao.SettingsDao;
import com.biginformatique.helpdesk.dao.UserDao;
import com.biginformatique.helpdesk.models.MailingAttachSettings;
import com.biginformatique.helpdesk.models.User;
import com.biginformatique.helpdesk.util.EmailUtility;
import com.biginformatique.helpdesk.util.EncryptDecryptPassword;

import top.jfunc.json.impl.JSONObject;

@WebServlet("/ResetPassword")
public class ResetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String host;
	private String smtp;
	private String port;
	private String email;
	private String name;
	private String pass;
	private UserDao userDao;
	private SettingsDao settingsDao;
	private EncryptDecryptPassword decryptPassword;

	public ResetPassword() {
		super();

	}

	public void init(ServletConfig config) throws ServletException {

		userDao = new UserDao();
		settingsDao = new SettingsDao();
		try {
			decryptPassword= new EncryptDecryptPassword();
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		switch (action) {
		case "/UpdatePassword":
			try {
				resetPage(request, response);
			} catch (Exception e) {

				e.printStackTrace();
			}
			break;
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		switch (action) {
		case "/SendLink":
			try {
				SendLink(request, response);
			} catch (Exception e) {

				e.printStackTrace();
			}
			break;
		case "/UpdatePassword":
			try {
				resetUserPasswordInDb(request, response);
			} catch (Exception e) {

				e.printStackTrace();
			}
			break;

		default:
			break;
		}

	}

	private void resetUserPasswordInDb(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String email = request.getParameter("email");
		String password = request.getParameter("password");
		User user = userDao.getUserByEmail(email);
		JSONObject jo = new JSONObject();

		if (userDao.updatePassword(user, userDao.hash(password))) {
			jo.put("success", "true");
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jo.toString());

		} else {
			jo.put("success", "false");
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jo.toString());

		}

	}

	public void resetPage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String email = request.getParameter("email");
		HttpSession session = request.getSession();
		session.setAttribute("email", email);
		// redirect to Update Password page here
		response.sendRedirect("ResetForm.jsp");

	}

	public void SendLink(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String recipient = request.getParameter("emailInput");
		String subject = "Récupération Mot de Passe";
		JSONObject jo = new JSONObject();
		MailingAttachSettings settings=null;
		User user = userDao.getUserByEmail(recipient);

		if (user != null) {
			
			// reads SMTP server setting from DB
			settings=settingsDao.getInitialSettingsDao();
			host = settings.getHost();
			smtp=settings.getSmtp();
			port = settings.getPort();
			email = settings.getEmail();
			name = settings.getNom();
			pass=settings.getPassword();
			//Decrypt password here
			pass = decryptPassword.decrypt(pass);
			
			// Send URL to Reset password from here
			String link = "<a href=\"http://"+host+"/Helpdesk/ResetPassword?email=" + recipient
					+ "&action=/UpdatePassword\">Changer Mot de Passe</a>";

//            String content = "Bonjour,<br><br> Votre nouveau Mot de Passe est: "
//            		+ "<form action=\"localhost:8080/Helpdesk/ResetPassword\" method=\"POST\">"
//            		+ "<input type=\"text\" name=\"email\" id=\"email\"	value=\""+recipient+"\" hidden=\"1\"/><input type=\"text\" name=\"action\" id=\"action\"value=\"//UpdatePassword\" hidden=\"1\"/>"
//            		+ "	<button type=\"submit\">Changer Password</button></form>" ;
//            content += "\nNote: pour des raisons de sécurité, "
//                    + "veuillez changé votre mot de passe après accès au système.";
			String content = "Bonjour,<br><br> Voici le lien pour changer votre mot de passe: " + link;
			content += "<br><br><strong>Note: Si cet Email ne vous concerne pas Merci de contacter l\'administrateur,</strong> "
					+ "<br><br>Cordialement.";

		

			try {
				EmailUtility.sendEmail(smtp, port, email, name, pass, recipient, subject, content);
				jo.put("success", "true");
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(jo.toString());

			} catch (Exception ex) {
				ex.printStackTrace();
				jo.put("success", "serverError");
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(jo.toString());

			}

		} else {
			jo.put("success", "false");
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jo.toString());

		}

	}

}
