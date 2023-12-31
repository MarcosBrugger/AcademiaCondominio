package conexao;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexaoBanco {
	private static String banco = "jdbc:mysql://localhost:3306/uc9_20221_4?useTimezone=true&serverTimezone=UTC";
	private static String usuario = "usuario";
	private static String senha = "1a2b3c4d5e6f";
	private static Connection conn = null;
	
	public static Connection getConnection(){
		return conn;
	}
	
	static {
		conectar();
	}
	
	public ConexaoBanco() {
		conectar();
	}
	
	private static void conectar() {
		try {
			if (conn == null) {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection(banco, usuario, senha);
				conn.setAutoCommit(false);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
}
