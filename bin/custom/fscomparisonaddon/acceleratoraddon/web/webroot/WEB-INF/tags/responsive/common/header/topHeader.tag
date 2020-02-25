<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="footer" tagdir="/WEB-INF/tags/addons/forumsportstorefrontaddon/responsive/common/footer" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="col-xs-12 header-top-col-right">
    <ul>
        <li class="header-language header-link js-header-language no-decoration">
            <a>
                <span><footer:languageSelector languages="${languages}" currentLanguage="${currentLanguage}"/></span>
            </a>
        </li>
        <%--        <li class="header-order header-link no-decoration">--%>
        <%--            <a href="<c:url value="/consignment-tracking"/>">--%>
        <%--                <span class="glyphicon glyphicon-gift header-link-icon"></span>--%>
        <%--                <span class="header-link-name link-text"><spring:theme code="header.link.order"/></span>--%>
        <%--            </a>--%>
        <%--        </li>--%>
        <li class="header-top-link">
            <a href="<c:url value="/contact-us"/>">
                <span class="glyphicon glyphicon-question-sign header-link-icon"></span>
                <span class="link-text"><spring:theme code="header.link.help"/></span>
            </a>
        </li>
        <li class="header-top-link">
            <a href="<c:url value="/store-finder"/>">
                <span class="glyphicon glyphicon-map-marker header-link-icon "></span>
                <span class="link-text"><spring:theme code="header.link.stores"/></span>
            </a>
        </li>
        <sec:authorize access="!hasAnyRole('ROLE_ANONYMOUS')">
            <li class="header-top-link hidden-desktop">
                <a href="<c:url value="/logout"/>">
                    <span class="glyphicon glyphicon-share-alt header-link-icon "></span>
                    <span class="link-text"><spring:theme code="header.link.account.dropdown.logout"/></span>
                </a>
            </li>
        </sec:authorize>
    </ul>
</div>