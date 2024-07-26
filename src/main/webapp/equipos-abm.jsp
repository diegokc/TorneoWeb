<%@ page language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html data-bs-theme="${cookie.bstheme != nul && cookie.bstheme.value != null ? cookie.bstheme.value : 'light' }">
<head>
	<title>Torneo del 18 de Enero de Luque - Abm Equipo</title>
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
	window.location.assign("EquipoServlet");
}

$(document).ready(function(){
	$('[data-toggle="tooltip"]').tooltip();
	var actions = $("table td:last-child").html();
	// Append table with add row form on add new button click
    $(".add-new").click(function(){
		$(this).attr("disabled", "disabled");
		
		var jid = $(this).attr('id');
		var hmulti = $("#hmulti"+jid).val();

		if(  hmulti != jid ) {
			var jnom = $("#mnombres"+jid).val();
			var jape = $("#mapellidos"+jid).val();
			
			//var index = $("table tbody tr:last-child").index();
	        var row = '<tr>' +
	        '<td>'+jid+'<input type="hidden" id="hmulti'+jid+'" name="hjid" value="'+jid+'"/></td>'+
	        '<td>'+jnom+'</td>'+
	        '<td>'+jape+'</td>'+
	        '<td> '+
	        ' <input type="checkbox" class="btn-check" autocomplete="off" id="multi'+jid+'" name="jugadoresid" value="'+jid+'"/> <label class="btn btn-outline-primary" for="multi'+jid+'"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16"> <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/> <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/> </svg></label> '+
	        ' <input type="radio" class="btn-check" autocomplete="off" id="unicapi'+jid+'" name="capitanid" value="'+jid+'"/><label class="btn btn-outline-primary" for="unicapi'+jid+'"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg></label> ' +
	        '</td>'+
	        '</tr>';
	    	$("#tablel").append(row);		
			//$("table tbody tr").eq(index + 1).find(".add, .edit").toggle();
	        $('[data-toggle="tooltip"]').tooltip();
		} else {
			alert("el jugador ya esta registrado");
		}
    });
	
	// Add row on add button click
	$(document).on("click", ".add", function(){
		var empty = false;
		var input = $(this).parents("tr").find('input[type="text"]');
        input.each(function(){
			if(!$(this).val()){
				$(this).addClass("error");
				empty = true;
			} else{
                $(this).removeClass("error");
            }
		});
		$(this).parents("tr").find(".error").first().focus();
		if(!empty){
			input.each(function(){
				$(this).parent("td").html($(this).val());
			});			
			$(this).parents("tr").find(".add, .edit").toggle();
			$(".add-new").removeAttr("disabled");
		}		
    });
	// Edit row on edit button click
	$(document).on("click", ".edit", function(){		
        $(this).parents("tr").find("td:not(:last-child)").each(function(){
			$(this).html('<input type="text" class="form-control" value="' + $(this).text() + '">');
		});		
		$(this).parents("tr").find(".add, .edit").toggle();
		$(".add-new").attr("disabled", "disabled");
    });
	// Delete row on delete button click
	$(document).on("click", ".delete", function(){
        $(this).parents("tr").remove();
		$(".add-new").removeAttr("disabled");
    });
});
</script>
</head>

<link rel="stylesheet" type="text/css" href="css/datatables.min.css" />
<body>
<%@ include file="menu.jsp" %> 

<div class="container">

<h1>Abm de Equipo</h1>

<hr />
<c:choose>
			<c:when test="${param.STATUS == 'SUCCES'}">
				<div class="alert alert-success d-flex align-items-center" role="alert">
  				<svg class="bi flex-shrink-0 me-2" role="img" aria-label="Success:" width="16" height="16"><use xlink:href="#check-circle-fill"/></svg>
  				<div>
    			Equipo registrado exitosamente
  				</div>
				</div>
				<hr />
			</c:when>
			<c:when test="${param.STATUS == 'EDIT_SUCCES'}">
				<div class="alert alert-success d-flex align-items-center" role="alert">
  				<svg class="bi flex-shrink-0 me-2" role="img" aria-label="Success:" width="16" height="16"><use xlink:href="#check-circle-fill"/></svg>
  				<div>
    			Equipo modificado exitosamente
  				</div>
				</div>
				<hr />
			</c:when>
		</c:choose>
		
<form action="EquipoServlet" method="POST" id="equipoabm" name="equipoabm">

