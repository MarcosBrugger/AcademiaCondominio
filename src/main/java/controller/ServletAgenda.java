package controller;


import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.AgendaRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Agenda;



public class ServletAgenda extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private AgendaRepository agendaRepository = new AgendaRepository();
	
    public ServletAgenda() {

    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	try {
			String acao = request.getParameter("acao");
			
			if (acao != null && !acao.isEmpty() & acao.equalsIgnoreCase("deletar")) {
				
				String dataId = request.getParameter("id");
				
				agendaRepository.deletarAgenda(dataId);
				request.setAttribute("msg", "Excluído com Sucesso!!!");
				request.getRequestDispatcher("reserva.jsp").forward(request, response);
			
			
			}else if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("consultar")) {
				
				String data = request.getParameter("dataBusca");
				List<Agenda> dadosAgenda = agendaRepository.consultarAgendaLista(data);
				ObjectMapper mapa = new ObjectMapper();
				String json = mapa.writeValueAsString(dadosAgenda);
				response.getWriter().write(json);	
				
			
			}else if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarEditar")) {
				
				String id = request.getParameter("id");
				Agenda data1 = agendaRepository.consultarAgendaID(id);
				
				request.setAttribute("msg", "Usuário em Edição!!!");
				request.setAttribute("data1", data1);
				request.getRequestDispatcher("reserva.jsp").forward(request, response);	
				
				
			}else if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listar")) {
				
				String id = request.getParameter("id");
				List<Agenda> dadosAgenda = agendaRepository.listaAgenda(id);
				ObjectMapper mapa = new ObjectMapper();
				String json = mapa.writeValueAsString(dadosAgenda);
				response.getWriter().write(json);
				
			}else {
				request.getRequestDispatcher("reserva.jsp").forward(request, response);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			RequestDispatcher redireciona = request.getRequestDispatcher("painel/erros.jsp");
			request.setAttribute("msg", e.getMessage());
			redireciona.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String mensagem = "Reserva realizada com Sucesso!!";
			String id = request.getParameter("id");
			String data = request.getParameter("data");
			String hora = request.getParameter("hora");
			
			Agenda data1 = new Agenda();
			
			data1.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			data1.setData(data);
			data1.setHora(hora);
			
			if (agendaRepository.verificaAgenda(data1.getData(), data1.getHora()) && data1.getId() == null) {
				
				mensagem = "Reserva Realizada!!!";
				
			}else {
				
				if (data1.ehNovo()) {
					
					mensagem = "Gravado com Sucesso!!";
					
				}else {
					
					mensagem = "Atualizado com Sucesso!!";
					
				}
				data1 = agendaRepository.insereAgenda(data1);
			}
			
			request.setAttribute("msg", mensagem);
			request.setAttribute("data1", data1);
			request.getRequestDispatcher("reserva.jsp").forward(request, response);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			RequestDispatcher redireciona = request.getRequestDispatcher("painel/erros.jsp");
			request.setAttribute("msg", e.getMessage());
			redireciona.forward(request, response);
		}
	}

}
    
    
    

