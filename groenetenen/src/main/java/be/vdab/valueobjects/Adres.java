package be.vdab.valueobjects;

import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.SafeHtml;
@Embeddable
public class Adres {
	@NotBlank
	@SafeHtml
	private String straat;
	@NotBlank
	@SafeHtml
	private String huisNr;
	@NotNull
	@NotBlank
	private Integer postcode;
	@NotBlank
	@SafeHtml
	private String gemeente;
	public Adres(){}
	public Adres(String straat, String huisNr, Integer postcode, String gemeente){
		this.straat=straat;
		this.huisNr=huisNr;
		this.postcode=postcode;
		this.gemeente=gemeente;
	}
	//Je maakt getters en setters voor de private vars.
	public String getStraat() {
		return straat;
	}
	public void setStraat(String straat) {
		this.straat = straat;
	}
	public String getHuisNr() {
		return huisNr;
	}
	public void setHuisNr(String huisNr) {
		this.huisNr = huisNr;
	}
	public Integer getPostcode() {
		return postcode;
	}
	public void setPostcode(Integer postcode) {
		this.postcode = postcode;
	}
	public String getGemeente() {
		return gemeente;
	}
	public void setGemeente(String gemeente) {
		this.gemeente = gemeente;
	}
	
}
