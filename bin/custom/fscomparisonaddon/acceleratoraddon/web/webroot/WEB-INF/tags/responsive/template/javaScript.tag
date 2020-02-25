<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="cms" tagdir="/WEB-INF/tags/addons/fscomparisonaddon/responsive/template/cms" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/addons/fscomparisonaddon/responsive/template" %>
<c:set var="addonPath" value="/_ui/responsive/theme-forumsportthemev02" />
<c:set var="ymktAddonPath" value="/_ui/addons/fsymktaddon/shared/common" />
<c:url value="/" var="siteRootUrl"/>
<template:javaScriptVariables/>

<c:choose>
    <c:when test="${wro4jEnabled}">
        <script type="text/javascript" src="${contextPath}/wro/all_responsive.js"></script>
        <script type="text/javascript" src="${contextPath}/wro/addons_responsive.js"></script>
        <script type="text/javascript" src="${contextPath}/wro/${themeName}_responsive.js"></script>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=${googleApiKey}"></script>
        <script type="text/javascript" src="//js.maxmind.com/js/apis/geoip2/v2.1/geoip2.js"></script>

    </c:when>
    <c:otherwise>
        <%-- bootstrap --%>
        <script type="text/javascript" src="${commonResourcePath}/bootstrap/dist/js/bootstrap.min.js"></script>

        <%-- plugins --%>
        <script type="text/javascript" src="${commonResourcePath}/js/slick.min.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.lazy.min.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/enquire.min.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/Imager.min.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.blockUI-2.66.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.colorbox-min.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.form.min.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.hoverIntent.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.pstrength.custom-1.2.0.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.syncheight.custom.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.tabs.custom.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery-ui-1.12.1.min.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.zoom.custom.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/owl.carousel.custom.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.tmpl-1.0.0pre.min.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.currencies.min.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.waitforimages.min.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.slideviewer.custom.1.2.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/foundation.min.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/jquery.swipe.carousels.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/ion.rangeSlider.min.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/TweenMax.min.js"></script>
        <script type="text/javascript" src="${commonResourcePath}/js/hammerjs.min.js"></script>


        <%-- Custom ACC JS --%>
        <script type="text/javascript" src="${addonPath}/js/acc.navigationmenu.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.navigation.js"></script>
        <script type="text/javascript" src="${addonPath}/js/moment.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.gtm.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.address.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.search.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.autocomplete.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.carousel.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.cart.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.instore.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.cartitem.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.checkout.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.checkoutaddress.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.checkoutsteps.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.cms.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.colorbox.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.common.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.forgottenpassword.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.global.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.hopdebug.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.imagegallery.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.langcurrencyselector.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.login.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.minicart.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.order.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.paginationsort.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.payment.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.paymentDetails.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.pickupinstore.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.product.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.productDetail.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.reviews.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.quickview.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.ratingstars.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.refinements.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.sanitizer.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.silentorderpost.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.tabs.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.termsandconditions.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.track.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.storefinder.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.futurelink.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.productorderform.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.savedcarts.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.multidgrid.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.sizeConverter.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.payin7Simulator.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.quickorder.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.quote.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.consent.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.verifiedReviews.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.brands.js"></script>
        <script type="text/javascript" src="${addonPath}/js/acc.remember-state.js"></script>

        <script type="text/javascript" src="${commonResourcePath}/js/acc.csv-import.js"></script>

        <script type="text/javascript" src="${ymktAddonPath}/js/fssapprodrecoaddon.js"></script>
        <script type="text/javascript" src="${addonPath}/js/_autoload.js"></script>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=${googleApiKey}"></script>


        <%-- (JRZ) 20190528 FS-1410 - GeoIP Library  --%>
        <script type="text/javascript" src="//js.maxmind.com/js/apis/geoip2/v2.1/geoip2.js"></script>

        <%-- Cms Action JavaScript files --%>
        <c:forEach items="${cmsActionsJsFiles}" var="actionJsFile">
            <script type="text/javascript" src="${addonPath}/js/cms/${actionJsFile}"></script>
        </c:forEach>

        <%-- AddOn JavaScript files --%>
        <c:forEach items="${addOnJavaScriptPaths}" var="addOnJavaScript">
            <script type="text/javascript" src="${addOnJavaScript}"></script>
        </c:forEach>

    </c:otherwise>
</c:choose>


<cms:previewJS cmsPageRequestContextData="${cmsPageRequestContextData}" />
