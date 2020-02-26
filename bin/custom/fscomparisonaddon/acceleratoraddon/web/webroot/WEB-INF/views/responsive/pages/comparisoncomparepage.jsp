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

<template:page pageTitle="Compare">
    <div class="large-11 medium-12 columns product-gallery">
    <div id="comparisonCompare" data-compare-url="${compareUrl}"
         data-compare-url-get="${compareUrlGet}" data-compare-url-category-delete="${compareUrlCategoryDelete}"
         data-compare-url-category-compare="${compareUrlCategoryCompare}"
         class="js-header-popup no-decoration hover header-link header-comparison">

        <table class="zui-table">
            <thead>
            <caption>
                <h4>
                    Compare page
                    <a href="javascript:void(0);" class="comparisonCategoryLinkClose glyphicon glyphicon-remove"
                       data-compare-category-code=${comparison.code}>
                        <spring:theme code="text.address.delete"/>
                    </a>
                </h4>
            </caption>
            <tr>
                <th>Url</th>
                <th>Name</th>
                <th>Code</th>
                <th>CategoryCode</th>
                <th>CategoryName</th>
                <th>CategoryUrl</th>
                <th>BrandNumber</th>
                <th>BrandName</th>
                <th>CategoryChain</th>
            </tr>
            </thead>
            <tbody id="comparisonTable">

                <c:forEach var="productData" items="${compare}">
                <tr>
                    <td>
                        <div data-compare-url="${compareUrl}"
                             data-compare-url-get="${compareUrlGet}" data-compare-url-category-delete="${compareUrlCategoryDelete}"
                             >
                            <a href="javascript:void(0)" class="comparisonItemLinkClose glyphicon glyphicon-remove"
                               data-compare-category-code=${productData.code}>
                            </a>
                        </div>
                        <div>
                            <c:url value="${productData.url}" var="show"/>
                            <a class="btn" href="${fn:escapeXml(show)}">
                                <spring:theme code="review.show.more" />
                            </a>
                        </div>
                    </td>
                    <td>
                            ${productData.name}
                    </td>
                    <td>${productData.code}</td>

                    <c:forEach var="categoryFeature" items="${productData.categories}">
                        <td>
                                ${categoryFeature.code}
                        </td>
                        <td>
                                ${categoryFeature.name}
                        </td>
                        <td>
                                ${categoryFeature.url}
                        </td>

                    </c:forEach>

                    <c:forEach var="classifications" items="${productData.classifications}">
                        <td>
                               Name: ${classifications.name}
                            <c:forEach var="classificationFeature" items="${classifications.features}">
                                Feature: ${classificationFeature.name}
                                (
                                <c:forEach var="featureValue" items="${classificationFeature.featureValues}">
                                    ${empty featureValue.value ? '-' : featureValue.value},
                                </c:forEach>

                                )
                            </c:forEach>

                        </td>

                    </c:forEach>

                </tr>
                </c:forEach>

            </tbody>
        </table>

    </div>
</template:page>




