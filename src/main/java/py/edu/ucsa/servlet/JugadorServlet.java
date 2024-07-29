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
import py.edu.ucsa.sutiles.Utiles;

@WebServlet(description = "Primer servlet", urlPatterns = { "/JugadorServlet" })
public class JugadorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// @EJB(mappedName =
	// "java:global/CambistaEjbApp/CambistaEjbImpl!py.edu.ucsa.cambista.ejb.session.CambistaEjbRemote")
	@EJB(mappedName = "java:global/TorneoEjbApp/EquipoEjbImpl!py.edu.ucsa.ejb.session.EquipoEjbRemote")
	private EquipoEjbRemote ejbEquipo;

	@EJB(mappedName = "java:global/TorneoEjbApp/JugadorEjbImpl!py.edu.ucsa.ejb.session.JugadorEjbRemote")
	private JugadorEjbRemote ejbJugador;

	private List<JugadorDTO> jugadorList;

	public JugadorServlet() {
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(true);
		Cookie rcookie[] = request.getCookies();

		if (Objects.isNull(request.getParameter("ACCION")) || "".equals(request.getParameter("ACCION"))
				|| "LISTAR".equals(request.getParameter("ACCION"))) {

			System.out.println("ACCION=LISTAR JUGADOR");

			jugadorList = ejbJugador.listar();

			System.out.println(jugadorList.toString());

			// EquiposDTO e =
			request.getSession().setAttribute("JUGADORES", jugadorList);

			request.getRequestDispatcher("jugadores-listar.jsp").forward(request, response);
		} else if ("BUSCAR".equals(request.getParameter("ACCION"))) {
			
			System.out.println("ACCION=BUSCAR");
			request.getSession().setAttribute("JUGADORES", null);
			boolean rt = true;
			jugadorList = ejbJugador.findByNombre( request.getParameter("qnombre").trim() , rt);
			if(jugadorList.size()>0) {
				// EquiposDTO e =
				request.getSession().setAttribute("JUGADORES", jugadorList);
				
				request.getRequestDispatcher("jugadores-listar.jsp").forward(request, response);
			} else {
				request.getSession().setAttribute("JUGADORES", null);
				
				request.getRequestDispatcher("jugadores-listar.jsp").forward(request, response);
			}
		} else if ("NUEVO".equals(request.getParameter("ACCION"))) {

			request.getSession().setAttribute("JUGADOR", null);
			
			request.getRequestDispatcher("jugadores-abm.jsp").forward(request, response);
		} else if ("EDITAR".equals(request.getParameter("ACCION"))) {
			Integer id = Utiles.valInteger(request.getParameter("id"));
			if (id > 0) {

				JugadorDTO jd = ejbJugador.getById(id);
				request.getSession().setAttribute("JUGADOR", jd);
				request.getRequestDispatcher("jugadores-abm.jsp").forward(request, response);
			}
		} else  if ("RESCINDIR".equals(request.getParameter("ACCION"))) {

			Integer id = Utiles.valInteger(request.getParameter("id"));
			if (id > 0) {

				JugadorDTO jd = ejbJugador.getById(id);
				if(!Objects.isNull( jd.getEquipo() ) ) {
					if( !Objects.isNull( jd.getEquipo().getCapitan() ) ) {
						if(jd.getId().equals( jd.getEquipo().getCapitan().getId() )) {
							EquipoDTO ed = jd.getEquipo();
							ed.setCapitan(null);
							ejbEquipo.actualizar(ed);
						}
					}
					
					
					jd.setEquipo(null);
					ejbJugador.actualizar(jd);
					
					response.sendRedirect("JugadorServlet?STATUS=RESC_SUCCES");
				} else {
					response.sendRedirect("JugadorServlet?STATUS=RESC_REJECT");
				}
			}
			
			

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(true);
		Cookie rcookie[] = request.getCookies();
		Integer maxreco = 86400;
		
		

		if (Objects.isNull(request.getParameter("ACCION")) || "INSERTAR".equals(request.getParameter("ACCION"))) {

			JugadorDTO jd = new JugadorDTO();
			jd.setNombres(request.getParameter("nombres").trim());
			jd.setApellidos(request.getParameter("apellidos").trim());

			jd.setNroFicha(Utiles.valLong(request.getParameter("nroFicha")));

			jd.setFechaDeNacimiento(request.getParameter("fechaDeNacimiento"));

			jd.setEmail(request.getParameter("email").trim());

			jd.setNacionalidad(request.getParameter("nacionalidad").trim());

			jd.setTelefono(request.getParameter("telefono").trim());

			jd = ejbJugador.insertar(jd);

			request.getSession().setAttribute("JUGADOR", jd);

			// request.getRequestDispatcher("jugadores-abm.jsp?STATUS=SUCCES&ACCION=EDITAR").forward(request,
			// response);
			response.sendRedirect("JugadorServlet?STATUS=SUCCES&ACCION=EDITAR&id=" + jd.getId().toString());

		} else if ("ACTUALIZAR".equals(request.getParameter("ACCION"))) {

			JugadorDTO jd = (JugadorDTO) request.getSession().getAttribute("JUGADOR");

			jd.setNombres(request.getParameter("nombres").trim());
			jd.setApellidos(request.getParameter("apellidos").trim());
			jd.setNroFicha(Utiles.valLong(request.getParameter("nroFicha")));
			jd.setFechaDeNacimiento(request.getParameter("fechaDeNacimiento"));
			jd.setEmail(request.getParameter("email").trim());
			jd.setNacionalidad(request.getParameter("nacionalidad").trim());
			jd.setTelefono(request.getParameter("telefono").trim());

			ejbJugador.actualizar(jd);

			request.getSession().setAttribute("JUGADOR", jd);

			response.sendRedirect("JugadorServlet?STATUS=EDIT_SUCCES&ACCION=EDITAR&id=" + jd.getId().toString());

		} else if ("ELIMINAR".equals(request.getParameter("ACCION"))) {
			String[] checkboxNamesList = request.getParameterValues("jugadoresid");
			if(!Objects.isNull( checkboxNamesList )) {
	
				for (int i = 0; i < checkboxNamesList.length; i++) {
					String myCheckBoxValue = checkboxNamesList[i];
					if (myCheckBoxValue != null) {
						// eliminar si es capitan
						ejbJugador.eliminar(Utiles.valInteger(myCheckBoxValue));
					}
				}
	
				response.sendRedirect("JugadorServlet?STATUS=DEL_SUCCES");
			} else {
				response.sendRedirect("JugadorServlet?STATUS=DEL_REJECT");
			}

		}
	
	}

}
