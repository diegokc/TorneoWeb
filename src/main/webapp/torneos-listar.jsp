<%@ page language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html data-bs-theme="${cookie.bstheme != nul && cookie.bstheme.value != null ? cookie.bstheme.value : 'light' }">
<head>
	<title>Torneo del 18 de Enero de Luque - Listar Torneos</title>
<%@ include file="cabecera.jsp" %>
<script>
function eliminarTorneos(){
	
	document.getElementById("grillamasiva").submit();
}
function editar(id){
	window.location.assign("TorneoServlet?ACCION=EDITAR&id="+id);
}
function rescindir(id){
	window.location.assign("TorneoServlet?ACCION=RESCINDIR&id="+id);
}
function nuevoTorneo(){
	window.location.assign("TorneoServlet?ACCION=NUEVO");
}
</script>
</head>

<link rel="stylesheet" type="text/css" href="css/datatables.min.css" />
<body>
<%@ include file="menu.jsp" %> 

<div class="container">

<h1>Lista de Torneos</h1>

<hr />

	<c:choose>
		<c:when test="${param.STATUS == 'DEL_SUCCES'}">
			<div class="alert alert-success" role="alert">Torneo(s) eliminado(s) exitosamente</div>
		</c:when>
		<c:when test="${param.STATUS == 'RESC_SUCCES'}">
			<div class="alert alert-success" role="alert">rescicion exitosa</div>
		</c:when>
		<c:when test="${param.STATUS == 'RESC_REJECT'}">
			<div class="alert alert-danger" role="alert">el jugador no pertenece a ning�n equipo para su resici�n</div>
		</c:when>
		<c:when test="${param.STATUS == 'DEL_REJECT'}">
			<div class="alert alert-danger" role="alert">debe seleccionar al menos un torneo para eliminar</div>
		</c:when>
		
	</c:choose>
	
			<c:choose>
		
			<c:when test="${TORNEOS != null}">
			
	<form action="TorneoServlet" method="POST" id="grillamasiva" name="grillamasiva">
	
	<button type="button" class="btn btn-primary" onclick="nuevoTorneo();">Agregar nuevo Torneo</button>
	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">Eliminar Torneos</button>
	
	<input type="hidden" name="ACCION" id="ACCION" value="ELIMINAR" />
	<input type="hidden" name="msvIdExposicion" id="msvIdExposicion" value="" />
	<input type="hidden" name="tematicaEspecifica" id="tematicaEspecifica" value="" />
	
	<hr />
	
	<table class="table" id="tabla-opciones">
	  <thead>
	    <tr>
	    	<th scope="col">id</th>
			<th scope="col">Nombre</th>
			<th scope="col">A�o</th>
			<th scope="col">Fecha Inicio</th>
			<th scope="col">Fecha Fin</th>
			<th scope="col">Nro.Equipos</th>
			<th scope="col" align="center" class="col-2">Acci�n</th>		
	    </tr>
	  </thead>

	  <tbody>
	    <c:forEach var="tr" items="${TORNEOS}">
	    <tr>
	      <td>${tr.id}</td>
	      <td>${tr.nombre}</td>
	      <td>${tr.ano}</td>
	      <td>${tr.fechaDeInicio}</td>
	      <td>${tr.fechaDeFin}</td>
	      <td>${tr.numeroDeEquipos}</td>
	      <td align="center">

<button type="button" class="btn btn-primary" onclick="editar(${tr.id});">
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
<path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325"></path>
</svg>
</button>

<input type="checkbox" class="btn-check" autocomplete="off" id="multi${tr.id}" name="torneosid" value="${tr.id}"/>
<label class="btn btn-outline-primary" for="multi${tr.id}"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
  <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
</svg></label>

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
        <button type="button" class="btn btn-primary" onclick="eliminarTorneos();" >Aceptar</button>
      </div>
    </div>
  </div>
</div>

	</c:when>
    <c:otherwise>
    	<label>No tiene torneos cargados</label>
        <button type="button" class="btn btn-primary" onclick="nuevoTorneo();">Agregar nuevo torneo</button>
    </c:otherwise>
</c:choose>

</div>

<%@ include file="piedepagina.jsp" %>
</body>

</html>
