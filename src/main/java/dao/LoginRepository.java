package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import conexao.ConexaoBanco;
import model.Usuario;

public class LoginRepository {
private Connection conn;
	
	public LoginRepository() {
		conn = ConexaoBanco.getConnection();
	}
	
	public boolean validarLogin(Usuario user01) throws Exception{
		String sql = "SELECT * FROM usuario WHERE usuario = ? and senha = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, user01.getUsuario());
		stmt.setString(2, user01.getSenha());
		
		
		ResultSet rst = stmt.executeQuery();
		if (rst.next()) {
			user01.setId(rst.getLong("id"));
			user01.setUsuario(rst.getString("usuario"));
			user01.setSenha(rst.getString("senha"));
			user01.setApartamento(rst.getString("apartamento"));
			return true;
		}
		return false;
	}
	public Usuario selecionarUsuario(String id) throws Exception{
		Usuario user01 = new Usuario();
		
		String sql = "SELECT * FROM usuario WHERE id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setLong(1, Long.parseLong(id));
		ResultSet rst = stmt.executeQuery();
		
		while (rst.next()) {
			user01.setId(rst.getLong("id"));
			user01.setUsuario(rst.getString("usuario"));
			user01.setSenha(rst.getString("senha"));
			user01.setApartamento(rst.getString("apartamento"));
		}
		
		return user01;
	}
	
}
