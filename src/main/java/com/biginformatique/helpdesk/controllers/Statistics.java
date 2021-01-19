package com.biginformatique.helpdesk.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biginformatique.helpdesk.dao.PlanificationsDao;
import com.biginformatique.helpdesk.dao.StatisticsDao;
import com.biginformatique.helpdesk.dao.TicketDao;
import com.biginformatique.helpdesk.dao.TicketUserDao;
import com.biginformatique.helpdesk.dao.UserDao;

import top.jfunc.json.impl.JSONObject;

@WebServlet("/Statistics")
public class Statistics extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TicketDao ticketDao;
	private TicketUserDao ticketuserDao;
	private UserDao userDao;
	private PlanificationsDao planifDao;
	private StatisticsDao statisticsDao;

	public Statistics() {
		super();

	}

	public void init(ServletConfig config) throws ServletException {
		ticketDao = new TicketDao();
		ticketuserDao = new TicketUserDao();
		userDao = new UserDao();
		planifDao = new PlanificationsDao();
		statisticsDao = new StatisticsDao();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		switch (action) {
		case "/getNumberTickets":
			try {
				getNumberTickets(request, response);
			} catch (Exception e) {

				e.printStackTrace();
			}

			break;

		case "/getNumTicByVersion":
			try {
				getNumTicByVersion(request, response);
			} catch (Exception e) {

				e.printStackTrace();
			}

			break;

		}

	}

	private void getNumTicByVersion(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String logicielId = request.getParameter("logiciel_id");
		String versionId = request.getParameter("version_id");
		int[] nbrTickets = statisticsDao.getNumTicByVersionDao(logicielId, versionId);
		JSONObject jo = new JSONObject();
		jo.put("nbrTickets", nbrTickets);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jo.toString());

	}

	private void getNumberTickets(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int[] nbrTickets = statisticsDao.getNumberTicketsDao();
		JSONObject jo = new JSONObject();
		jo.put("nbrTickets", nbrTickets);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jo.toString());

	}

}
