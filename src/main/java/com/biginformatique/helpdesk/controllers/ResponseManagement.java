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
import com.biginformatique.helpdesk.dao.TicketDao;
import com.biginformatique.helpdesk.dao.UserDao;
import com.biginformatique.helpdesk.models.Response;
import com.biginformatique.helpdesk.models.Ticket;
import com.biginformatique.helpdesk.models.User;

import top.jfunc.json.impl.JSONObject;

@WebServlet("/ResponseManagement")
public class ResponseManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TicketDao ticketDao;
	private ResponseDao responseDao;
	private UserDao userDao;
       
   
    public ResponseManagement() {
        super();
       
    }

	
	public void init(ServletConfig config) throws ServletException {
		ticketDao = new TicketDao();
		responseDao= new ResponseDao();
		userDao=new UserDao();
		
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
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

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		switch (action) {
		case "/CreateResponse":
			saveResponse(request, response);
			
			break;

		default:
			break;
		}
		
	}
	

	private void saveResponse(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String responseDetail=request.getParameter("response");
		String ticketId=request.getParameter("ticket_id");
		String username=request.getParameter("usersession");
		Ticket ticket=null;
		User user=null;
		user=userDao.getUserByUsername(username);
		Response resp= new Response();
		ticket=ticketDao.getTicketById(ticketId);
		resp.setResponse(responseDetail);
		resp.setTicket(ticket);
		resp.setUser(user);
		responseDao.saveResponse(resp);
		JSONObject jo = new JSONObject();
		jo.put("success", "true");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jo.toString());
		
		
		
		
	}

	private void getResponseByTicketId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String ticketId=request.getParameter("ticket_id");
		Ticket ticket=null;
		ticket=ticketDao.getTicketById(ticketId);
		List Responses = responseDao.getResponseByTicket(ticket);

		JSONObject jo = new JSONObject();
		jo.put("responses", Responses);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jo.toString());
		
	}

}
