<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="include/importTags.jsp"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    <h1 class="display-4">Catalogue </h1>

<div class="row" >
    <c:forEach items="${categoriesArticles}" var="categorie">
        <div class="col-sm-6">
            <p class="lead" ><a class="badge badge-secondary" href='<spring:url value="/articles?id=${categorie.id}" />'>
            <c:out value="${categorie.libelle_fr}" />
        </a></p>
        </div>
    </c:forEach>
</div>
<p class="lead"><a class="badge badge-primary" href='<spring:url value="/"/>'>Retour à l'accueil</a></p>
