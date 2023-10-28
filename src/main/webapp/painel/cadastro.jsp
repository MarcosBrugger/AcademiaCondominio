<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastro Administrativo</title>
	<jsp:include page="bootstrap.jsp"></jsp:include>
</head>
<body>
	<h1 style="text-align: center;">Painel Administrativo do Site - Cadastro de Usuários</h1>
<div class="container">
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
	  <div class="container-fluid">
	    <div class="collapse navbar-collapse" id="navbarSupportedContent">
	      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
	        <li class="nav-item">
	          <a class="nav-link active" aria-current="page" href="<%= request.getContextPath() %>/reserva.jsp">Home</a>
	        </li>
	      </ul>
	      <form class="d-flex" role="search">
	        <a class="nav-link" href="<%= request.getContextPath() %>/ServletOi?acao=logout"><%= request.getSession().getAttribute("usuario") %> - Logout(Sair)</a>
	      </form>
	    </div>
	  </div>
	</nav>
</div>	
</body>
</html>