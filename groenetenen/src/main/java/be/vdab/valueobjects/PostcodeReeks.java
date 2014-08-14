package be.vdab.valueobjects;

public class PostcodeReeks {
	private Integer vanpostcode;
	private Integer totpostcode;
	//Je maakt getters en setters voor de private variabelen
	public boolean bevat(Integer postcode){
		//bevat de reeks een bepaalde postcode ? (wordt gebruikt in de DAO layer)
		return postcode >= vanpostcode && postcode <= totpostcode;
	}
	public Integer getVanpostcode() {
		return vanpostcode;
	}
	public void setVanpostcode(Integer vanpostcode) {
		this.vanpostcode = vanpostcode;
	}
	public Integer getTotpostcode() {
		return totpostcode;
	}
	public void setTotpostcode(Integer totpostcode) {
		this.totpostcode = totpostcode;
	}
	
}
