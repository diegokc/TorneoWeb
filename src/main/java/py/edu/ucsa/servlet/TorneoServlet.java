package py.edu.ucsa.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import py.edu.ucsa.ejb.dto.*;
import py.edu.ucsa.ejb.session.*;

import py.edu.ucsa.ejb.session.EquipoEjbRemote;

@WebServlet(description = "Primer servlet", urlPatterns = { "/TorneoServlet" })
public class TorneoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB(mappedName = "java:global/TorneoEjbApp/EquipoEjbImpl!py.edu.ucsa.ejb.session.EquipoEjbRemote")
	private TorneoEjbRemote ejbTorneo;
	
	private List<TorneoDTO>  torneoList;
	
    public TorneoServlet() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(true);
		Cookie rcookie[] = request.getCookies();
		
		if (Objects.isNull(request.getParameter("ACCION")) || "".equals(request.getParameter("ACCION"))
				|| "LISTAR".equals(request.getParameter("ACCION"))) {

			System.out.println("ACCION=LISTAR TORNEO");

			torneoList = ejbTorneo.listar();

			System.out.println(torneoList.toString());

			// EquiposDTO e =
			request.getSession().setAttribute("TORNEOS", torneoList);

			request.getRequestDispatcher("torneos-listar.jsp").forward(request, response);
		}
	}



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
