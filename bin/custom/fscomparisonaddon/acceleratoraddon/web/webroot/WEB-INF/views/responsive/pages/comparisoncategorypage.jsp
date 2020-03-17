<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:url value="/comparison/add" var="compareUrl"/>
<c:url value="/comparison/get" var="compareUrlGet"/>
<c:url value="/comparison/delete" var="compareUrlCategoryDelete"/>
<c:url value="/comparison/deleteProduct" var="compareUrlProductDelete"/>
<c:url value="/comparisonstorefront/electronics/en/Brands/c/brands" var="compareUrlBrands"/>

<%--<%@ taglib prefix="template" tagdir="/WEB-INF/tags/addons/fscomparisonaddon/responsive/template" %>--%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>

<template:page pageTitle="Compare">
    <div
         class="js-header-popup no-decoration hover header-link header-comparison">
        <table  class="zui-table" data-compare-url="${compareUrl}"
                data-compare-url-get="${compareUrlGet}" data-compare-url-category-delete="${compareUrlCategoryDelete}"
                data-compare-url-product-delete="${compareUrlProductDelete}"
                data-compare-url-category-compare="${compareUrlCategoryCompare}"
                data-compare-url-brands="${compareUrlBrands}">
            <caption>
                <h3>${comparisonList}</h3>
            </caption>

            <c:forEach var="categoryData" items="${comparisonCategories}">

                <tr>
                    <th>
                        <p>${categoryData.name}</p>
                            <%--
                                                                <button type="button" class="btn-enter btn btn-primary btn-block"><spring:message code="fscomparisonaddon.page.compare.products"/></button>
                            --%>
                        <a href="/comparisonstorefront/electronics/en/comparison/compare/${categoryData.code}"
                           class="comparisonCategoryCompare" data-compare-category-code= ${categoryData.code}>
                            <spring:message code="fscomparisonaddon.page.compare.products"/>
                        </a>

                    </th>

                    <c:forEach var="productData" items="${categoryData.products}">
                        <td id="comparison-product-column-${productData.code}">
                            <h3>
                                <div data-compare-url="${compareUrl}"
                                     data-compare-url-get="${compareUrlGet}"
                                     data-compare-url-category-delete="${categoryData.name}">
                                    <a href="javascript:void(0)" class="comparisonProductDelete glyphicon glyphicon-remove"
                                       data-compare-product-code=${productData.code}>
                                    </a>
                                </div>
                                <div class="owl-item" style="width: 94px;">
                                    <a href="#" class="item">
                                        <c:forEach var="imageLink" items="${productData.images}" varStatus="status">
                                            <c:if test="${status.last}">
                                                <img class="lazyOwl" src="${imageLink.url}">
                                            </c:if>
                                        </c:forEach>
                                    </a>

                                </div>
                            </h3>
                            <div>
                                <c:url value="${productData.url}" var="show"/>
                                <a class="btn" href="${fn:escapeXml(show)}">
                                        ${productData.name}
                                </a>
                            </div>
                        </td>

                    </c:forEach>
                    </tr>


                </c:forEach>
              </table>

    </div>
</template:page>
