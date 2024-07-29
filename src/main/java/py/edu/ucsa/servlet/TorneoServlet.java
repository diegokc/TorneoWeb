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
import py.edu.ucsa.sutiles.Utiles;
import py.edu.ucsa.ejb.dto.*;
import py.edu.ucsa.ejb.session.*;


@WebServlet(description = "Primer servlet", urlPatterns = { "/TorneoServlet" })
public class TorneoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB(mappedName = "java:global/TorneoEjbApp/TorneoEjbImpl!py.edu.ucsa.ejb.session.TorneoEjbRemote")
	private TorneoEjbRemote ejbTorneo;
	
	private List<TorneoDTO>  torneoList;
	

	@EJB(mappedName = "java:global/TorneoEjbApp/PartidoEjbImpl!py.edu.ucsa.ejb.session.PartidoEjbRemote")
	private PartidoEjbRemote ejbPartido;
	
	private List<PartidoDTO>  partidoList;
	
    public TorneoServlet() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(true);
		Cookie rcookie[] = request.getCookies();
		
		if (Objects.isNull(request.getParameter("ACCION")) || "".equals(request.getParameter("ACCION"))
				|| "LISTAR".equals(request.getParameter("ACCION"))) {

			System.out.println("ACCION=LISTAR TORNEO");

			torneoList = ejbTorneo.listar();

			//System.out.println(torneoList.toString());

			// EquiposDTO e =
			if(torneoList.size()>0) {
				request.getSession().setAttribute("TORNEOS", torneoList);
			}else {
				request.getSession().setAttribute("TORNEOS", null);
			}
				
			request.getRequestDispatcher("torneos-listar.jsp").forward(request, response);
		} else if ("NUEVO".equals(request.getParameter("ACCION"))) {
			request.getSession().setAttribute("TORNEO", null);
			request.getRequestDispatcher("torneos-abm.jsp").forward(request, response);
		} else if ("EDITAR".equals(request.getParameter("ACCION"))) {
			Integer id = Utiles.valInteger(request.getParameter("id"));
			if (id > 0) {

				TorneoDTO td = ejbTorneo.getById(id);
				request.getSession().setAttribute("TORNEO", td);
				request.getRequestDispatcher("torneos-abm.jsp").forward(request, response);
			}
		}
	}



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(true);
		Cookie rcookie[] = request.getCookies();
		Integer maxreco = 86400;
		
		

		if (Objects.isNull(request.getParameter("ACCION")) || "INSERTAR".equals(request.getParameter("ACCION"))) {

			TorneoDTO td = new TorneoDTO();
			td.setAno( Utiles.valInteger(request.getParameter("ano").trim()) );
			td.setNombre(request.getParameter("nombre").trim());
			td.setNumeroDeEquipos( Utiles.valInteger(request.getParameter("numeroDeEquipos").trim()) );
			td.setFechaDeInicio( request.getParameter("fechaDeInicio").trim() );
			td.setFechaDeFin(  request.getParameter("fechaDeFin").trim() );
		
			td = ejbTorneo.insertar(td);

			request.getSession().setAttribute("TORNEO", td);

			// request.getRequestDispatcher("jugadores-abm.jsp?STATUS=SUCCES&ACCION=EDITAR").forward(request,
			// response);
			response.sendRedirect("TorneoServlet?STATUS=SUCCES&ACCION=EDITAR&id=" + td.getId().toString());

		} else if ("ACTUALIZAR".equals(request.getParameter("ACCION"))) {

			TorneoDTO td = (TorneoDTO) request.getSession().getAttribute("TORNEO");

			td.setAno( Utiles.valInteger(request.getParameter("ano").trim()) );
			td.setNombre(request.getParameter("nombre").trim());
			td.setNumeroDeEquipos( Utiles.valInteger(request.getParameter("numeroDeEquipos").trim()) );
			td.setFechaDeInicio( request.getParameter("fechaDeInicio").trim() );
			td.setFechaDeFin(  request.getParameter("fechaDeFin").trim() );

			ejbTorneo.actualizar(td);

			request.getSession().setAttribute("TORNEO", td);

			response.sendRedirect("TorneoServlet?STATUS=EDIT_SUCCES&ACCION=EDITAR&id=" + td.getId().toString());

		}   else if ("ELIMINAR".equals(request.getParameter("ACCION"))) {
			String[] chkTorneos = request.getParameterValues("torneosid");

			if(!Objects.isNull( chkTorneos )) {
				
				for (int i = 0; i < chkTorneos.length; i++) {
					String myCheckBoxValue = chkTorneos[i];
					if (myCheckBoxValue != null) {
						Integer id = Utiles.valInteger(myCheckBoxValue);
												
						partidoList = ejbPartido.finByTorneo(id);
						
						//verificamos si tiene jugadores para liberarlos
						if(!Objects.isNull( partidoList ) && partidoList.size()>0) {
							for(PartidoDTO pd : partidoList ) {
								ejbPartido.eliminar(pd.getId());
							}
						}
						
						ejbTorneo.eliminar(id);
						
					}
				}
	
				response.sendRedirect("TorneoServlet?STATUS=DEL_SUCCES");
			} else {
				response.sendRedirect("TorneoServlet?STATUS=DEL_REJECT");
			}

		}
		
	}

}
