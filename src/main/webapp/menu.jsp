<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html data-bs-theme="${cookie.bstheme != nul && cookie.bstheme.value != null ? cookie.bstheme.value : 'light' }">
<head>
	<title>Menu principal del sistema</title>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>Demo</title>
	<meta name="description" content="" />
	<meta name="viewport" content="width=device-width" />
	<link rel="icon" type="image/x-icon" href="favicon.ico">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
	<script src="js/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	
	<!-- 	<script src="js/bootstrap.min.js"></script> -->
	
	<script
		src="js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous">
	     </script>
	<script>
		function cambioTema(){
		    if (document.documentElement.getAttribute('data-bs-theme') == 'dark') {
		        document.documentElement.setAttribute('data-bs-theme','light');
		    }
		    else {
		        document.documentElement.setAttribute('data-bs-theme','dark');
		    }
		    
			$.ajax({
				url: 'HolaDiplo?bstheme=' + document.documentElement.getAttribute('data-bs-theme'),
        		type: "GET",
        		success: function (data) {
        			console.log(data);
        		}
	    });
		    
		}
	</script>
</head>
<body>

<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item"><a class="nav-link" href="Inicio">Inicio</a></li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Equipos</a>
           <ul class="dropdown-menu">
           <li><a class="dropdown-item" href="EquipoServlet?ACCION=LISTAR">Listar Equipos</a></li>
            <li><a class="dropdown-item" href="EquipoServlet?ACCION=NUEVO">Abm Equipos</a></li>
          </ul>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Parametros</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="OpcionServlet">Listar Opciones</a></li>
            <li><a class="dropdown-item" href="TematicaExpoServlet">Listar Exposiciones Tematicas</a></li>
          </ul>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Socios</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Pago de cuotas</a></li>
            <li><a class="dropdown-item" href="#">Consultar cuotas pendientes</a></li>
            <li><a class="dropdown-item" href="SocioServlet">Registrar socio</a></li>
            <li><a class="dropdown-item" href="listar-socio.jps">Listar socio</a></li>
            <li><a class="dropdown-item" href="TematicaServlet">Expo por tematica</a></li>
            <li><a class="dropdown-item" href="Login?ACCION=LOGOUT">Salir</a></li>
          </ul>
        </li>
      </ul>


		<c:choose>
		    <c:when test="${SOCIO == null}">
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664z"/>
</svg>
		    <i class="bi bi-person"></i>
		    ${SOCIO.nombres}
		    </c:when>
		    <c:otherwise>
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
<path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
</svg>
		     ${SOCIO.nombres}<i class="bi bi-person-fill"></i>
		    </c:otherwise>
		</c:choose>
		
	<button class="btn" type="button" onclick="javascript:cambioTema();" id="cambioTema" name="cambioTema">dark/ligth</button>
	
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>



  </body>