<input type="hidden" id="ACCION" name="ACCION" value="${EQUIPO != null && EQUIPO.id != null ? 'ACTUALIZAR' : 'INSERTAR'}">
					
  <div class="row">
  <div class="col">	
	  <div class="form-row align-items-center">
	
		
	   
	  <div class="col-sm mb-3">
	    <label for="id" class="form-label">id</label>
		<c:choose>
			<c:when test="${param.ACCION == 'NUEVO'}">
				<input type="text" class="form-control" id="id" aria-describedby="idHelp" placeholder="" name="id" value="NUEVO" aria-label="Disabled input example" disabled="" readonly="" />
			</c:when>
			<c:otherwise>
				<input type="text" class="form-control" id="id" aria-describedby="idHelp" placeholder="" name="id" value="${EQUIPO != null && EQUIPO.id != null ? EQUIPO.id : ''}" aria-label="Disabled input example" disabled="" readonly="" />
			</c:otherwise>
		</c:choose>
	    <small id="idHelp" class="form-text text-muted">ID del equipo</small>
	  </div>
	  
	  <div class="col-sm mb-3">
	    <label for="nombre" class="form-label">Nombre</label>
	    <input type="text" class="form-control" id="nombre" aria-describedby="nombreHelp" placeholder="" name="nombre" value="${EQUIPO != null && EQUIPO.nombre != null ? EQUIPO.nombre : ''}">
	    <small id="nombreHelp" class="form-text text-muted">Ingrese el nombre del Equipo</small>
	  </div>
	  
	 
	   <div class="col-sm mb-3">
	    <label for="slogan" class="form-label">Slogan</label>
	    <input type="text" class="form-control" id="slogan" aria-describedby="sloganHelp" placeholder="" name="slogan" value="${EQUIPO != null && EQUIPO.slogan != null ? EQUIPO.slogan : ''}">
	    <small id="sloganHelp" class="form-text text-muted">Ingrese el slogan del equipo</small>
	  </div>
	  
	
	    <div class="col-auto mb-3 text-center">
	      <button type="submit" class="btn btn-primary">Grabar</button> <button type="button" class="btn btn-primary" onclick="javascript:cancelar();">Cancelar</button>
	    </div>
	    
	  </div>
  
  </div>


  <div class="col">


            <div class="table-title">
                <div class="row">
                    <div class="col-sm-8">Jugadores</div>
                    <div class="col-sm-4"><!--  class="btn btn-info add-new" -->
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" ><i class="bi bi-search"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
</svg></i> buscar</button>
                    </div>
                </div>
            </div>
            <hr />
            <table class="table table-bordered" id="tablel">
                <thead>
                    <tr>
                        <th>id</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
			<c:choose>
			<c:when test="${EQUIPO.jugadores != null}">
			
	    		<c:forEach var="jg" items="${EQUIPO.jugadores}">
                    <tr>
                        <td>${jg.id}<input type="hidden" id="hmulti${jg.id}" name="hjid" value="${jg.id}"/></td>
                        <td>${jg.nombres}</td>
                        <td>${jg.apellidos}</td>
                        <td>
<input type="checkbox" class="btn-check" autocomplete="off" id="multi${jg.id}" name="chjid" value="${jg.id}"/>
<label class="btn btn-outline-primary" for="multi${jg.id}"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
  <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
</svg></label>

<input type="radio" class="btn-check" autocomplete="off" id="unicapi${jg.id}" name="capitanid" value="${jg.id}" ${EQUIPO.capitan != null && EQUIPO.capitan.id == jg.id ? 'checked=""' : ''}/>
<label class="btn btn-outline-primary" for="unicapi${jg.id}"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16">
  <path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/>
</svg></label>

                        </td>
                    </tr>
                    </c:forEach>
				</c:when>
				</c:choose>
                </tbody>
            </table>

  </div>
  </div>
  


</form>


<!-- Vertically centered scrollable modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Seleccione el jugador</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
<table>
                <thead>
                    <tr>
                        <th>id</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Nacionalidad</th>
                        <th>accion</th>
                    </tr>
                </thead>
                <tbody>
			<c:choose>
			<c:when test="${JUGADORES != null}">
			
	    		<c:forEach var="jg" items="${JUGADORES}">
                    <tr>
                        <td>${jg.id}</td>
                        <td>${jg.nombres}</td>
                        <td>${jg.apellidos}</td>
                        <td>${jg.nacionalidad}</td>
                        <td><button type="button" class="btn btn-primary add-new" id="${jg.id}"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-plus" viewBox="0 0 16 16">
  <path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
  <path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5"/>
</svg></button>
<input type="hidden" id="mid${jg.id}" value="${jg.id}" />
<input type="hidden" id="mnombres${jg.id}" value="${jg.nombres}" />
<input type="hidden" id="mapellidos${jg.id}" value="${jg.apellidos}" />
</td>
                    </tr>
                    </c:forEach>
				</c:when>
				</c:choose>
                </tbody>
            </table>
            
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cerrar</button>
       <!-- <button type="button" class="btn btn-primary" onclick="eliminarJugadores();" >Aceptar</button> --> 
      </div>
    </div>
  </div>
</div>

  </div>

<%@ include file="piedepagina.jsp" %>
</body>
</html>