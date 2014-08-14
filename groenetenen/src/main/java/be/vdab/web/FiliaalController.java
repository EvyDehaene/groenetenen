package be.vdab.web;

import java.util.logging.Logger;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import be.vdab.entities.Filiaal;
import be.vdab.exceptions.FiliaalHeeftNogWerknemersException;
import be.vdab.services.FiliaalService;
import be.vdab.valueobjects.PostcodeReeks;

@Controller
@RequestMapping("/filialen")
public class FiliaalController {
	private static final String FILIALEN_VIEW = "filialen/filialen";
	private static final String TOEVOEGEN_VIEW = "filialen/toevoegen";
	@RequestMapping(method=RequestMethod.GET)
	ModelAndView findAll() {
		  return new ModelAndView(FILIALEN_VIEW, "filialen", filiaalService.findAll()).addObject("aantalFilialen",
				  filiaalService.findAantalFilialen());
		}
	@RequestMapping(value="toevoegen", method=RequestMethod.GET)
	ModelAndView createForm(){
		return new ModelAndView (TOEVOEGEN_VIEW, "filiaal", new Filiaal());
	}
	private static final String REDIRECT_URL_NA_TOEVOEGEN = "redirect:/filialen";
	//importeer Logger uit de package java.util.logging
	@RequestMapping(method = RequestMethod.POST)
	public String create(@Valid Filiaal filiaal, BindingResult bindingResult) {
	  if (bindingResult.hasErrors()) {
	    return TOEVOEGEN_VIEW;
	  }
	  filiaalService.create(filiaal);
	  return REDIRECT_URL_NA_TOEVOEGEN;
	} 
	private final FiliaalService filiaalService;
	@Autowired
	FiliaalController(FiliaalService filiaalService){
		//Spring injecteert de parameter filiaalService met de bean die de interface FiliaalService implementeert: FiliaalServiceImpl
		this.filiaalService=filiaalService;
	}
	private static final String FILIAAL_VIEW = "filialen/filiaal";
	@RequestMapping(value="{id}", method=RequestMethod.GET)
	ModelAndView read(@PathVariable long id){
		return new ModelAndView(FILIAAL_VIEW, "filiaal", filiaalService.read(id));
	}
	private static final String REDIRECT_URL_FILIAAL_NIET_GEVONDEN = "redirect:/filialen";
	private static final String REDIRECT_URL_NA_VERWIJDEREN = "redirect:/filialen/{id}/verwijderd";
	private static final String REDIRECT_URL_HEEFT_NOG_WERKNEMERS="redirect:/filialen/{id}";
	@RequestMapping(value="{id}/verwijderen", method=RequestMethod.POST)
	String delete(@PathVariable long id, RedirectAttributes redirectAttributes){
		Filiaal filiaal = filiaalService.read(id);
		if (filiaal == null){
			return REDIRECT_URL_FILIAAL_NIET_GEVONDEN;
		}
		try {
			filiaalService.delete(id);
			redirectAttributes.addAttribute("id", id).addAttribute("naam", filiaal.getNaam());
			return REDIRECT_URL_NA_VERWIJDEREN;
		} catch (FiliaalHeeftNogWerknemersException ex){
			redirectAttributes.addAttribute("id", id).addAttribute("fout", "Filiaal heeft nog werknemers");
			return REDIRECT_URL_HEEFT_NOG_WERKNEMERS;
		}
	}
	private static final String VERWIJDERD_VIEW = "filialen/verwijderd";
	@RequestMapping(value="{id}/verwijderd", method=RequestMethod.GET)
	ModelAndView deleted (String naam) {
		return new ModelAndView(VERWIJDERD_VIEW, "naam", naam);
	}
	private static final String PER_POSTCODE_VIEW = "filialen/perpostcode";
	@RequestMapping(value="perpostcode", method=RequestMethod.GET)
	ModelAndView findByPostcodeReeks() {
		PostcodeReeks reeks = new PostcodeReeks();
		return new ModelAndView(PER_POSTCODE_VIEW, "postcodeReeks", reeks);
	}
	@RequestMapping(method=RequestMethod.GET, params={"vanpostcode", "totpostcode"})
	ModelAndView findByPostcodeReeks(@Valid PostcodeReeks reeks, BindingResult bindingResult){
		ModelAndView modelAndView = new ModelAndView(PER_POSTCODE_VIEW);
		if (! bindingResult.hasErrors()){
			Iterable<Filiaal> filialen = filiaalService.findByPostcodeReeks(reeks);
			if (filialen.iterator().hasNext()){
				modelAndView.addObject("filialen",  filialen);
			}
			else
			{
				bindingResult.reject("geenFilialen");
			}
		}
		return modelAndView;
	}
	private static final String WIJZIGEN_VIEW = "filialen/wijzigen";
	@RequestMapping(value ="{id}/wijzigen", method = RequestMethod.GET)
	ModelAndView updateForm(@PathVariable long id) {
	  Filiaal filiaal = filiaalService.read(id);
	  if (filiaal == null) {
	    return new ModelAndView(REDIRECT_URL_FILIAAL_NIET_GEVONDEN);
	  }
	  return new ModelAndView(WIJZIGEN_VIEW, "filiaal", filiaal);
	}
	private static final String REDIRECT_URL_NA_WIJZIGEN = "redirect:/filialen";
	@RequestMapping(value = "{id}", method = RequestMethod.POST)
	String update(@Valid Filiaal filiaal, BindingResult bindingResult) {
	  if (bindingResult.hasErrors()) {
	    return WIJZIGEN_VIEW;
	  }
	  filiaalService.update(filiaal);
	  return REDIRECT_URL_NA_WIJZIGEN;
	} 
}
