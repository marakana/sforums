<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="f" uri="/WEB-INF/functions.tld"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
  <head>
    <title>Categories</title>
    <jsp:include page="htmlHead.jsp"/>
  </head>
  <body>
    <jsp:include page="navBar.jsp"/>
    <h1>Categories</h1>
    <c:choose>
      <c:when test="${fn:length(categoryList) == 0}">
        <p>No categories</p>
      </c:when>
      <c:otherwise>
        <table>
          <thead>
            <tr>
              <th class="number">Id</th>
              <th>Name</th>
              <th>Description</th>
              <th>Forums</th>
              <security:authorize ifAllGranted="ROLE_ADMIN">
                <th><em>Actions</em></th>
              </security:authorize>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${categoryList}" var="category">
	           <tr>
                <td class="number">${category.id}</td>
                <td><a href="<c:url value='/category.html?id=${category.id}'/>">${category.name}</a></td>
                <td>${f:trimToLength(category.description, 40)}</td>
                <td class="number">${fn:length(category.forums)}</td>
                <security:authorize ifAllGranted="ROLE_ADMIN">
                  <td class="small">
	                <a class="button" href="<c:url value='/category_form.html?id=${category.id}'/>">Edit</a>
	                <a class="button" href="<c:url value='/category_delete.html?id=${category.id}'/>"
	                  onclick="return confirm('Are you sure you wish to delete this category?');">Delete</a>
                  </td>
				</security:authorize>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </c:otherwise>
    </c:choose>
  </body>
</html>