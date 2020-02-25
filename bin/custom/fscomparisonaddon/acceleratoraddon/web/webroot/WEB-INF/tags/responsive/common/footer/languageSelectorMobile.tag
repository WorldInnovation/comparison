<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>

<%@ attribute name="languages" required="true" type="java.util.Collection" %>
<%@ attribute name="currentLanguage" required="true"
			  type="de.hybris.platform.commercefacades.storesession.data.LanguageData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<c:if test="${fn:length(languages) > 1}">
	<c:url value="/_s/language" var="setLanguageActionUrl"/>

	<form:form action="${setLanguageActionUrl}" method="post" id="lang-form-mobile"
			   cssClass="header-lang-form js-lang-form">

		<spring:theme code="text.language" var="languageText"/>
		<spring:theme code="text.header.language.selector" var="textSelectorLang"/>
		<div class="lang-container row">
			<div class="language-label col-xs-4">
				<label class="control-label label-language label-language-content link-text"
					   for="lang-selector-mobile">${textSelectorLang}:</label>
			</div>
			<div class="lang-form col-xs-8">
				<ycommerce:testId code="header_language_select">
					<select name="code" id="lang-selector-mobile" class="header-lang-selector js-lang-selector">
						<c:forEach items="${languages}" var="lang">
							<c:choose>
								<c:when test="${lang.isocode == currentLanguage.isocode}">
									<option value="${fn:escapeXml(lang.isocode)}" selected="selected"
											lang="${fn:escapeXml(lang.isocode)}">${fn:escapeXml(lang.nativeName)}</option>
								</c:when>
								<c:otherwise>
									<option value="${fn:escapeXml(lang.isocode)}" lang="${fn:escapeXml(lang.isocode)}">
											${fn:escapeXml(lang.nativeName)}
									</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</ycommerce:testId>
			</div>
		</div>
	</form:form>

</c:if>