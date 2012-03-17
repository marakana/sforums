<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="f" uri="/WEB-INF/functions.tld"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
  <head>
    <title>User Form</title>
    <jsp:include page="htmlHead.jsp"/>
  </head>
  <body>
    <jsp:include page="navBar.jsp"/>
    <h1>User Form</h1>
    <form:form commandName="userAndPassword">
      <table>
    	<c:if test="${param.updated eq 'true'}">
    	  <tr>
    	    <th></th>
    	    <td><strong>Updated</strong></td>
    	  </tr>
   	    </c:if>
        <spring:hasBindErrors name="userAndPassword">
          <tr>
            <th></th>
            <td class="error">
              Form Errors<br/>
              <form:errors/>
            </td>
          </tr>
        </spring:hasBindErrors>
        <c:if test="${userAndPassword.user.idSet}">
          <tr>
            <th>ID:</th>
            <td>${userAndPassword.user.id}</td>
          </tr>
        </c:if>
        <spring:nestedPath path="user">
          <spring:nestedPath path="name">
	        <tr>
	          <th><form:label path="first">First Name</form:label> *:</th>
	          <td>
	            <form:input path="first" />
	            <form:errors path="first" cssClass="error"/>
	          </td>
	        </tr>
	        <tr>
	          <th><form:label path="last">Last Name</form:label> *:</th>
	          <td>
	            <form:input path="last" />
	            <form:errors path="last" cssClass="error"/>
	          </td>
	        </tr>
          </spring:nestedPath>
          <tr>
            <th><form:label path="organization">Organization</form:label>:</th>
            <td>
              <form:input path="organization" />
              <form:errors path="organization" cssClass="error"/>
            </td>
          </tr>
          <tr>
            <th><form:label path="title">Title</form:label>:</th>
            <td>
              <form:input path="title" />
              <form:errors path="title" cssClass="error"/>
            </td>
          </tr>
          <tr>
            <th><form:label path="email">Email</form:label> *:</th>
            <td>
              <form:input path="email" />
              <form:errors path="email" cssClass="error"/>
            </td>
          </tr>
          <security:authorize ifAllGranted="ROLE_ADMIN">
            <c:if test="${not profile}">
              <tr>
                <th><form:label path="enabled">Enabled</form:label> *:</th>
                <td>
                  <form:radiobutton path="enabled" value="true" /> Yes
                  &nbsp;&nbsp;&nbsp;
                  <form:radiobutton path="enabled" value="false" /> No
                  <form:errors path="enabled" cssClass="error" />
                </td>
              </tr>
              <tr>
                <th><form:label path="admin">Admin</form:label> *:</th>
                <td>
                  <form:radiobutton path="admin" value="true" /> Yes
                  &nbsp;&nbsp;&nbsp;
                  <form:radiobutton path="admin" value="false" /> No
                  <form:errors path="admin" cssClass="error" />
                </td>
              </tr>
            </c:if>
          </security:authorize>
        </spring:nestedPath>
        <c:set var="passwordRequired" value="${userAndPassword.user.idSet? '' : '*'}"/>
        <tr>
          <th><form:label path="password">Password</form:label> ${passwordRequired}:</th>
          <td>
            <form:password path="password" />
            <form:errors path="password" cssClass="error"/>
          </td>
        </tr>
        <tr>
          <th><form:label path="passwordVerification">Password Verification</form:label> ${passwordRequired}:</th>
          <td>
            <form:password path="passwordVerification" />
            <form:errors path="passwordVerification" cssClass="error"/>
          </td>
        </tr>
        <tr>
          <th>&nbsp;</th>
          <td>
            <input type="submit" value="Save"/>
          </td>
        </tr>
      </table>
    </form:form>
  </body>
</html>