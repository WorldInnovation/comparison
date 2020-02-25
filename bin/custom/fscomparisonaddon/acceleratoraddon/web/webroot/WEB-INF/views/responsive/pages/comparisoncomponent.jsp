<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:url value="/comparison/add" var="compareUrl"/>
<c:url value="/comparison/get" var="compareUrlGet"/>
<c:url value="/comparison/delete" var="compareUrlCategoryDelete"/>

<%--<%@ taglib prefix="template" tagdir="/WEB-INF/tags/addons/fscomparisonaddon/responsive/template" %>--%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>

<%--<template:page pageTitle="Compare">--%>
<div data-compare-url="${compareUrl}"
     data-compare-url-get="${compareUrlGet}" data-compare-url-category-delete="${compareUrlCategoryDelete}"
     class="js-header-popup no-decoration hover header-link header-comparison">
    <H3>Hello Component</H3>
    <c:forEach var="item" items="${compare}" >
        <div>
            ProductName: ${item.name}<br>
            ProductCode: ${item.code}<br>
        </div>
        <a  href="javascript:void(0)" class="comparisonCategoryLinkClose glyphicon glyphicon-remove"
            data-compare-category-code = ${item.code} >
        </a><br>
    </c:forEach>
</div>
