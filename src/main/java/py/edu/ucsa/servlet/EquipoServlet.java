package py.edu.ucsa.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import py.edu.ucsa.ejb.entities.Equipo;

/**
 * Servlet implementation class EquipoServlet
 */
@WebServlet(description = "Primer servlet", urlPatterns = { "/EquipoServlet" })
public class EquipoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	List<Equipo> equipos;

	public EquipoServlet() {
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession(true);
		
		if (!Objects.isNull(request.getSession().getAttribute("EQUIPOS"))) {
			equipos = (List<Equipo>) request.getSession().getAttribute("EQUIPOS");
		}
		//request.getSession().setAttribute("EQUIPOS", equipos);

		if (Objects.isNull(request.getParameter("ACCION")) || "".equals(request.getParameter("ACCION"))
				|| "LISTAR".equals(request.getParameter("ACCION"))) {

			request.getRequestDispatcher("equipos-listar.jsp").forward(request, response);
		} else if ("NUEVO".equals(request.getParameter("ACCION"))) {

			request.getRequestDispatcher("equipos-abm.jsp").forward(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(true);
		Cookie rcookie[] = request.getCookies();
		Integer maxreco = 86400;
		
		if ("ACTUALIZAR".equals(request.getParameter("ACCION"))) {
			System.out.println("ACTUALIZAR OPCION");
			Integer id = 0;
			
			if(!Objects.isNull(request.getSession().getAttribute("EQUIPOS"))) {
				equipos = (List<Equipo>)request.getSession().getAttribute("EQUIPOS");
			} else {
				response.sendRedirect("EquipoServlet?ACCION=LISTAR");
			}
			
			if(Objects.isNull(request.getParameter("id"))) {
				id=Integer.getInteger(request.getParameter("id"));				
			}
			
			for(Equipo eq : equipos) {
				if(id.equals( eq.getId() )){
					eq.setNombre( )
				}
			}

			Equipo op = new Equipo();
			op.setId(idEquipo);
			op.setNombre(request.getParameter("codigo"));
			op.setSlogan(request.getParameter("slogan"));
			
			equipos.add(op);

			request.getSession().setAttribute("EQUIPOS", equipos);
			request.getSession().setMaxInactiveInterval(maxreco * 30);

			doGet(request, response);
		} else if ("INSERTAR".equals(request.getParameter("ACCION"))) {
			System.out.println("INSERTAR EQUIPO");
			Integer idEquipo=0;
			if(!Objects.isNull(request.getSession().getAttribute("EQUIPOS"))) {
				equipos = (List<Equipo>)request.getSession().getAttribute("EQUIPOS");
				idEquipo = equipos.size();
				idEquipo ++;
			} else {
				equipos = new ArrayList<Equipo>();
				idEquipo=1;
			}
			
		
			Equipo op = new Equipo();
			op.setId(idEquipo);
			op.setNombre(request.getParameter("codigo"));
			op.setSlogan(request.getParameter("slogan"));
			
			equipos.add(op);

			request.getSession().setAttribute("EQUIPOS", equipos);
			request.getSession().setMaxInactiveInterval(maxreco * 30);
			
			System.out.println("equipo insertado");
			
			doGet(request, response);
		}
		
	}
}
