package be.vdab.dao;

import be.vdab.entities.Filiaal;
import be.vdab.valueobjects.PostcodeReeks;

public interface FiliaalDAO {
	void create(Filiaal filiaal);
	Filiaal read(long id);
	void update(Filiaal filiaal);
	void delete(long id);
	Iterable<Filiaal> findAll();
	long findAantalFilialen();
	//het aantal werknemers van een filiaal
	Iterable<Filiaal> findByPostcodeReeks(PostcodeReeks reeks);
}
