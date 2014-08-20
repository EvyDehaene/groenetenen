package be.vdab.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import be.vdab.dao.FiliaalDAO;
import be.vdab.entities.Filiaal;
import be.vdab.exceptions.FiliaalHeeftNogWerknemersException;
import be.vdab.valueobjects.PostcodeReeks;

@Service //met deze annotation maak je een Spring bean van deze class
@Transactional(readOnly = true)
class FiliaalServiceImpl implements FiliaalService{
	private final FiliaalDAO filiaalDAO;
	@Autowired
	FiliaalServiceImpl(FiliaalDAO filiaalDAO){
		//Spring injecteert de parameter filiaalDAO met de bean die de interface FiliaalDAO implementeert
		this.filiaalDAO=filiaalDAO;
	}
	@Override
	@Transactional(readOnly = false)
	public void create(Filiaal filiaal){
		filiaalDAO.create(filiaal);
	}
	@Override
	public Filiaal read(long id){
		return filiaalDAO.read(id);
	}
	@Override
	@Transactional(readOnly = false)
	public void update(Filiaal filiaal){
		filiaalDAO.update(filiaal);
	}
	@Override
	@Transactional(readOnly = false)
	public void delete(long id){
		Filiaal filiaal = filiaalDAO.read(id);
		if (filiaal != null) {
			if (! filiaal.getWerknemers().isEmpty()) {
				throw new FiliaalHeeftNogWerknemersException();
			}
			filiaalDAO.delete(id);
		}
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
