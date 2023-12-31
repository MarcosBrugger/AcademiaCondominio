package controller;

import java.io.IOException;

import dao.LoginRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Usuario;

@WebServlet("/ServletOi")
public class ServletLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private LoginRepository loginRepository = new LoginRepository();
	
	 public ServletLogin() {

	    }

		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String acao = request.getParameter("acao");
			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("logout")) {
				request.getSession().invalidate();
				RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");
				redirecionar.forward(request, response);			
				
			}
			doPost(request, response);
		}

		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String id = request.getParameter("id");
			String login = request.getParameter("usuario");
			String senha = request.getParameter("senha");
			String apartamento = request.getParameter("apartamento");
			String url = request.getParameter("url");
			
			try {
				if (login != null && !login.isEmpty() && senha != null && !senha.isEmpty()) {
					Usuario user01 = new Usuario();
					user01.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
					user01.setUsuario(login);
					user01.setSenha(senha);
					user01.setApartamento(apartamento);
					request.getSession().setAttribute("apartamento", user01.getApartamento());
					
					if (loginRepository.validarLogin(user01)) {
						request.getSession().setAttribute("id", user01.getId());
						request.getSession().setAttribute("usuario", user01.getUsuario());
						request.getSession().setAttribute("apartamento", user01.getApartamento());
										
						if (url == null || url.equals("null")) {
							url = "reserva.jsp";
						}
						RequestDispatcher redirecionar = request.getRequestDispatcher(url);
						redirecionar.forward(request, response);
					}else {
						RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");
						request.setAttribute("msg", "Usuário ou Senha incorretos");
						redirecionar.forward(request, response);
					}
				}else {
					RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");
					request.setAttribute("msg", "Informe o LOGIN e SENHA corretamente");
					redirecionar.forward(request, response);
		 		}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			
		}

	}

