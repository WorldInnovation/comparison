<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--<spring:htmlEscape defaultHtmlEscape="true" />--%>

<c:url value="/comparison/add" var="compareUrl"/>
<c:url value="/comparison/get" var="compareUrlGet"/>
<c:url value="/comparison/delete" var="compareUrlCategoryDelete"/>
<c:url value="/comparison/compare" var="compareUrlCategoryCompare"/>

<div class="yCmsComponent">

        <div id="comparisonComponent" data-compare-url="${compareUrl}"
             data-compare-url-get="${compareUrlGet}" data-compare-url-category-delete="${compareUrlCategoryDelete}"
             data-compare-url-category-compare="${compareUrlCategoryCompare}"
             class="js-header-popup no-decoration hover header-link header-comparison">

            <div class="dropdown show">
                <c:if test="${shownProductCount > 0}">
                <span class="comparison-count">${shownProductCount}</span>
            </c:if>
                <a class="btn btn-secondary dropdown-toggle" role="button" id="dropdownMenuLinkComparison" data-toggle="dropdown"
                   href="/comparisonstorefront/electronics/en/comparison/"
                   aria-haspopup="true" aria-expanded="false">
                    <img src="${comparisonImage}">
                </a>

                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="btn btn-secondary dropdown-item" role="button" data-toggle="dropdown"
                       href="/comparisonstorefront/electronics/en/comparison/"
                       aria-haspopup="true" aria-expanded="false">
                        <spring:message code="fscomparisonaddon.page.comparison.component"/>
                    </a>
                    <c:forEach var="comparison" items="${comparisonCategories}">
                        <a href="/comparisonstorefront/electronics/en/comparison/compare/${comparison.code}"
                           class="comparisonCategoryCompare dropdown-item" data-compare-category-code= ${comparison.code}>
                                ${comparison.name} (${fn:length(comparison.products)})
                        </a>
                        <a href="javascript:void(0);" class="comparisonCategoryLinkClose glyphicon glyphicon-remove dropdown-item"
                           data-compare-category-code=${comparison.code}>
                        </a><br>
                    </c:forEach>
                </div>
            </div>
        </div>

</div>
