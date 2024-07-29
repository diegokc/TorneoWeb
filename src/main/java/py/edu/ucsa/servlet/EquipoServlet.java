package py.edu.ucsa.servlet;

import java.io.IOException;
import java.util.ArrayList;
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
import py.edu.ucsa.ejb.dto.EquipoDTO;
import py.edu.ucsa.ejb.dto.JugadorDTO;
import py.edu.ucsa.ejb.session.EquipoEjbRemote;
import py.edu.ucsa.ejb.session.JugadorEjbRemote;
import py.edu.ucsa.sutiles.Utiles;


/**
 * Servlet implementation class EquipoServlet
 */
@WebServlet(description = "Primer servlet", urlPatterns = { "/EquipoServlet" })
public class EquipoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// @EJB(mappedName =
	// "java:global/CambistaEjbApp/CambistaEjbImpl!py.edu.ucsa.cambista.ejb.session.CambistaEjbRemote")
	@EJB(mappedName = "java:global/TorneoEjbApp/EquipoEjbImpl!py.edu.ucsa.ejb.session.EquipoEjbRemote")
	private EquipoEjbRemote ejbEquipo;

	@EJB(mappedName = "java:global/TorneoEjbApp/JugadorEjbImpl!py.edu.ucsa.ejb.session.JugadorEjbRemote")
	private JugadorEjbRemote ejbJugador;

	private List<EquipoDTO> equipoList;

	private List<JugadorDTO> jugadorList;

	public EquipoServlet() {
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(true);


		if (Objects.isNull(request.getParameter("ACCION")) || "".equals(request.getParameter("ACCION"))
				|| "LISTAR".equals(request.getParameter("ACCION"))) {
			
			System.out.println("ACCION=LISTAR EQUIPO");
			
			equipoList = ejbEquipo.listar();
			
			System.out.println( equipoList.toString() );
			
			// EquiposDTO e =
			request.getSession().setAttribute("EQUIPOS", equipoList);

			request.getRequestDispatcher("equipos-listar.jsp").forward(request, response);
		} else if ("BUSCAR".equals(request.getParameter("ACCION"))) {
				
			System.out.println("ACCION=BUSCAR");
			request.getSession().setAttribute("EQUIPOS", null);
			boolean rt = true;
			equipoList = ejbEquipo.findByNombre( request.getParameter("qnombre").trim() , rt);
			if(equipoList.size()>0) {
				// EquiposDTO e =
				request.getSession().setAttribute("EQUIPOS", equipoList);
				
				request.getRequestDispatcher("equipos-listar.jsp").forward(request, response);
			} else {
				request.getSession().setAttribute("EQUIPOS", null);
				
				request.getRequestDispatcher("equipos-listar.jsp").forward(request, response);
			}
		} else if ("NUEVO".equals(request.getParameter("ACCION"))) {

			request.getSession().setAttribute("JUGADORES", null);
			jugadorList = ejbJugador.listar();
			request.getSession().setAttribute("JUGADORES", jugadorList);
			
			request.getSession().setAttribute("EQUIPO", null);
			
			request.getRequestDispatcher("equipos-abm.jsp").forward(request, response);
		} else if ("EDITAR".equals(request.getParameter("ACCION"))) {
			
			Integer id = Utiles.valInteger(request.getParameter("id"));
			if (id > 0) {
				//traigo el equipo
				EquipoDTO ed = ejbEquipo.getById(id);
				
				//traigo la lista de jugador para la busqueda
				jugadorList = ejbJugador.listar();
				request.getSession().setAttribute("EQUIPO", ed);
				
				request.getRequestDispatcher("equipos-abm.jsp").forward(request, response);
			}
			
			request.getSession().setAttribute("JUGADORES", null);
			jugadorList = ejbJugador.listar();
			request.getSession().setAttribute("JUGADORES", jugadorList);
			
			request.getRequestDispatcher("equipos-abm.jsp").forward(request, response);
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

			EquipoDTO ed = new EquipoDTO();
			ed.setNombre( request.getParameter("nombre").trim() );
			ed.setSlogan( request.getParameter("slogan").trim() );
			
			ed = ejbEquipo.insertar(ed);
			
			String[] hiddenIdList = request.getParameterValues("hjid");

			if(!Objects.isNull(hiddenIdList)) {
				JugadorDTO jd;
				for (int i = 0; i < hiddenIdList.length; i++) {
					String hiddenIdValue = hiddenIdList[i];
					if (hiddenIdValue != null) {
						jd = null;
						jd =  ejbJugador.getById( Integer.parseInt(hiddenIdValue) );
						
						jd.setEquipo(ed);
						
						ejbJugador.actualizar(jd);
					}
				}
			}
			
			

			// request.getRequestDispatcher("jugadores-abm.jsp?STATUS=SUCCES&ACCION=EDITAR").forward(request,
			// response);
			response.sendRedirect("EquipoServlet?STATUS=SUCCES&ACCION=EDITAR&id="+ed.getId());

		} else if ("ACTUALIZAR".equals(request.getParameter("ACCION"))) {
			
			EquipoDTO ed =  (EquipoDTO) request.getSession().getAttribute("EQUIPO");
			ed.setNombre( request.getParameter("nombre").trim() );
			ed.setSlogan( request.getParameter("slogan").trim() );
			if(Objects.isNull(request.getParameter("capitanid"))) {
				ed.setCapitan(null);
			}
			
			ejbEquipo.actualizar(ed);
			
			String[] hiddenIdList = request.getParameterValues("hjid");
			String[] checkList = request.getParameterValues("chjid");

			
			JugadorDTO jd;
			
			//1 sacamos los jugadores marcados de la lista
			if(!Objects.isNull(checkList)) {
				for (int i = 0; i < checkList.length; i++) {
					
					String chkId = checkList[i];
					if (chkId != null) {
						jd = null;
						jd =  ejbJugador.getById( Integer.parseInt(chkId) );
						jd.setEquipo(null);
						ejbJugador.actualizar(jd);
					}
					
				}
			}
			int m20=20, mi20=0;
			//2 agregamos los que si se encuentran en la lista
			if(!Objects.isNull(hiddenIdList)) {
				for (int i = 0; i < hiddenIdList.length; i++) {
					String hiddenId = hiddenIdList[i];
					if (hiddenId != null && !Utiles.tieneDato(checkList,hiddenId)) {
						if(mi20<m20) {
							jd = null;
							jd =  ejbJugador.getById( Integer.parseInt(hiddenId) );
							
							//1 verifico si el jugado es capitan en el otro equipo para limpiar el capitan
							if(!Objects.isNull( jd.getEquipo() ) && !Objects.isNull( jd.getEquipo().getCapitan() )) {
								if(jd.getId().equals( jd.getEquipo().getCapitan().getId() )  ) {
									jd.getEquipo().setCapitan(null);
									ejbEquipo.actualizar(jd.getEquipo());
								} 
							}
							
							jd.setEquipo(ed);
							ejbJugador.actualizar(jd);
							
							//verifco esta seleccionado como capinta
							
							if(!Objects.isNull(request.getParameter("capitanid"))) {
								if( jd.getId().toString().equals( request.getParameter("capitanid").trim() ))  {
									ed.setCapitan(jd);
									ejbEquipo.actualizar(ed);
								}
							}	
							mi20++;
						}
					}
				}
			}

			
			response.sendRedirect("EquipoServlet?STATUS=EDIT_SUCCES&ACCION=EDITAR&id="+ed.getId());
		} else if ("ELIMINAR".equals(request.getParameter("ACCION"))) {
			String[] chkEquipo = request.getParameterValues("equiposid");

			if(!Objects.isNull( chkEquipo )) {
				
				for (int i = 0; i < chkEquipo.length; i++) {
					String myCheckBoxValue = chkEquipo[i];
					if (myCheckBoxValue != null) {
						Integer id = Utiles.valInteger(myCheckBoxValue);
						EquipoDTO ed = ejbEquipo.getById(id);
						
						//verificamos si tiene jugadores para liberarlos
						if(!Objects.isNull( ed.getJugadores() ) && ed.getJugadores().size()>0) {
							for(JugadorDTO jd : ed.getJugadores()) {
								jd.setEquipo(null);
								ejbJugador.actualizar(jd);
							}
						}
						
						ejbEquipo.eliminar(id);
						
					}
				}
	
				response.sendRedirect("EquipoServlet?STATUS=DEL_SUCCES");
			} else {
				response.sendRedirect("EquipoServlet?STATUS=DEL_REJECT");
			}

		}
		
	}

}
