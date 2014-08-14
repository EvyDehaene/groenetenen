<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form:label path="naam">Naam:<form:errors path="naam"/></form:label>
<form:input path="naam" autofocus="autofocus" required="true"/>
<form:label path="adres.straat">Straat:<form:errors path="adres.straat"/></form:label>
<form:input path='adres.straat' required='true'/>
<form:label path='adres.huisNr'>Huisnr.:<form:errors path='adres.huisNr'/></form:label>
<form:input path='adres.huisNr' required='true'/>
<form:label path='adres.postcode'>Postcode:<form:errors path='adres.postcode'/></form:label>
<form:input path='adres.postcode' required='true' type='number' min='1000' max='9999'/>
<form:label path='adres.gemeente'>Gemeente:<form:errors path='adres.gemeente'/></form:label>
<form:input path='adres.gemeente' required='true'/>
<form:label path='inGebruikName'>Ingebruikname:<form:errors path='inGebruikName'/></form:label>
<form:input path='inGebruikName' required='true'/>
<form:label path='waardeGebouw'>Waarde gebouw:<form:errors path='waardeGebouw'/></form:label>
<form:input path='waardeGebouw' required='true'/>
<div class='rij'><form:checkbox path='hoofdFiliaal' label='Hoofdfiliaal'/></div> 