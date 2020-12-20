package com.biginformatique.helpdesk.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biginformatique.helpdesk.dao.ContactsDao;
import com.biginformatique.helpdesk.models.Contact;

import top.jfunc.json.impl.JSONObject;

@WebServlet("/Contacts")
public class Contacts extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ContactsDao contactDao;
       
    
    public Contacts() {
        super();
       
    }

	
	public void init(ServletConfig config) throws ServletException {
		contactDao= new ContactsDao();
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		switch (action) {
		case "/getContacts":
			try {
				getContacts(request,response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;

		default:
			break;
		}
	}

	
	private void getContacts(HttpServletRequest request, HttpServletResponse response) throws Exception   {
		List allContacts = contactDao.getContactsDao();

		JSONObject jo = new JSONObject();
		jo.put("contacts", allContacts);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jo.toString());
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action= request.getParameter("action");
		switch (action) {
		case "/SaveContact":
			try {
				saveContact(request,response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		case "/DeleteContact":
			try {
				deleteContact(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			break;

		default:
			break;
		}
	}


	private void deleteContact(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject jo = new JSONObject();
		String contact_id = request.getParameter("contact_id");
		if (contactDao.deleteContactDao(contact_id)) {
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


	private void saveContact(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String Nom= request.getParameter("nom");
		String Email= request.getParameter("email");
		String objet= request.getParameter("objet");
		String message= request.getParameter("message");
		Contact contact= new Contact();
		JSONObject jo = new JSONObject();
		
		contact.setNom(Nom);;
		contact.setEmail(Email);
		contact.setObjet(objet);
		contact.setMessage(message);
		
		if (contactDao.saveContactDao(contact)) {
//			jo.put("success", "true");
//			response.setContentType("application/json");
//			response.setCharacterEncoding("UTF-8");
//			response.getWriter().write(jo.toString());
			response.sendRedirect("index.jsp");
		}else {
//			jo.put("success", "false");
//			response.setContentType("application/json");
//			response.setCharacterEncoding("UTF-8");
//			response.getWriter().write(jo.toString());
		}
		

		
	}

}
