package com.biginformatique.helpdesk.controllers;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biginformatique.helpdesk.dao.SettingsDao;
import com.biginformatique.helpdesk.dao.UserDao;
import com.biginformatique.helpdesk.models.Logiciel;
import com.biginformatique.helpdesk.models.MailingAttachSettings;
import com.biginformatique.helpdesk.models.Version;
import com.biginformatique.helpdesk.util.EncryptDecryptPassword;

import top.jfunc.json.impl.JSONObject;

@WebServlet("/Settings")
public class Settings extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SettingsDao settingsDao;
	private UserDao userDao;
	private EncryptDecryptPassword encryptPassword;

	public Settings() {
		super();

	}

	public void init(ServletConfig config) throws ServletException {
		settingsDao = new SettingsDao();
		userDao = new UserDao();
		try {
			encryptPassword = new EncryptDecryptPassword();
		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		switch (action) {
		case "/getInitialSettings":
			try {
				getInitialSettings(request, response);
			} catch (Exception e) {

				e.printStackTrace();
			}
			break;
			
		case "/getInitialSettingsList":
			try {
				getInitialSettingsList(request, response);
			} catch (Exception e) {

				e.printStackTrace();
			}
			break;

		default:
			break;
		}
	}

	private void getInitialSettings(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MailingAttachSettings settings = null;
		JSONObject jo = new JSONObject();
		settings = settingsDao.getInitialSettingsDao();
		jo.put("settings", settings);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jo.toString());

	}
	
	private void getInitialSettingsList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List settingsList=null;
		JSONObject jo = new JSONObject();
		settingsList = settingsDao.getSettingsListDao();	
		jo.put("settings", settingsList);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jo.toString());

	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		switch (action) {
		case "/MailSettings&Attachment":
			try {
				MailAttachSettings(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
			
		case "/EditMailSettings&Attachment":
			try {
				EditMailAttachSettings(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
			
		case "/Logiciel&Version":
			try {
				LogicielVersionSettings(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
			
		case "/Logiciel":
			try {
				LogicielSettings(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
			
		case "/Version":
			try {
				VersionSettings(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		default:
			break;
		}
	}

	private void VersionSettings(HttpServletRequest request, HttpServletResponse response) {
		settingsDao.VersionDao();
		
	}

	private void LogicielSettings(HttpServletRequest request, HttpServletResponse response) {
		settingsDao.LogicielDao();
		
	}

	private void LogicielVersionSettings(HttpServletRequest request, HttpServletResponse response) {
		String nomLogiciel=request.getParameter("listLogiciel");
		String nomVersion=request.getParameter("listVersion");
		
		
	}

	private void EditMailAttachSettings(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String settings_id = request.getParameter("settings_id");
		String host = request.getParameter("host");
		String smtp = request.getParameter("smtp");
		String port = request.getParameter("port");
		String email = request.getParameter("email");
		String nom = request.getParameter("nom");
		String password = request.getParameter("password");
		String attchpath = request.getParameter("attchpath");
		JSONObject jo = new JSONObject();
		MailingAttachSettings mailingAttachSettings = new MailingAttachSettings();
		mailingAttachSettings.setSetting_id(Integer.parseInt(settings_id));
		mailingAttachSettings.setHost(host);
		mailingAttachSettings.setSmtp(smtp);
		mailingAttachSettings.setPort(port);
		mailingAttachSettings.setEmail(email);
		mailingAttachSettings.setNom(nom);
		if(!password.equals("")) {
			password = encryptPassword.encrypt(password);
			// Encrypt password here before save it to database
			mailingAttachSettings.setPassword(password);
		}
		
		mailingAttachSettings.setAttchpath(attchpath);
		if(settingsDao.EditMailAttachSettingsDao(mailingAttachSettings)) {
		    jo.put("success", "true");
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jo.toString());		
		}else {
			jo.put("success", "false");
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jo.toString());		
			
		}
		
		
	}

	private void MailAttachSettings(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String host = request.getParameter("host");
		String smtp = request.getParameter("smtp");
		String port = request.getParameter("port");
		String email = request.getParameter("email");
		String nom = request.getParameter("nom");
		String password = request.getParameter("password");
		String attchpath = request.getParameter("attchpath");
		JSONObject jo = new JSONObject();
		MailingAttachSettings mailingAttachSettings = new MailingAttachSettings();
		

		mailingAttachSettings.setHost(host);
		mailingAttachSettings.setSmtp(smtp);
		mailingAttachSettings.setPort(port);
		mailingAttachSettings.setEmail(email);
		mailingAttachSettings.setNom(nom);
		password = encryptPassword.encrypt(password);
		// Encrypt password here before save it to database
		mailingAttachSettings.setPassword(password);
		mailingAttachSettings.setAttchpath(attchpath);

		if (settingsDao.saveMailingAttachSettings(mailingAttachSettings)) {
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

}
