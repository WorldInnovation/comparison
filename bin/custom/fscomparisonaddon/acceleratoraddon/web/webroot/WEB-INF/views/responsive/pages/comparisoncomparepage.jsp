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

<%--<%@ taglib prefix="template" tagdir="/WEB-INF/tags/addons/fscomparisonaddon/responsive/template" %>--%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>

<template:page pageTitle="Compare">
    <div id="comparisonCompare"
         class="js-header-popup no-decoration hover header-link header-comparison">

        <table id="comparisonTable" class="zui-table" data-compare-url="${compareUrl}"
        data-compare-url-get="${compareUrlGet}" data-compare-url-category-delete="${compareUrlCategoryDelete}"
                data-compare-url-product-delete="${compareUrlProductDelete}"
        data-compare-url-category-compare="${compareUrlCategoryCompare}">
            <c:set var="hasName" scope="session" value="0"/>
            <tr>
                <th>
                        ${titleTable}
                </th>
                <c:forEach var="productData" items="${comparison}" >
                    <td id="comparison-product-column-${productData.code}">
                        <h3>
                            <div data-compare-url="${compareUrl}"
                                 data-compare-url-get="${compareUrlGet}"
                                 data-compare-url-category-delete="${compareUrlCategoryDelete}">
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
                            <p>${productData.name}</p>
                            <c:url value="${productData.url}" var="show"/>
                            <a class="btn" href="${fn:escapeXml(show)}">
                                <spring:theme code="review.show.more" />
                            </a>
                        </div>
                    </td>
                </c:forEach>
            </tr>

            <c:set var="hasFeatureName" value="${0}"/>
            <c:forEach var="featureName" items="${featureNames}">
                <tr>
                    <th>${featureName}</th>

                <c:forEach var="productData" items="${comparison}">
                    <c:set var="hasFeatureName" value="${0}"/>
                    <c:forEach var="classifications" items="${productData.classifications}" varStatus="status">
                            <c:forEach var="classificationFeature" items="${classifications.features}">

                                <c:if test="${classificationFeature.name == featureName}">
                                    <td>
                                        <c:forEach var="featureValue" items="${classificationFeature.featureValues}">
                                            <p>
                                                    ${featureValue.value}
                                            </p>
                                        </c:forEach>
                                        <c:set var="hasFeatureName" value="${1}"/>
                                    </td>
                                </c:if>

                            </c:forEach>
                        <c:if test="${status.last}">
                            <c:if test="${hasFeatureName==0}">
                                <td><spring:message code="fscomparisonaddon.page.feature.name.empty"/></td>
                            </c:if>
                        </c:if>
                    </c:forEach>

                </c:forEach>
                </tr>
            </c:forEach>
        </table>

    </div>
</template:page>




