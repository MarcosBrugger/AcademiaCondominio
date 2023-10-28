package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import conexao.ConexaoBanco;
import model.Agenda;



public class AgendaRepository {
	private Connection conn;

	public AgendaRepository() {
		conn = ConexaoBanco.getConnection();
	}

	public Agenda insereAgenda(Agenda objeto) throws Exception{
		if (objeto.ehNovo()) {
			String sql = "INSERT INTO agenda(data, hora) VALUES(?, ?);";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, objeto.getData());
			stmt.setString(2, objeto.getHora());
			stmt.execute();
			
			conn.commit();	
		}else {
			String sql = "UPDATE agenda SET data=?, hora=? WHERE id = "+objeto.getId()+";";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, objeto.getData());
			stmt.setString(2, objeto.getHora());
			
			stmt.executeUpdate();
			
			conn.commit();

		}
		return this.consultarAgenda(objeto.getData());
	}
		
	public List<Agenda> consultarAgendaLista(String data) throws Exception{
		List<Agenda> listaAgenda = new ArrayList<Agenda>();
		String sql = "SELECT * FROM agenda WHERE data like ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + data + "%");
		ResultSet rst = stmt.executeQuery();
		while (rst.next()) {
			Agenda data1 = new Agenda();
			data1.setId(rst.getLong("id"));
			data1.setData(rst.getString("data"));
			data1.setHora(rst.getString("hora"));
			
			listaAgenda.add(data1);
		}
		return listaAgenda;
	}		
	
	public Agenda consultarAgenda(String data) throws Exception{
			Agenda data1 = new Agenda();
			
			String sql = "SELECT * FROM usuario WHERE usuario = '"+data+"'";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			ResultSet rst = stmt.executeQuery();
			
			while (rst.next()) {
				data1.setId(rst.getLong("id"));
				data1.setData(rst.getString("data"));
				data1.setHora(rst.getString("hora"));
			}
			
			return data1;
		}
	
	public Agenda consultarAgendaID(String id) throws Exception{
		Agenda data1 = new Agenda();
		String sql = "SELECT * FROM agenda WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setLong(1, Long.parseLong(id));
		ResultSet rst = stmt.executeQuery();
		while (rst.next()) {
			data1.setId(rst.getLong("id"));
			data1.setData(rst.getString("data"));
			data1.setHora(rst.getString("hora"));
		
		}
		return data1;
	}
	
	
		public boolean verificaAgenda(String data, String hora) throws Exception{
			String sql = "SELECT COUNT(1) > 0 AS EXISTE FROM agenda where data = '"+data+"' and hora = '"+hora+"';";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			ResultSet res = stmt.executeQuery();
			
			res.next();
			return res.getBoolean("existe");
		}
		
		public void deletarAgenda(String dataId) throws Exception{
			String sql = "DELETE FROM agenda WHERE id = ?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setLong(1, Long.parseLong(dataId));
			stmt.executeUpdate();
			conn.commit();
			
		}
		public List<Agenda> listaAgenda(String id) throws Exception{
			List<Agenda> listaAgenda = new ArrayList<Agenda>();
			String sql = "SELECT * FROM agenda";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rst = stmt.executeQuery();
			while (rst.next()) {
				Agenda data1 = new Agenda();
				data1.setId(rst.getLong("id"));
				data1.setData(rst.getString("data"));
				data1.setHora(rst.getString("hora"));
				
				listaAgenda.add(data1);
			}
			return listaAgenda;
		}
	}
	

