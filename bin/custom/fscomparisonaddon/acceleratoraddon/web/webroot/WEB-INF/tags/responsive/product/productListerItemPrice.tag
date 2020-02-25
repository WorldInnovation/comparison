<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<ycommerce:testId code="searchPage_price_label_${product.code}">

		<%-- if product is multidimensional with different prices, show range, else, show unique price --%>
		<c:choose>
			<c:when test="${product.multidimensional and (product.priceRange.minPrice.value ne product.priceRange.maxPrice.value)}">
				<format:price priceData="${product.priceRange.minPrice}"/> - <format:price priceData="${product.priceRange.maxPrice}"/>
			</c:when>
			<c:otherwise>
				<div class="prices-container">
				<div class="price-box">
				<div class="price ${product.discount ne '0'?'' : 'no-discount'}">
					<format:fromPrice priceData="${product.reducedPrice}"/>
				</div>
				<c:choose>
					<c:when test="${product.discount ne '0'}">
						<div class="oldPrice">
							<format:fromPrice priceData="${product.price}"/>
						</div>
						</div>
						<div class="discount">
								${product.discount}
						</div>
					</c:when>
					<c:otherwise>
						</div>
					</c:otherwise>
				</c:choose>


				</div>
			</c:otherwise>
		</c:choose>

</ycommerce:testId>
