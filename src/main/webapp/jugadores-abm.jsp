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
	window.location.assign("JugadorServlet");
}
</script>
</head>

<link rel="stylesheet" type="text/css" href="css/datatables.min.css" />
<body>
<%@ include file="menu.jsp" %> 

<div class="container">

<h1>Abm de Jugador</h1>
<hr />

<form action="JugadorServlet" method="POST" id="opcionabm" name="opcionabm">

<input type="hidden" id="ACCION" name="ACCION" value="${JUGADOR != null && JUGADOR.id != null ? 'ACTUALIZAR' : 'INSERTAR'}">
						
  <div class="form-row align-items-center">

	<c:choose>
		<c:when test="${param.STATUS == 'SUCCES'}">
			<div class="alert alert-success" role="alert">jugador registrado exitosamente</div>
		</c:when>
		<c:when test="${param.STATUS == 'EDIT_SUCCES'}">
			<div class="alert alert-success" role="alert">jugador editado exitosamente</div>
		</c:when>
	</c:choose>
	


   
  <div class="col-sm-6 mb-3">
    <label for="id" class="form-label">id</label>
	<c:choose>
		<c:when test="${param.ACCION == 'NUEVO'}">
			<input type="text" class="form-control" id="id" aria-describedby="idHelp" placeholder="" name="id" value="NUEVO" aria-label="Disabled input example" disabled="" readonly="" />
		</c:when>
		<c:otherwise>
			<input type="text" class="form-control" id="id" aria-describedby="idHelp" placeholder="" name="id" value="${JUGADOR != null && JUGADOR.id != null ? JUGADOR.id : ''}" aria-label="Disabled input example" disabled="" readonly="" />
		</c:otherwise>
	</c:choose>
    <small id="idHelp" class="form-text text-muted">ID del jugador</small>
  </div>
  
  <div class="col-sm-6 mb-3">
    <label for="nombre" class="form-label">Nombres</label>
    <input type="text" class="form-control" id="nombres" aria-describedby="nombresHelp" placeholder="" name="nombres" value="${JUGADOR != null && JUGADOR.nombres != null ? JUGADOR.nombres : ''}">
    <small id="nombresHelp" class="form-text text-muted">Ingrese los nombres</small>
  </div>
  
  <div class="col-sm-6 mb-3">
    <label for="apellidos" class="form-label">apellidos</label>
    <input type="text" class="form-control" id="apellidos" aria-describedby="apellidosHelp" placeholder="" name="apellidos" value="${JUGADOR != null && JUGADOR.apellidos != null ? JUGADOR.apellidos : ''}">
    <small id="apellidosHelp" class="form-text text-muted">Ingrese los apellidos</small>
  </div>

  <div class="col-sm-6 mb-3">
    <label for="nroFicha" class="form-label">nroFicha</label>
    <input type="text" class="form-control" id="nroFicha" aria-describedby="nroFichaHelp" placeholder="" name="nroFicha" value="${JUGADOR != null && JUGADOR.nroFicha != null ? JUGADOR.nroFicha : ''}">
    <small id="nroFichaHelp" class="form-text text-muted">Ingrese la fichaNro</small>
  </div>

  <div class="col-sm-6 mb-3">
    <label for="fechaDeNacimiento" class="form-label">fechaDeNacimiento</label>
    <input type="text" class="form-control" id="fechaDeNacimiento" aria-describedby="fechaDeNacimientoHelp" placeholder="" name="fechaDeNacimiento" value="${JUGADOR != null && JUGADOR.fechaDeNacimiento != null ? JUGADOR.fechaDeNacimiento : ''}">
    <small id="fechaDeNacimientoHelp" class="form-text text-muted">Ingrese la fechaDeNacimiento</small>
  </div>

  <div class="col-sm-6 mb-3">
    <label for="nacionalidad" class="form-label">nacionalidad</label>
    <input type="text" class="form-control" id="nacionalidad" aria-describedby="nacionalidadHelp" placeholder="" name="nacionalidad" value="${JUGADOR != null && JUGADOR.nacionalidad != null ? JUGADOR.nacionalidad : ''}">
    <small id="nacionalidadHelp" class="form-text text-muted">Ingrese la nacionalidad</small>
  </div>

  <div class="col-sm-6 mb-3">
    <label for="email" class="form-label">email</label>
    <input type="text" class="form-control" id="email" aria-describedby="emailHelp" placeholder="" name="email" value="${JUGADOR != null && JUGADOR.email != null ? JUGADOR.email : ''}">
    <small id="emailHelp" class="form-text text-muted">Ingrese el email</small>
  </div>
  
  <div class="col-sm-6 mb-3">
    <label for="telefono" class="form-label">telefono</label>
    <input type="text" class="form-control" id="telefono" aria-describedby="telefonoHelp" placeholder="" name="telefono" value="${JUGADOR != null && JUGADOR.telefono != null ? JUGADOR.telefono : ''}">
    <small id="telefonoHelp" class="form-text text-muted">Ingrese el telefono</small>
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
