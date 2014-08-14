package be.vdab.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import be.vdab.dao.FiliaalDAO;
import be.vdab.entities.Filiaal;
import be.vdab.exceptions.FiliaalHeeftNogWerknemersException;
import be.vdab.valueobjects.PostcodeReeks;

@Service //met deze annotation maak je een Spring bean van deze class
class FiliaalServiceImpl implements FiliaalService{
	private final FiliaalDAO filiaalDAO;
	@Autowired
	FiliaalServiceImpl(FiliaalDAO filiaalDAO){
		//Spring injecteert de parameter filiaalDAO met de bean die de interface FiliaalDAO implementeert
		this.filiaalDAO=filiaalDAO;
	}
	@Override
	public void create(Filiaal filiaal){
		filiaalDAO.create(filiaal);
	}
	@Override
	public Filiaal read(long id){
		return filiaalDAO.read(id);
	}
	@Override
	public void update(Filiaal filiaal){
		filiaalDAO.update(filiaal);
	}
	@Override
	public void delete(long id){
		if(filiaalDAO.findAantalWerknemers(id)!= 0){
			throw new FiliaalHeeftNogWerknemersException();
		}
		filiaalDAO.delete(id);
	}
	@Override
	public Iterable<Filiaal> findAll(){
		return filiaalDAO.findAll();
	}
	@Override
	public long findAantalFilialen(){
		return filiaalDAO.findAantalFilialen();
	}
	@Override
	public Iterable<Filiaal> findByPostcodeReeks(PostcodeReeks reeks){
		return filiaalDAO.findByPostcodeReeks(reeks);
	}
	
}
