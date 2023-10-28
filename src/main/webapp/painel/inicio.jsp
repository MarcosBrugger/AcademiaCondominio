<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Inicio</title>
<jsp:include page="bootstrap.jsp"></jsp:include>
</head>
<body>
	<h1 style="text-align: center;">Painel Administrativo</h1>
	<div class="container">
		<nav class="navbar navbar-expand-lg bg-body-tertiary">
			<div class="container-fluid">
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page"
							href="<%=request.getContextPath()%>/reserva.jsp">Home</a></li>
					</ul>
					<form class="d-flex" role="search">
						<a class="nav-link"
							href="<%=request.getContextPath()%>/ServletOi?acao=logout"><%=request.getSession().getAttribute("usuario")%>
							- Logout(Sair)</a>
					</form>
				</div>
			</div>
		</nav>
	</div>



	<div class="container">
		<form action="<%=request.getContextPath()%>/ServletUsuario"
			method="post" id="formUsuario">
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">Código</label>
				<input type="text" name="id" id="id" class="form-control"
					placeholder="Código do Usuário" readonly="readonly"
					value="${user01.id}">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">Usuário</label>
				<input type="text" name="usuario" id="usuario" class="form-control"
					placeholder="Nome do Usuário" value="${user01.usuario}">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput2" class="form-label">Senha</label>
				<input type="password" class="form-control" name="senha" id="senha"
					placeholder="Senha do Usuário" value="${user01.senha}">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput2" class="form-label">Apartamento</label>
				<input type="text" class="form-control" name="apartamento"
					id="apartamento" placeholder="Apartamento"
					value="${user01.apartamento}">
			</div>

			<input type="hidden" name="acao" id="acao" value="">
			<button type="submit" class="btn btn-success">Salvar</button>
			<button type="button" class="btn btn-info" onclick="limparDados();">Novo</button>
			<button type="button" class="btn btn-danger" onclick="apagarUsuario();">Apagar</button>
			
			<button type="button" class="btn btn-warning" data-bs-toggle="modal"
				data-bs-target="#umModal" onclick="listarUsuario();">Relatório</button>
				
			<button type="button" class="btn btn-primary" data-bs-toggle="modal"
				data-bs-target="#doisModal">Consultar Usuário</button>
		</form>
	</div>
	<div class="container">
		<span id="mensagem">${msg}</span>
	</div>

	<div class="modal" id="umModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Lista de Usuários</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">

					<table class="table" id="tableUsuario">
						<thead>
							<tr>
								<th style="text-align:justify;" scope="col">ID</th>
								<th style="text-align:center;" scope="col">Usuário</th>
								<th style="text-align:right;" scope="col">Senha</th>
								<th style="text-align:right;" scope="col">Apartamento</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
				</div>
				<span id="totalResultados"></span>
			</div>
		</div>
	</div>






	<div class="modal" id="doisModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Consultar Usuário</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div class="input-group mb-3">
						<input type="text" class="form-control" placeholder="Nome"
							aria-label="nome" id="nomeBusca" aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button class="btn btn-success" type="button"
								onclick="consultarUsuario();">Consultar</button>
						</div>
						<table class="table" id="tableUsuaio">
							<thead>
								<tr>
									<th scope="col">ID</th>
									<th scope="col">Usuário</th>
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
		</div>
	</div>

	<script type="text/javascript">

	function editarUsuario(id){
		var urlAction = document.getElementById("formUsuario").action;
		window.location.href = urlAction + '?acao=buscarEditar&id='+id;
	}

	function listarUsuario(){
		var urlAction = document.getElementById("formUsuario").action;
		
		$.ajax({
			
			method: "get",
		    url : urlAction,
		    data :'&acao=listarAjax',
		    success: function (response) {
			
		    	var json = JSON.parse(response);
		    	$('#tableUsuario > tbody > tr').remove();
		    	for (var x = 0; x < json.length; x++){
		    		$('#tableUsuario > tbody').append('<tr><td>'+json[x].id+'</td><td>'+json[x].usuario+'<td><td>'+json[x].senha+'</td><td>'+json[x].apartamento+ '</td></tr>')
		    	}
		    	document.getElementById('totalResultados').textContent = 'Resultados: ' + json.length;
			}
		
		}).fail(function(xhr, status, errorThrown){
			    alert('Erro ao listar: ' + xhr.responseText);
		});
	}
		
	
	
		function consultarUsuario() {
		var nomeBusca = document.getElementById('nomeBusca').value;
		
		if (nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != ''){
			var urlAction = document.getElementById("formUsuario").action;
			
			$.ajax({
				
				method: "get",
			    url : urlAction,
			    data : "nomeBusca=" + nomeBusca + '&acao=consultarAjax',
			    success: function (response) {
				
			    	var json = JSON.parse(response);
			    	$('#tableUsuaio > tbody > tr').remove();
			    	for (var x = 0; x < json.length; x++){
			    		$('#tableUsuaio > tbody').append('<tr> <td>'+json[x].id+'</td><td>'+json[x].usuario+'</td><td><button onclick="editarUsuario('+json[x].id+')" type="button" class="btn btn-info">Editar</button></tr>')
			    	}
			    	document.getElementById('totalResultados').textContent = 'Resultados: ' + json.length;
				}
			
			}).fail(function(xhr, status, errorThrown){
				    alert('Erro ao consultar: ' + xhr.responseText);
			});
		}
	}

	function apagarUsuarioAjax() {
		if(confirm("Deseja realemente apagar o Usuário com Ajax")){
			var urlAction = document.getElementById("formUsuario").action;
			var idUser = document.getElementById('id').value;
			
			$.ajax({
				
				method: "get",
			    url : urlAction,
			    data : "id=" + idUser + '&acao=deletarajax',
			    success: function (response) {
					
			    	limparDados();
					document.getElementById('msg').textContent = response;
				}
			
			}).fail(function(xhr, status, errorThrown){
				    alert('Erro ao deletar usuário com Ajax: ' + xhr.responseText);
			});
		}
	}

	function apagarUsuario(){
		if(confirm("Deseja realmente apagar o usuário?")){
			document.getElementById("formUsuario").method = 'get';
			document.getElementById("acao").value = 'deletar';
			document.getElementById("formUsuario").submit();
		}
	}

	function limparDados() {
		var campus = document.getElementById("formUsuario").elements;
		
		for (x=0; x < campus.length; x++){
			campus[x].value = '';
		}
	}

</script>
</body>
</html>