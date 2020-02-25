<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>

<%@ attribute name="languages" required="true" type="java.util.Collection"%>
<%@ attribute name="currentLanguage" required="true" type="de.hybris.platform.commercefacades.storesession.data.LanguageData"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<c:if test="${fn:length(languages) > 1}">
	<c:url value="/_s/language" var="setLanguageActionUrl" />
	<c:url value="/_s/session-params" var="setSessionParamsActionUrl" />
	<form:form action="${setLanguageActionUrl}" method="post" id="lang-form" cssClass="header-lang-form js-lang-form">
		<spring:theme code="text.language" var="languageText" />
		<spring:theme code="text.header.language.selector" var="textSelectorLang"/>
		<label class="control-label label-language link-text" for="lang-selector">${textSelectorLang}</label>
		<ycommerce:testId code="header_language_select">
			<select name="code" id="lang-selector" class="header-lang-selector js-lang-selector">
				<c:forEach items="${languages}" var="lang">
					<c:choose>
						<c:when test="${lang.isocode == currentLanguage.isocode}">
							<option value="${fn:escapeXml(lang.isocode)}" selected="selected"
									lang="${fn:escapeXml(lang.isocode)}">${fn:escapeXml(lang.isocode)}&nbsp;+</option>
						</c:when>
						<c:otherwise>
							<option value="${fn:escapeXml(lang.isocode)}" lang="${fn:escapeXml(lang.isocode)}">
									${fn:escapeXml(lang.isocode)}
							</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</ycommerce:testId>
	</form:form>
	<form:form action="${setSessionParamsActionUrl}" method="post" id="session-params-form" cssClass="hidden header-session-params-form js-session-params-form">
		<input type="hidden" name="country" id="country-input" class="header-country-input js-country-input">
		<input type="hidden" name="zipcode" id="zipcode-input" class="header-zipcode-input js-zipcode-input">
		<input type="hidden" name="latitude" id="latitude-input" class="header-latitude-input js-latitude-input">
		<input type="hidden" name="longitude" id="longitude-input" class="header-longitude-input js-longitude-input">
	</form:form>
</c:if>