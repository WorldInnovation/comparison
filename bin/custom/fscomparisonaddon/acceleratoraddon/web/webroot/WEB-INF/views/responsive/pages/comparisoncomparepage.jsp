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
    <div id="comparisonCompare"
         class="js-header-popup no-decoration hover header-link header-comparison">

        <c:set var="classificationSizeMapping" scope="session" value="${['0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19']}"/>
        <table id="comparisonTable" class="zui-table" data-compare-url="${compareUrl}"
        data-compare-url-get="${compareUrlGet}" data-compare-url-category-delete="${compareUrlCategoryDelete}"
        data-compare-url-category-compare="${compareUrlCategoryCompare}">
            <tr>
                <th>Items Compare</th>
                <c:forEach var="productData" items="${compare}" >

                    <td>
                        <h2>
                            <div data-compare-url="${compareUrl}"
                                 data-compare-url-get="${compareUrlGet}"
                                 data-compare-url-category-delete="${compareUrlCategoryDelete}">
                            <a href="javascript:void(0)" class="comparisonItemLinkClose glyphicon glyphicon-remove"
                               data-compare-category-code=${productData.code}>
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
                            <div>
                                <c:url value="${productData.url}" var="show"/>
                                <a class="btn" href="${fn:escapeXml(show)}">
                                    <spring:theme code="review.show.more" />
                                </a>
                            </div>
                        </h2>
                    </td>
                </c:forEach>
            </tr>

            <tr>
                <th>Product Name</th>
                <c:forEach var="productData" items="${compare}" >
                    <td>${productData.name}</td>
                </c:forEach>
            </tr>

            <tr>
                <th>Brand Name</th>
                <c:forEach var="productData" items="${compare}">
                    <td>
                        <c:forEach var="categoryFeature" items="${productData.categories}">
                            <p>
                                    ${categoryFeature.name}
                            </p>
                        </c:forEach>
                    </td>
                </c:forEach>
            </tr>

                <%--th of classification--%>
            <c:forEach var="productData" items="${compare}" end="0">
                <c:forEach var="classifications" items="${productData.classifications}">
                        <c:set var="classificationFeatureNames" scope="session"
                               value="${classifications.features}"/>
                </c:forEach>
            </c:forEach>
                <%----%>

            <c:forEach var="classificationLine" items="${classificationFeatureNames}">
                <tr>
                    <th>${classificationLine.name}</th>
                <c:forEach var="productData" items="${compare}">
                    <c:forEach var="classifications" items="${productData.classifications}">
                        <c:forEach var="classificationFeature" items="${classifications.features}">
                            <c:if test="${classificationFeature.name == classificationLine.name}">
                                <td>
                                    <c:forEach var="featureValue" items="${classificationFeature.featureValues}">
                                        <p>
                                                ${empty featureValue.value ? '-' : featureValue.value}
                                        </p>
                                    </c:forEach>
                                </td>
                            </c:if>


                        </c:forEach>
                    </c:forEach>

                </c:forEach>
                </tr>
            </c:forEach>
        </table>

 <%--       <table id="comparisonTable" class="zui-table" data-compare-url="${compareUrl}"
               data-compare-url-get="${compareUrlGet}" data-compare-url-category-delete="${compareUrlCategoryDelete}"
               data-compare-url-category-compare="${compareUrlCategoryCompare}">
            <thead>
            <caption>
                <h4>
                    Compare page
                        <a href="javascript:void(0);" class="comparisonItemLinkClose glyphicon glyphicon-remove"
                           data-compare-category-code=${categoryCode}>
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
            <tbody >

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
        </table>--%>

<%--
        <div class="row">
            <c:forEach var="productData" items="${compare}" end="0">
                <div class="column" style="background-color:#aaa;">
                    <h2>Compare Items</h2>
                    <p>Name</p>
                    <p>BrandName</p>
                    <c:forEach var="classifications" items="${productData.classifications}">
                        <p>${classifications.name}</p>
 &lt;%&ndash;                           <c:forEach var="classificationFeature" items="${classifications.features}">
                                Feature: ${classificationFeature.name}
                                (
                                <c:forEach var="featureValue" items="${classificationFeature.featureValues}">
                                    ${empty featureValue.value ? '-' : featureValue.value},
                                </c:forEach>

                                )
                            </c:forEach>&ndash;%&gt;

                    </c:forEach>
                </div>
            </c:forEach>
&lt;%&ndash;            items here&ndash;%&gt;
            <c:forEach var="productData" items="${compare}" >
                <div class="column" style="background-color:#bbb;">
                    <h2><div data-compare-url="${compareUrl}"
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
                    </h2>
                    <p>${productData.name}</p>
                    <p>BrandName</p>
                    <c:forEach var="classifications" items="${productData.classifications}">

                                                   <c:forEach var="classificationFeature" items="${classifications.features}">
                                                       <p>${classificationFeature.name}</p>

                                                       <c:forEach var="featureValue" items="${classificationFeature.featureValues}">
                                                           <p>${empty featureValue.value ? '-' : featureValue.value}</p>
                                                       </c:forEach>

                                                   </c:forEach>

                    </c:forEach>
                </div>
            </c:forEach>

        </div>
--%>


    </div>
</template:page>




