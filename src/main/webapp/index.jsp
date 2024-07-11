<%@ page language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>

<%@ include file="menu.jsp" %> 
<head>
	<title>Opciones</title>
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

<h1>Bienvenido a Torneo-WEB!!!!</h1>

<hr />

<h2>Link de pruebas</h2>

<ul>
<li><a href="index.jsp">Inicio</a></li>
<li><a href="menu.jsp">menu</a></li>
<li><a href="Login">Login</a></li>
<li>---</li>
<li><a href="SocioServlet">Equipos</a></li>
<li><a href="SocioServlet">Jugadores</a></li>
<li><a href="VerUsuario">Ver Usuario</a></li>
<li><a href="ProbarCookie">ProbarCookie</a></li>
<li><a href="LeerCookie">LeerCookie</a></li>


</ul>
<p>
		<c:choose>
		    <c:when test="${SOCIO != null}">
		    ${SOCIO.nombres}
		    </c:when>
		</c:choose>
</p>

</div>

</body>

</html>
