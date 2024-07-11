package py.edu.ucsa.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class HolaDiplo
 */
@WebServlet(
		description = "Primer servlet", 
		urlPatterns = { 
				   "/HolaDiplo", 
				   "/PrimerServlet"
				})
public class HolaDiplo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HolaDiplo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if(request.getParameter("bstheme")!=null && request.getParameter("bstheme")!="") {
			Integer maxreco = 86400;
			Cookie cc_bstheme = new Cookie("bstheme", request.getParameter("bstheme"));
			cc_bstheme.setMaxAge(maxreco * 15);
			response.addCookie(cc_bstheme);

			PrintWriter pw = response.getWriter();
			pw.print("<html>\r\n"
					+ "<body>\r\n"
					+ "<h2>Hola Dplo! " + request.getParameter("bstheme") + "</h2>\r\n"
					+ "</body>\r\n"
					+ "</html>\r\n"
					+ "");
		} else {
		
		PrintWriter pw = response.getWriter();
		pw.print("<html>\r\n"
				+ "<body>\r\n"
				+ "<h2>Hola Dplo!</h2>\r\n"
				+ "</body>\r\n"
				+ "</html>\r\n"
				+ "");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
