package model;

public class Usuario {

	private Long id;
	private String usuario;
	private String senha;
	private String apartamento;

	public boolean ehNovo() {
		if (this.id == null) {
			return true;
		}else if (this.id != null && this.id > 0) {
			return false;
		}
		return id == null;
}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public String getApartamento() {
		return apartamento;
	}

	public void setApartamento(String apartamento) {
		this.apartamento = apartamento;
	}
}