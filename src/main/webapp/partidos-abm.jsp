<%@ page language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es" data-bs-theme="${cookie.bstheme != nul && cookie.bstheme.value != null ? cookie.bstheme.value : 'light' }">
<head>
	<title>Torneo del 18 de Enero de Luque - Abm Jugadores</title>
<%@ include file="cabecera.jsp" %>
<script>
function cargarNuevo(){
	document.getElementById("grillaSocioForm").submit();
}
function editar(id){
	document.getElementById("ACCION").value="EDITAR";
	document.getElementById("ID").value=id;
	document.getElementById("grillaSocioForm").submit();
}
function cancelar(){
	window.location.assign("PartidoServlet");
}
</script>
</head>

<link rel="stylesheet" type="text/css" href="css/datatables.min.css" />
<body>
<%@ include file="menu.jsp" %> 

<div class="container">

<h1>Abm de Partido</h1>
<hr />

<form action="PartidoServlet" method="POST" id="opcionabm" name="opcionabm">

<input type="hidden" id="ACCION" name="ACCION" value="${PARTIDO != null && PARTIDO.id != null ? 'ACTUALIZAR' : 'INSERTAR'}">
						
  <div class="form-row align-items-center">

	<c:choose>
		<c:when test="${param.STATUS == 'SUCCES'}">
			<div class="alert alert-success" role="alert">partido registrado exitosamente</div>
		</c:when>
		<c:when test="${param.STATUS == 'EDIT_SUCCES'}">
			<div class="alert alert-success" role="alert">partido editado exitosamente</div>
		</c:when>
	</c:choose>
	


   
  <div class="col-sm-6 mb-3">
    <label for="id" class="form-label">id</label>
	<c:choose>
		<c:when test="${param.ACCION == 'NUEVO'}">
			<input type="text" class="form-control" id="id" aria-describedby="idHelp" placeholder="" name="id" value="NUEVO" aria-label="Disabled input example" disabled="" readonly="" />
		</c:when>
		<c:otherwise>
			<input type="text" class="form-control" id="id" aria-describedby="idHelp" placeholder="" name="id" value="${PARTIDO != null && PARTIDO.id != null ? PARTIDO.id : ''}" aria-label="Disabled input example" disabled="" readonly="" />
		</c:otherwise>
	</c:choose>
    <small id="idHelp" class="form-text text-muted">ID del partido</small>
  </div>
  
  
  <div class="col-sm-6 mb-3">
    <label for="torneo" class="form-label">Torneo</label>
    <select  class="form-select" aria-label="Default select example" id="torneo" aria-describedby="torneoHelp" placeholder="" name="torneo">
    <option>-seleccionar-</option>
		<c:choose>
		<c:when test="${TORNEOS != null}">
	 	<c:forEach var="tr" items="${TORNEOS}">
	  	<option value="${tr.id}" ${PARTIDO != null && PARTIDO.torneo.id == tr.id ? 'selected=""' : ''}>${tr.id} ${tr.nombre} ${tr.ano}</option>
	 	</c:forEach>
		</c:when>
		</c:choose>
    </select>
    <small id="torneoHelp" class="form-text text-muted">Seleccione el torneo</small>
  </div>
  
  <div class="col-sm-6 mb-3">
    <label for="equipoLocal" class="form-label">Equipo local</label>
    <select  class="form-select" aria-label="Default select example" id="equipoLocal" aria-describedby="equipoLocalHelp" placeholder="" name="equipoLocal">
    <option>-seleccionar-</option>
		<c:choose>
		<c:when test="${EQUIPOS != null}">
	 	<c:forEach var="eqp" items="${EQUIPOS}">
	  	<option value="${eqp.id}" ${PARTIDO != null && PARTIDO.equipoLocal.id == eqp.id ? 'selected=""' : ''}>${eqp.id} ${eqp.nombre}</option>
	 	</c:forEach>
		</c:when>
		</c:choose>
    </select>
    <small id="equipoLocalHelp" class="form-text text-muted">Seleccione el equipo local</small>
  </div>

  <div class="col-sm-6 mb-3">
    <label for="equipoVisitante" class="form-label">Equipo local</label>
    <select  class="form-select" aria-label="Default select example" id="equipoVisitante" aria-describedby="equipoVisitanteHelp" placeholder="" name="equipoVisitante">
    <option>-seleccionar-</option>
		<c:choose>
		<c:when test="${EQUIPOS != null}">
	 	<c:forEach var="eqp" items="${EQUIPOS}">
	  	<option value="${eqp.id}" ${PARTIDO != null && PARTIDO.equipoVisitante.id == eqp.id ? 'selected=""' : ''}>${eqp.id} ${eqp.nombre}</option>
	 	</c:forEach>
		</c:when>
		</c:choose>
    </select>
    <small id="equipoVisitanteHelp" class="form-text text-muted">Seleccione el equipo visitante</small>
  </div>

  <div class="col-sm-6 mb-3">
    <label for="fecha" class="form-label">fecha</label>
    <input type="text" class="form-control" id="fecha" aria-describedby="fechaHelp" placeholder="" name="fecha" value="${PARTIDO != null && PARTIDO.fecha != null ? PARTIDO.fecha : ''}">
    <small id="fechaHelp" class="form-text text-muted">Ingrese la fecha</small>
  </div>
    
  <div class="col-sm-6 mb-3">
    <label for="hora" class="form-label">hora</label>
    <input type="text" class="form-control" id="hora" aria-describedby="horaHelp" placeholder="" name="hora" value="${PARTIDO != null && PARTIDO.hora != null ? PARTIDO.hora : ''}">
    <small id="horaHelp" class="form-text text-muted">Ingrese la hora</small>
  </div>

  <div class="col-sm-6 mb-3">
    <label for="numeroDeFecha" class="form-label">numeroDeFecha</label>
    <input type="text" class="form-control" id="numeroDeFecha" aria-describedby="numeroDeFechaHelp" placeholder="" name="numeroDeFecha" value="${PARTIDO != null && PARTIDO.numeroDeFecha != null ? PARTIDO.numeroDeFecha : ''}">
    <small id="numeroDeFechaHelp" class="form-text text-muted">Ingrese el numero de fecha</small>
  </div>

  <div class="col-sm-6 mb-3">
    <label for="golesLocal" class="form-label">golesLocal</label>
    <input type="text" class="form-control" id="golesLocal" aria-describedby="golesLocalHelp" placeholder="" name="golesLocal" value="${PARTIDO != null && PARTIDO.golesLocal != null ? PARTIDO.golesLocal : ''}">
    <small id="golesLocalHelp" class="form-text text-muted">Ingrese los goles de local</small>
  </div>

  <div class="col-sm-6 mb-3">
    <label for="golesVisitante" class="form-label">golesVisitante</label>
    <input type="text" class="form-control" id="golesVisitante" aria-describedby="golesVisitanteHelp" placeholder="" name="golesVisitante" value="${PARTIDO != null && PARTIDO.golesVisitante != null ? PARTIDO.golesVisitante : ''}">
    <small id="golesVisitanteHelp" class="form-text text-muted">Ingrese los goles de visitante</small>
  </div>

 

    <div class="col-auto mb-3">
      <button type="submit" class="btn btn-primary">Grabar</button> <button type="button" class="btn btn-primary" onclick="javascript:cancelar();">Cancelar</button>
    </div>
    
  </div>
  
</form>

</div>

<%@ include file="piedepagina.jsp" %>
</body>

</html>
