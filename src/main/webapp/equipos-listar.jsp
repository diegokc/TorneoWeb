<%@ page language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<%@ include file="menu.jsp" %> 
<head>
	<title>Equipos</title>
<script>
function cargarNuevo(){
	document.getElementById("grillaSocioForm").submit();
}
function editar(id){
	document.getElementById("ACCION").value="EDITAR";
	document.getElementById("ID").value=id;
	document.getElementById("grillaSocioForm").submit();
}
</script>
</head>

<link rel="stylesheet" type="text/css" href="css/datatables.min.css" />
<body>

<div class="container">

<h1>Listado de Equipos</h1>

<hr />

			<c:choose>
		
			<c:when test="${EQUIPOS == null}">
			<button type="button" class="btn btn-primary">Agregar Equipo</button>
	<form action="TematicaExpoServlet" method="POST" id="grillamasiva" name="grillamasiva">
	<input type="hidden" name="ACCION" id="ACCION" value="INSERTARVARIOS" />
	<input type="hidden" name="msvIdExposicion" id="msvIdExposicion" value="" />
	<input type="hidden" name="tematicaEspecifica" id="tematicaEspecifica" value="" />
	<table class="table" id="tabla-opciones">
	  <thead>
	    <tr>
	    	<th scope="col">id</th>
			<th scope="col">Nombre</th>
			<th scope="col">Slogan</th>
			<th scope="col">Capitan</th>
			<th scope="col" align="center">Acción</th>		
	    </tr>
	  </thead>

	  <tbody>
	    <c:forEach var="eqp" items="${EQUIPOS}">
	    <tr>
	      <td>${eqp.id}</td>
	      <td>${eqp.nombre}</td>
	      <td>${eqp.slogan}</td>
	      <td>.</td>
	      <td align="center">
	      		<input class="form-check-input" type="checkbox" id="multi${eqp.id}" disabled="disabled">
				  <label class="form-check-label" for="multi${eqp.id}">
				    ${eqp.id}
				  </label>
	      </td>
	    </tr>
	 	</c:forEach>
	
	  </tbody>
	</table>
	</form>
	
	</c:when>
    <c:otherwise>
    	<label>No tiene equipos cargados</label>
        <button type="button" class="btn btn-primary" onclick="window.location.assign('EquipoServlet?ACCION=NUEVO');">Agregar Equipo</button>
    </c:otherwise>
</c:choose>

</div>

</body>

</html>
