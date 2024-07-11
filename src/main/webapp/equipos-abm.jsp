<%@ page language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<%@ include file="menu.jsp" %> 
<head>
	<title>ABM de Eqipos</title>
<script>
function cancelar(){
	window.location.assign("OpcionServlet");
}
</script>
</head>


<body>
<div class="container">

<h1>Nuevo Equipo</h1>

<form action="OpcionServlet" method="POST" id="opcionabm" name="opcionabm">

<input type="hidden" id="ACCION" name="ACCION" value="${EQUIPO != null && EQUIPO.id != null ? 'ACTUALIZAR' : 'INSERTAR'}">
						
  <div class="form-row align-items-center">

   
  <div class="col-sm-6 mb-3">
    <label for="id" class="form-label">id</label>
    <input type="text" class="form-control" id="id" aria-describedby="idHelp" placeholder="" name="id" value="${EQUIPO != null && EQUIPO.id != null ? EQUIPO.id : ''}">
    <small id="idHelp" class="form-text text-muted">ID del equipo</small>
  </div>
  
  <div class="col-sm-6 mb-3">
    <label for="nombre" class="form-label">Nombre</label>
    <input type="text" class="form-control" id="nombre" aria-describedby="nombreHelp" placeholder="" name="nombre" value="${EQUIPO != null && EQUIPO.nombre != null ? EQUIPO.codigo : ''}">
    <small id="nombreHelp" class="form-text text-muted">Ingrese el nombre del Equipo</small>
  </div>
  
 
   <div class="col-sm-6 mb-3">
    <label for="slogan" class="form-label">Slogan</label>
    <input type="text" class="form-control" id="slogan" aria-describedby="sloganHelp" placeholder="" name="slogan" value="${EQUIPO != null && EQUIPO.slogan != null ? EQUIPO.slogan : ''}">
    <small id="sloganHelp" class="form-text text-muted">Ingrese la descripción de la opción</small>
  </div>
  

    <div class="col-auto mb-3">
      <button type="submit" class="btn btn-primary">Grabar</button> <button type="button" class="btn btn-primary" onclick="javascript:cancelar();">Cancelar</button>
    </div>
    
  </div>
  
</form>

  </div>

</body>
</html>