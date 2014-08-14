package be.vdab.valueobjects;

import javax.validation.constraints.AssertTrue;
import javax.validation.constraints.NotNull;

import be.vdab.constraints.Postcode;

public class PostcodeReeks {
	@NotNull @Postcode
	private Integer vanpostcode;
	@NotNull @Postcode
	private Integer totpostcode;
	//Je maakt getters en setters voor de private variabelen
	public boolean bevat(Integer postcode){
		//bevat de reeks een bepaalde postcode ? (wordt gebruikt in de DAO layer)
		return postcode >= vanpostcode && postcode <= totpostcode;
	}
	public Integer getVanpostcode() {
		return vanpostcode;
	}
	public Integer getTotpostcode() {
		return totpostcode;
	}
	public void setVanpostcode(Integer vanpostcode) {
		this.vanpostcode = vanpostcode;
	}
	public void setTotpostcode(Integer totpostcode){
		this.totpostcode=totpostcode;
	}
	@AssertTrue
	public boolean isTotpostcodeIsGroterOfGelijkAanVanpostcode() {
		return vanpostcode != null && totpostcode != null && totpostcode >= vanpostcode;
	}
}
