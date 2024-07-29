<%@ page language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html data-bs-theme="${cookie.bstheme != nul && cookie.bstheme.value != null ? cookie.bstheme.value : 'light' }">
<head>
	<title>Torneo del 18 de Enero de Luque - Listar Jugadores</title>
<%@ include file="cabecera.jsp" %>
<script>
function eliminarJugadores(){
	
	document.getElementById("grillamasiva").submit();
}
function editar(id){
	window.location.assign("JugadorServlet?ACCION=EDITAR&id="+id);
}
function rescindir(id){
	window.location.assign("JugadorServlet?ACCION=RESCINDIR&id="+id);
}
function nuevoJugador(){
	window.location.assign("JugadorServlet?ACCION=NUEVO");
}
function buscarPorNombre(){
	var q = document.getElementById("qnombre").value;
	window.location.assign("JugadorServlet?ACCION=BUSCAR&qnombre="+q );
}
</script>
</head>

<link rel="stylesheet" type="text/css" href="css/datatables.min.css" />
<body>
<%@ include file="menu.jsp" %> 

<div class="container">

<h1>Listado de Jugadores</h1>

<hr />

	<c:choose>
		<c:when test="${param.STATUS == 'DEL_SUCCES'}">
			<div class="alert alert-success" role="alert">jugador(es) eliminado(s) exitosamente</div>
		</c:when>
		<c:when test="${param.STATUS == 'RESC_SUCCES'}">
			<div class="alert alert-success" role="alert">rescicion exitosa</div>
		</c:when>
		<c:when test="${param.STATUS == 'RESC_REJECT'}">
			<div class="alert alert-danger" role="alert">el jugador no pertenece a ningún equipo para su resición</div>
		</c:when>
		<c:when test="${param.STATUS == 'DEL_REJECT'}">
			<div class="alert alert-danger" role="alert">debe seleccionar al menos un jugador para eliminar</div>
		</c:when>
		
	</c:choose>
	
			<c:choose>
		
			<c:when test="${JUGADORES != null}">
			
			
	 <div class="row">
  		<div class="col">
	
			<button type="button" class="btn btn-primary" onclick="nuevoJugador();">Agregar nuevo Jugador</button>
			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">Eliminar Jugadores</button>
		</div>
	  		<div class="col">	
  		
				<div class="input-group mb-3">
				  <input type="text" class="form-control" placeholder="buscar por nombre" aria-label="buscar por nombre" aria-describedby="buscar por nombre" name="qnombre" id="qnombre" />
				  <button class="btn btn-primary" type="button" id="buscarpornombre" onclick="buscarPorNombre();" >buscar</button>
				</div>

  		</div>
  	</div>
	
	
	<form action="JugadorServlet" method="POST" id="grillamasiva" name="grillamasiva">
		
	<input type="hidden" name="ACCION" id="ACCION" value="ELIMINAR" />
	<input type="hidden" name="msvIdExposicion" id="msvIdExposicion" value="" />
	<input type="hidden" name="tematicaEspecifica" id="tematicaEspecifica" value="" />
	
	<hr />
	
	<table class="table" id="tabla-opciones">
	  <thead>
	    <tr>
	    	<th scope="col">id</th>
			<th scope="col">Nombre</th>
			<th scope="col">Apellido</th>
			<th scope="col">Ficha Nro</th>
			<th scope="col">Fec.Naci</th>
			<th scope="col">Nacionalidad</th>
			<th scope="col">Télefono</th>
			<th scope="col" align="center" class="col-2">Acción</th>		
	    </tr>
	  </thead>

	  <tbody>
	    <c:forEach var="jg" items="${JUGADORES}">
	    <tr>
	      <td>${jg.id}</td>
	      <td>${jg.nombres}</td>
	      <td>${jg.apellidos}</td>
	      <td>${jg.nroFicha}</td>
	      <td>${jg.fechaDeNacimiento}</td>
	      <td>${jg.nacionalidad}</td>
	      <td>${jg.telefono}</td>
	      <td align="center">

<button type="button" class="btn btn-primary" onclick="editar(${jg.id});">
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
<path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325"></path>
</svg>
</button>

<button type="button" class="btn btn-primary" onclick="rescindir(${jg.id});">
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-escape" viewBox="0 0 16 16">
  <path d="M8.538 1.02a.5.5 0 1 0-.076.998 6 6 0 1 1-6.445 6.444.5.5 0 0 0-.997.076A7 7 0 1 0 8.538 1.02"/>
  <path d="M7.096 7.828a.5.5 0 0 0 .707-.707L2.707 2.025h2.768a.5.5 0 1 0 0-1H1.5a.5.5 0 0 0-.5.5V5.5a.5.5 0 0 0 1 0V2.732z"/>
</svg>
</button>

<input type="checkbox" class="btn-check" autocomplete="off" id="multi${jg.id}" name="jugadoresid" value="${jg.id}"/>
<label class="btn btn-outline-primary" for="multi${jg.id}"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
  <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
</svg></label>

<!-- 
	      		<input class="form-check-input" type="checkbox" id="multi${jg.id}" name="jugadoresid" value="${jg.id}"/>
				  <label class="form-check-label" for="multi${jg.id}">
				    ${jg.id}
				  </label>
				  -->
	      </td>
	    </tr>
	 	</c:forEach>
	
	  </tbody>
	</table>
	
	
	</form>
	
	<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Advertencia</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Estas seguro que desea eliminar los registro seleccionados?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-primary" onclick="eliminarJugadores();" >Aceptar</button>
      </div>
    </div>
  </div>
</div>

	</c:when>
    <c:otherwise>

        <c:choose>
			<c:when test="${param.ACCION == 'BUSCAR'}">
			<div class="row">
  				<div class="col">	
					<div class="alert alert-success" role="alert">no se ha encontrado registros</div>
				</div>
				<div class="col">	
					<div class="input-group mb-3">
					  <input type="text" class="form-control" placeholder="buscar por nombre" aria-label="buscar por nombre" aria-describedby="buscar por nombre" name="qnombre" id="qnombre" />
					  <button class="btn btn-primary" type="button" id="buscarpornombre" onclick="buscarPorNombre();" >buscar</button>
					  <button type="button" class="btn btn-primary" onclick="window.location.assign('JugadorServlet?ACCION=LISTAR');">volver</button>
					</div>
					
				</div>
			</div>
			</c:when>
    		<c:otherwise>
    			<label>No tiene jugadores cargados</label>
        		<button type="button" class="btn btn-primary" onclick="nuevoJugador();">Agregar nuevo Jugador</button>
    		</c:otherwise>
		</c:choose>
		

        
    </c:otherwise>
</c:choose>

</div>

<%@ include file="piedepagina.jsp" %>
</body>

</html>
