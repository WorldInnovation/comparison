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
            <c:if test="${shownProductCount > 0}">
                <span class="comparison-count">${shownProductCount}</span>
            </c:if>
            <span class="header-link-icon">
                            <img src="/_ui/responsive/common/images/comparison.svg">
    </span>
<%-- look on 7
           <div class="${navigationClass} js-${navigationClass} display-none NAVcompONENT" data-title="Compare">
                <nav class="${navigationClass}__child-wrap display-none">
                    <c:if test="${not empty component.navigationNode.title }">
                        <div>
                            <c:out value="COMPARE"/>
                        </div>
                    </c:if>
                    <div id="headerComparison" data-product-code="${productCode}" >
                        <cms:pageSlot position="Comparison" var="component">
                            Compare
                            <cms:component component="${component}"/>
                        </cms:pageSlot>
                    </div>
                </nav>
            </div>--%>
            <div class="popup-header-link" style="top: 60px;">

                <c:forEach var="comparison" items="${comparisonCategories}">
                    <a href="/comparisonstorefront/electronics/en/comparison/compare/${comparison.code}"
                       class="comparisonCategoryCompare" data-compare-category-code= ${comparison.code}>
                            ${comparison.name} (${fn:length(comparison.products)})
                    </a>
                    <a href="javascript:void(0);" class="comparisonCategoryLinkClose glyphicon glyphicon-remove"
                       data-compare-category-code=${comparison.code}>
                    </a><br>
                </c:forEach>
            </div>
        </div>

</div>
