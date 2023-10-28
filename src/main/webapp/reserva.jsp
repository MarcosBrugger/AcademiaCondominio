<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Index</title>
	<jsp:include page="painel/bootstrap.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
	  <div class="container-fluid">
	    <div class="collapse navbar-collapse" id="navbarSupportedContent">
	      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
	        <li class="nav-item">
	          <a class="nav-link" href="painel/inicio.jsp">Painel Administrativo</a>
	        </li>
	      </ul>
	      <form class="d-flex" role="search">
	        <a class="nav-link" href="<%= request.getContextPath() %>/ServletOi?acao=logout"><%= request.getSession().getAttribute("usuario") %> - Logout(Sair)</a>
	      </form>
	    </div>
	  </div>
	</nav>
</div>
<div class="container">
	<h2>
<%= request.getSession().getAttribute("usuario") %>   - Apartamento  
<%= request.getSession().getAttribute("apartamento")%>

</h2>

	</div>
	<form action="<%=request.getContextPath()%>/ServletAgenda"
			method="post" id="formAgenda">
	<div class="container">
	<div class="accordion" id="accordionExample">
  <div class="accordion-item">
    <h2 class="accordion-header">
      <button  class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne" onclick="consultarAgenda();">
        Meus Agendamentos
      </button>
    </h2>
    <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
      <div class="accordion-body">
       <div class="row">
       <div class="col">
       <input type="text" placeholder="Data"
		aria-label="data" id="dataBusca" class="form-control" aria-describedby="basic-addon2">
		</div>
		<div class="col">
		<button class="btn btn-success" type="button" onclick="consultarAgenda();">Consultar</button>
		</div>
		</div>
		<br>
        <table id="tableData" class="table table-bordered">
		<thead>
			<tr>
				<th scope="col">ID</th>
				<th scope="col">Data</th>
				<th scope="col">Hora</th>
				<th scope="col">Opção</th>
			</tr>
		</thead>
		<tbody>

		</tbody>
	</table>
      </div>
      <span id="totalResultados"></span>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
        Fazer Agendamento
      </button>
    </h2>
    <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <label for="formGroupExampleInput" class="form-label">Data e hora: </label>
        <input type="date" name="data"  id = "data" value="${data1.data}">
        <input type="time" name="hora" id = "hora"   value="${data1.hora}">
        <input type="hidden" name="acao" id="acao" value="">
        <button type="submit" class="btn btn-success">Agendar</button>
      </div>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree" onclick="listarAgenda();">
        Listagem da Agendamentos
      </button>
    </h2>
    <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
      <div class="accordion-body">
		<table id="tableAgenda" class="table table-bordered">
		<thead>
			<tr>
				<th>Data</th>
				<th>Hora</th>
				<th>Código</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
      </div>
    </div>
  </div>
</div>
</div>
</form>

	<script type="text/javascript">

	function listarAgenda(){
		var urlAction = document.getElementById("formAgenda").action;
		
		$.ajax({
			
			method: "get",
		    url : urlAction,
		    data :'&acao=listar',
		    success: function (response) {
			
		    	var json = JSON.parse(response);
		    	$('#tableAgenda > tbody > tr').remove();
		    	for (var x = 0; x < json.length; x++){
		    		$('#tableAgenda > tbody').append('<tr><td>'+json[x].data+'</td><td>'+json[x].hora+'</td><td>'+json[x].id+'</td></tr>')
		    	}
		    				}
		
		}).fail(function(xhr, status, errorThrown){
			    alert('Erro ao listar: ' + xhr.responseText);
		});
	}
	
	function apagarAgenda(){
		if(confirm("Deseja cancelar?")){
			document.getElementById("formAgenda").method = 'get';
			document.getElementById("acao").value = 'deletar';
			document.getElementById("formAgenda").submit();
		}
	}
	
	function consultarAgenda() {
		var dataBusca = document.getElementById('dataBusca').value;
		
		if (dataBusca != null && dataBusca != '' && dataBusca.trim() != ''){
			var urlAction = document.getElementById("formAgenda").action;
			
			$.ajax({
				
				method: "get",
			    url : urlAction,
			    data : "dataBusca=" + dataBusca + '&acao=consultar',
			    success: function (response) {
				
			    	var json = JSON.parse(response);
			    	$('#tableData > tbody > tr').remove();
			    	for (var x = 0; x < json.length; x++){
			    		$('#tableData > tbody').append('<tr><td>'+json[x].id+'</td><td>'+json[x].data+'</td><td>'+json[x].hora+'</td><td><button onclick="apagarAgenda('+json[x].id+')" type="button" class="btn btn-danger">Cancelar</button></tr>')
			    	}
			    	document.getElementById('totalResultados').textContent = 'Resultados: ' + json.length;
				}
			
			}).fail(function(xhr, status, errorThrown){
				    alert('Erro ao consultar: ' + xhr.responseText);
			});
		}
	}

</script>
</body>
</html>