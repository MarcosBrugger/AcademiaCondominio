package model;

public class Agenda {

	private int idagenda;
	private String data;
	private String hora;
	
	
	public Agenda() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Agenda(int idagenda, String data, String hora) {
		super();
		this.idagenda = idagenda;
		this.data = data;
		this.hora = hora;
	}
	public int getIdagenda() {
		return idagenda;
	}
	public void setIdagenda(int idagenda) {
		this.idagenda = idagenda;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public String getHora() {
		return hora;
	}
	public void setHora(String hora) {
		this.hora = hora;
	}
	
}
