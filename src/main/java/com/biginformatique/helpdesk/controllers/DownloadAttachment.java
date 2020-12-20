package com.biginformatique.helpdesk.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Optional;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biginformatique.helpdesk.dao.SettingsDao;
import com.biginformatique.helpdesk.models.MailingAttachSettings;

@WebServlet("/DownloadAttachment")
public class DownloadAttachment extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final int ARBITARY_SIZE = 1048;
	private SettingsDao settingsDao;

	public DownloadAttachment() {
		super();

	}
	public void init(ServletConfig config) throws ServletException {
		settingsDao = new SettingsDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getParameter("path");
		MailingAttachSettings mailingAttachSettings=null;
		mailingAttachSettings=settingsDao.getInitialSettingsDao();
		String SAVE_DIR=mailingAttachSettings.getAttchpath();

		// Fetch File name from path and Then depending on the File extension choose
		// which ContentType using Switch structure
		Path p = Paths.get(path);
		String fileName = p.getFileName().toString();
		Optional<String> fileExtension = Optional.ofNullable(fileName).filter(f -> f.contains("."))
				.map(f -> f.substring(fileName.lastIndexOf(".") + 1));

		/// Set ContentType of the HTTP header depending on the File
		/// Extensions
		switch (fileExtension.orElseGet(null).toLowerCase()) {
			case "txt":
				response.setContentType("text/plain");
				break;
			case "pdf":
				response.setContentType("application/pdf");
				break;
			case "doc":
				response.setContentType("application/msword");
				break;
			case "docx":
				response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
				break;
			case "xlsx":
				response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
				break;
			case "zip":
				response.setContentType("application/zip");
				break;
			case "jpeg":
				response.setContentType("image/jpeg");
				break;
			case "png":
				response.setContentType("image/png");
				break;
			case "rar":
				response.setContentType("application/x-rar-compressed");
				break;
	
			default:
				break;
		}

		response.setHeader("Content-disposition", "attachment; filename=" + fileName);
		
		 try(InputStream in = new FileInputStream(SAVE_DIR+File.separator+fileName);
		          OutputStream out = response.getOutputStream()) {

			byte[] buffer = new byte[ARBITARY_SIZE];

			int numBytesRead;
			while ((numBytesRead = in.read(buffer)) > 0) {
				out.write(buffer, 0, numBytesRead);
			}
		}
	}

}
