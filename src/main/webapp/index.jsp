<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>
<body>
<p style="text-align:center;">
	<img src="https://cursos.sesisenai.org.br/images/logos/sesi-senai.webp" alt="Logo Senai" width="600" height="100">
	</p>
	<br>	
	<h1 style="text-align:center;">MaxSystem Academias</h1>
<div class="container">
	<form action="ServletOi" method="post">
	  <div class="mb-3">
	    <label for="exampleInputEmail1" class="form-label">Usuario</label>
	    <input type="text" name="usuario" class="form-control" id="exampleInputEmail1" aria-describedby="usuarioHelp">
	  </div>
	  <div class="mb-3">
	    <label for="exampleInputPassword1" class="form-label">Senha</label>
	    <input type="password" name="senha" class="form-control" id="exampleInputPassword1">
	  </div>
	  <button type="submit" class="btn btn-primary">Login</button>
	</form>
	<h4>${msg}</h4>
	<br>
 <br>
 <br>
    <footer style="text-align:center;">
                   <p> Desenvolvimento de Sistemas 2023 - Grupo 1</p>
      
 			         		       <p>Aldir Newe </p>
			           		<p>Leonardo Sopranzetti Lara</p>
			        	  <p>Marcos Vinicius Motta Brugger</p>

    </footer>
</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</body>
</html>