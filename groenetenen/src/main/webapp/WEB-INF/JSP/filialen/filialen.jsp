<%@page contentType='text/html' pageEncoding='UTF-8' session='false'%>
<%@taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@taglib prefix='v' uri='http://vdab.be/tags' %>
<%@taglib prefix='spring' uri='http://www.springframework.org/tags'%>
<!doctype html>
<html lang='nl'>
<head><v:head title='Filialen'/></head>
<body>
<v:menu/>
<h1><spring:message code="aantalFilialen" arguments="${aantalFilialen}"/></h1>
<c:forEach items='${filialen}' var='filiaal'>
  	<spring:url var='url' value='/filialen'>
  		<spring:param name='id' value='${filiaal.id}'/>
	</spring:url>
<h2><spring:url var='url' value='/filialen/{id}'> (1)
  <spring:param name='id' value='${filiaal.id}'/> (2)
</spring:url></h2> 
  
</c:forEach> 
</body>
</html>