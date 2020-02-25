<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="hideHeaderLinks" required="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="footer" tagdir="/WEB-INF/tags/addons/fscomparisonaddon/responsive/common/footer" %>
<%@ taglib prefix="header" tagdir="/WEB-INF/tags/addons/fscomparisonaddon/responsive/common/header" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<cms:pageSlot position="TopHeaderSlot" var="component" element="div" class="container">
    <cms:component component="${component}"/>
</cms:pageSlot>

<header>
    <div class="top-header">
        <div class="row header-row-middle">
            <div class="nav__left js-site-logo header-logo col-xs-4 col-sm-3 col-md-3 hidden-mobile-tablet" id="logo">
                <cms:pageSlot position="SiteLogo" var="logo" limit="1">
                    <cms:component component="${logo}"/>
                </cms:pageSlot>
                <span class="logo-sub-text"><spring:theme code="footer.logo.text"/></span>
            </div>
            <div class="header-center-content col-xs-8 col-sm-9 col-md-5 hidden-mobile-tablet">
                <div class="header-row-content col-xs-12">
                    <div class="actions-container col-xs-8 col-lg-12">
                        <%--                            <div class="row header-row-top">--%>
                        <%--                                <header:topHeader/>--%>
                        <%--                            </div>--%>
                        <div class="row header-row-bottom">
                            <cms:pageSlot position="SearchBox" var="component">
                                <cms:component component="${component}" element="div" class="header-search-bar col-xs-12"/>
                            </cms:pageSlot>
                        </div>
                    </div>
                </div>
            </div>
            <div class="header-right-content col-md-4 hidden-mobile-tablet">
                <div class="header-links-container">
                    <div class="js-header-popup header-location header-link no-decoration hover">
                        <a class="link-border-decoration" href="<c:url value="/store-finder"/>">
                            <spring:theme code="header.link.stores"/>
                        </a>
                        <div class="popup-header-link">
                            <spring:theme code="footer.stores.location.icon" var="locationIcon"/>
                            <div class="location-link">
                                <img class="location-header-icon" src="${locationIcon}">
                                <span class="location-header-text" class=""><cms:component uid="HeaderLocationStoresLink" evaluateRestriction="true" /></span>
                            </div>
                            <div class="verified-reviews-container js-verified-reviews">
                                <div class="average-reviews">
                                    <span class="average"></span><span>/10</span>
                                    <div class="rating">

                                    </div>
                                    <%--                                    <i class="average-stars icons-rating-big-full"/></i>--%>
                                </div>
                                <div class="total-reviews">
                                    <span class="total"></span>&nbsp;<span><spring:theme code="header.location.verified.reviews"/></span>
                                </div>
                            </div>
                            <span class="button btn-block btn-black">
                                <cms:component uid="HeaderLocationReviewsLink" evaluateRestriction="true" />
                            </span>
                        </div>
                    </div>
                    <div class="js-header-popup header-help header-link no-decoration hover">
                        <a class="link-border-decoration" href="<c:url value="/contact-us"/>">
                            <spring:theme code="header.link.help"/>
                        </a>
                        <div class="popup-header-link">
                            <cms:pageSlot position="HeaderHelp" var="component">
                                <c:forEach var="link" items="${component.cmslink}">
                                    <a class="help-link" href="<c:url value="${link.url}"/>">
                                            ${link.linkName}
                                    </a>
                                </c:forEach>
                            </cms:pageSlot>
                        </div>
                    </div>
                    <cms:pageSlot position="HeaderLogin" var="component">
                        <cms:component component="${component}"/>
                    </cms:pageSlot>
                    <cms:pageSlot position="FsClub" var="component">
                        <cms:component component="${component}"/>
                    </cms:pageSlot>
                    <div id="headerComparison" data-product-code="${productCode}" >
                        <cms:pageSlot position="Comparison" var="component">
                            <cms:component component="${component}"/>
                        </cms:pageSlot>
                    </div>
                    <div id="headerMiniCartComponent">
                        <cms:pageSlot position="MiniCart" var="cart">
                            <cms:component component="${cart}"/>
                        </cms:pageSlot>
                    </div>
                    <div class="header-language header-link js-header-language no-decoration">
                        <a>
                            <span><footer:languageSelector languages="${languages}" currentLanguage="${currentLanguage}"/></span>
                        </a>
                    </div>
                    <%--<div class="header-logout header-link col-xs-4 col-lg-6">--%>
                    <%--<ycommerce:testId code="header_signOut">--%>
                    <%--<a href="<c:url value='/logout'/>">--%>
                    <%--<span class="glyphicon glyphicon-share header-link-icon"></span>--%>
                    <%--<span class="header-link-name"><spring:theme code="header.link.logout"/></span>--%>
                    <%--</a>--%>
                    <%--</ycommerce:testId>--%>
                    <%--</div>--%>
                </div>
            </div>
            <div class="hamburger-menu-mobile hidden-desktop">
                <spring:theme code="icon.hamburger.header" var="hamburgerIcon"/>
                <spring:theme code="icon.close.header" var="closeMenuIcon"/>
                <div class="js-open-header header-link-icon menu-mobile-icon">
                    <div class="svg svg-hamburger-menu js-open-header-icon js-open-menu">
                        <img src="${hamburgerIcon}" />
                    </div>
                    <div class="svg svg-close-menu js-open-header-icon js-close-menu hidden">
                        <img src="${closeMenuIcon}" />
                    </div>
                </div>
            </div>
            <div class="hidden-desktop mobile-header-logo">
                <cms:pageSlot position="HeaderLogoDropdown" var="logo">
                    <cms:component component="${logo}"/>
                </cms:pageSlot>
            </div>
            <cms:pageSlot position="SearchBox" var="component">
                <cms:component component="${component}" element="div" class="header-search-bar mobile-search-bar js-mobile-search-module js-mobile-search-bar col-xs-12"/>
            </cms:pageSlot>
            <div class="mini-cart-container-mobile js-mini-cart-container-mobile hidden-desktop">

            </div>
        </div>
    </div>
    <%--<div class="header-login-mobile-form js-header-login-mobile-form">--%>
    <div class="header-login-mobile-form js-header-login-mobile-form hidden">

    </div>
    <div class="header-logged-mobile-form js-header-logged-mobile-form hidden">

    </div>
    <div class="search-modal js-search-modal hidden hidden-desktop">
        <div class="js-search-container hidden">
            <%--links--%>
        </div>
        <div class="js-mic-container mic-container hidden">
            <div class="mic-text">
                <spring:theme code="mobile.listening.mic" />
            </div>
            <div class="mic-img-container">
                <div class="mic-img js-mic-img js-voice-dictation">
                    <spring:theme code="icon.micro.big.mobile.icon" var="micImg"/>
                    <img src="${micImg}" />
                </div>
            </div>
        </div>
    </div>
    <%--<nav:topNavigation/>--%>
    <div class="bottom-header-container js-bottom-header-container">
        <cms:pageSlot position="BottomHeaderSlot" var="component" class="BottomHeaderSlot">
            <cms:component component="${component}" />
        </cms:pageSlot>
    </div>
    <div class="language-main-container-mobile hidden-desktop js-header-language-mobile js-hidden-mobile">
        <footer:languageSelectorMobile languages="${languages}" currentLanguage="${currentLanguage}"/>
    </div>

    <div class="account-mobile-link hidden">
        <div class="hidden-desktop lang-selector-mobile js-account-mobile js-lang-selector-mobile">
            <span class="text-lang js-header-login-mobile">
                <spring:theme code="header.menu.fsclub"/>
            </span>
            <span class="text-lang js-header-logged-mobile hidden">
                <spring:theme code="header.menu.fsclub"/>
            </span>

            <span class="lang-code js-lang-code">${currentLanguage.isocode}+</span>
        </div>
    </div>
</header>
