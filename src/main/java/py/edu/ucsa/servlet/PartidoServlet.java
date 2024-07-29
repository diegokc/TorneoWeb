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
import py.edu.ucsa.sutiles.Utiles;

@WebServlet(description = "Primer servlet", urlPatterns = { "/PartidoServlet" })
public class PartidoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB(mappedName = "java:global/TorneoEjbApp/TorneoEjbImpl!py.edu.ucsa.ejb.session.TorneoEjbRemote")
	private TorneoEjbRemote ejbTorneo;
	
	private List<TorneoDTO>  torneoList;

	@EJB(mappedName = "java:global/TorneoEjbApp/PartidoEjbImpl!py.edu.ucsa.ejb.session.PartidoEjbRemote")
	private PartidoEjbRemote ejbPartido;
	
	private List<PartidoDTO>  partidoList;
	
	@EJB(mappedName = "java:global/TorneoEjbApp/EquipoEjbImpl!py.edu.ucsa.ejb.session.EquipoEjbRemote")
	private EquipoEjbRemote ejbEquipo;

	private List<EquipoDTO> equipoList;
	
	
    public PartidoServlet() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(true);
		Cookie rcookie[] = request.getCookies();
		
		if (Objects.isNull(request.getParameter("ACCION")) || "".equals(request.getParameter("ACCION"))
				|| "LISTAR".equals(request.getParameter("ACCION"))) {

			System.out.println("ACCION=LISTAR PARTIDO");

			partidoList = ejbPartido.listar();

			//System.out.println(torneoList.toString());

			// EquiposDTO e =
			
			if(partidoList.size()>0) {
				request.getSession().setAttribute("PARTIDOS", partidoList);
			}else {
				request.getSession().setAttribute("PARTIDOS", null);
			}
		

			request.getRequestDispatcher("partidos-listar.jsp").forward(request, response);
		} else if ("NUEVO".equals(request.getParameter("ACCION"))) {

			torneoList = ejbTorneo.listar();
			request.getSession().setAttribute("TORNEOS", torneoList);
			
			
			equipoList = ejbEquipo.listar();
			request.getSession().setAttribute("EQUIPOS", equipoList);
			
			request.getSession().setAttribute("PARTIDO", null);
			request.getRequestDispatcher("partidos-abm.jsp").forward(request, response);
		} else if ("EDITAR".equals(request.getParameter("ACCION"))) {
			Integer id = Utiles.valInteger(request.getParameter("id"));
			if (id > 0) {

				PartidoDTO pd = ejbPartido.getById(id);
				request.getSession().setAttribute("PARTIDO", pd);
				
				torneoList = ejbTorneo.listar();
				request.getSession().setAttribute("TORNEOS", torneoList);
				
				equipoList = ejbEquipo.listar();
				request.getSession().setAttribute("EQUIPOS", equipoList);
				
				request.getRequestDispatcher("partidos-abm.jsp").forward(request, response);
			}
		}
	}



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(true);
		Cookie rcookie[] = request.getCookies();
		Integer maxreco = 86400;
		
		

		if (Objects.isNull(request.getParameter("ACCION")) || "INSERTAR".equals(request.getParameter("ACCION"))) {

			PartidoDTO pd = new PartidoDTO();
			
			TorneoDTO td = new TorneoDTO();
			td.setId(  Utiles.valInteger(request.getParameter("torneo").trim()) );
			
			EquipoDTO eld = new EquipoDTO();
			eld.setId( Utiles.valInteger(request.getParameter("equipoLocal").trim()) );
	
			EquipoDTO evd = new EquipoDTO();
			evd.setId( Utiles.valInteger(request.getParameter("equipoVisitante").trim()) );
			
			pd.setTorneo(td);
			
			pd.setEquipoLocal( eld );
			
			pd.setEquipoVisitante( evd );
			
			pd.setFecha( request.getParameter("fecha").trim() );
			
			pd.setHora( request.getParameter("hora").trim() );
			
			pd.setNumeroDeFecha( Utiles.valInteger(request.getParameter("numeroDeFecha").trim()) );
			pd.setGolesLocal( Utiles.valInteger(request.getParameter("golesLocal").trim()) );
			pd.setGolesVisitante( Utiles.valInteger(request.getParameter("golesVisitante").trim()) );
		
			pd = ejbPartido.insertar(pd);

			request.getSession().setAttribute("PARTIDO", td);

			// request.getRequestDispatcher("jugadores-abm.jsp?STATUS=SUCCES&ACCION=EDITAR").forward(request,
			// response);
			response.sendRedirect("PartidoServlet?STATUS=SUCCES&ACCION=EDITAR&id=" + pd.getId().toString());

		} else if ("ACTUALIZAR".equals(request.getParameter("ACCION"))) {

			PartidoDTO pd = (PartidoDTO) request.getSession().getAttribute("PARTIDO");

			TorneoDTO td = new TorneoDTO();
			td.setId(  Utiles.valInteger(request.getParameter("torneo").trim()) );
			
			EquipoDTO eld = new EquipoDTO();
			eld.setId( Utiles.valInteger(request.getParameter("equipoLocal").trim()) );
	
			EquipoDTO evd = new EquipoDTO();
			evd.setId( Utiles.valInteger(request.getParameter("equipoVisitante").trim()) );
			
			pd.setTorneo(td);
			
			pd.setEquipoLocal( eld );
			
			pd.setEquipoVisitante( evd );
			
			pd.setFecha( request.getParameter("fecha").trim() );
			
			pd.setHora( request.getParameter("hora").trim() );
			
			pd.setNumeroDeFecha( Utiles.valInteger(request.getParameter("numeroDeFecha").trim()) );
			pd.setGolesLocal( Utiles.valInteger(request.getParameter("golesLocal").trim()) );
			pd.setGolesVisitante( Utiles.valInteger(request.getParameter("golesVisitante").trim()) );
			
			ejbPartido.actualizar(pd);

			request.getSession().setAttribute("PARTIDO", pd);

			response.sendRedirect("PartidoServlet?STATUS=EDIT_SUCCES&ACCION=EDITAR&id=" + pd.getId().toString());

		} else if ("ELIMINAR".equals(request.getParameter("ACCION"))) {
			String[] checkboxNamesList = request.getParameterValues("partidosid");
			if(!Objects.isNull( checkboxNamesList )) {
	
				for (int i = 0; i < checkboxNamesList.length; i++) {
					String myCheckBoxValue = checkboxNamesList[i];
					if (myCheckBoxValue != null) {
						// eliminar si es capitan
						ejbPartido.eliminar(Utiles.valInteger(myCheckBoxValue));
					}
				}
	
				response.sendRedirect("PartidoServlet?STATUS=DEL_SUCCES");
			} else {
				response.sendRedirect("PartidoServlet?STATUS=DEL_REJECT");
			}

		}
		
	}

}
