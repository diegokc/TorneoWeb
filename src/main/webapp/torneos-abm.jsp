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
	window.location.assign("TorneoServlet");
}
</script>
</head>

<link rel="stylesheet" type="text/css" href="css/datatables.min.css" />
<body>
<%@ include file="menu.jsp" %> 

<div class="container">

<h1>Abm de Jugador</h1>
<hr />

<form action="TorneoServlet" method="POST" id="opcionabm" name="opcionabm">

<input type="hidden" id="ACCION" name="ACCION" value="${TORNEO != null && TORNEO.id != null ? 'ACTUALIZAR' : 'INSERTAR'}">
						
  <div class="form-row align-items-center">

	<c:choose>
		<c:when test="${param.STATUS == 'SUCCES'}">
			<div class="alert alert-success" role="alert">torneo registrado exitosamente</div>
		</c:when>
		<c:when test="${param.STATUS == 'EDIT_SUCCES'}">
			<div class="alert alert-success" role="alert">torneo editado exitosamente</div>
		</c:when>
	</c:choose>
	


   
  <div class="col-sm-6 mb-3">
    <label for="id" class="form-label">id</label>
	<c:choose>
		<c:when test="${param.ACCION == 'NUEVO'}">
			<input type="text" class="form-control" id="id" aria-describedby="idHelp" placeholder="" name="id" value="NUEVO" aria-label="Disabled input example" disabled="" readonly="" />
		</c:when>
		<c:otherwise>
			<input type="text" class="form-control" id="id" aria-describedby="idHelp" placeholder="" name="id" value="${TORNEO != null && TORNEO.id != null ? TORNEO.id : ''}" aria-label="Disabled input example" disabled="" readonly="" />
		</c:otherwise>
	</c:choose>
    <small id="idHelp" class="form-text text-muted">ID del torneo</small>
  </div>
  
  <div class="col-sm-6 mb-3">
    <label for="ano" class="form-label">Año</label>
    <input type="text" class="form-control" id="ano" aria-describedby="anoHelp" placeholder="" name="ano" value="${TORNEO != null && TORNEO.ano != null ? TORNEO.ano : ''}">
    <small id="anoHelp" class="form-text text-muted">Ingrese el año</small>
  </div>
  
  <div class="col-sm-6 mb-3">
    <label for="nombre" class="form-label">nombre</label>
    <input type="text" class="form-control" id="nombre" aria-describedby="nombreHelp" placeholder="" name="nombre" value="${TORNEO != null && TORNEO.nombre != null ? TORNEO.nombre : ''}">
    <small id="nombreHelp" class="form-text text-muted">Ingrese el nombre del torneo</small>
  </div>

  <div class="col-sm-6 mb-3">
    <label for="numeroDeEquipos" class="form-label">numeroDeEquipos</label>
    <input type="text" class="form-control" id="numeroDeEquipos" aria-describedby="numeroDeEquiposHelp" placeholder="" name="numeroDeEquipos" value="${TORNEO != null && TORNEO.numeroDeEquipos != null ? TORNEO.numeroDeEquipos : ''}">
    <small id="numeroDeEquiposHelp" class="form-text text-muted">Ingrese el numero de equipos</small>
  </div>

  <div class="col-sm-6 mb-3">
    <label for="fechaDeInicio" class="form-label">fechaDeInicio</label>
    <input type="text" class="form-control" id="fechaDeInicio" aria-describedby="fechaDeInicioHelp" placeholder="" name="fechaDeInicio" value="${TORNEO != null && TORNEO.fechaDeInicio != null ? TORNEO.fechaDeInicio : ''}">
    <small id="fechaDeInicioHelp" class="form-text text-muted">Ingrese la fecha de inicio</small>
  </div>

  <div class="col-sm-6 mb-3">
    <label for="fechaDeFin" class="form-label">fechaDeFin</label>
    <input type="text" class="form-control" id="fechaDeFin" aria-describedby="fechaDeFinHelp" placeholder="" name="fechaDeFin" value="${TORNEO != null && TORNEO.fechaDeFin != null ? TORNEO.fechaDeFin : ''}">
    <small id="fechaDeFinHelp" class="form-text text-muted">Ingrese la fecha de fin</small>
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
