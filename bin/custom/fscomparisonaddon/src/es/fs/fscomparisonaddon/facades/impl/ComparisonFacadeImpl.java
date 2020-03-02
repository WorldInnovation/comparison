package es.fs.fscomparisonaddon.facades.impl;

import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.core.model.user.UserModel;
import de.hybris.platform.product.ProductService;
import de.hybris.platform.servicelayer.dto.converter.Converter;
import de.hybris.platform.servicelayer.user.UserService;
import es.fs.fscomparisonaddon.facades.ComparisonFacade;
import es.fs.fscomparisonaddon.facades.dto.ComparisonData;
import es.fs.fscomparisonaddon.service.ComparisonService;
import org.springframework.beans.factory.annotation.Required;

import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;

import static de.hybris.platform.servicelayer.util.ServicesUtil.validateParameterNotNullStandardMessage;


public class ComparisonFacadeImpl implements ComparisonFacade
{
	private UserService userService;
	private ProductService productService;
	private ComparisonService comparisonService;
	private Converter<ProductModel, ProductData> comparisonComponentProductConverter;
	private Converter<Set<ProductModel>, ComparisonData> comparisonProductsToCategoryConverter;
	private Converter<Set<ProductModel>, LinkedHashSet<ProductData>> comparisonProductSetConverter;


	@Override
	public ProductData add(String code)
	{
		UserModel userModel = userService.getCurrentUser();
		ProductModel productModel = productService.getProductForCode(code);
		comparisonService.add(userModel, productModel);
		return comparisonComponentProductConverter.convert(productModel);

	}

	@Override
	public ComparisonData getProducts()
	{
		UserModel userModel = userService.getCurrentUser();
		return comparisonProductsToCategoryConverter.convert(comparisonService.getComparisonForUser(userModel));
	}

	@Override
	public String deleteCategory(String categoryCode)
	{
		validateParameterNotNullStandardMessage("categoryCode", categoryCode);
		UserModel userModel = userService.getCurrentUser();
		comparisonService.deleteCategory(userModel, categoryCode);
		return categoryCode;
	}

	@Override
	public Set<ProductData> compare(String categoryCode)
	{
		validateParameterNotNullStandardMessage("categoryCode", categoryCode);
		UserModel userModel = userService.getCurrentUser();
		return  comparisonProductSetConverter.convert(comparisonService.compare(userModel, categoryCode));
	}

	@Override
	public Set<String> getFeatureNames (Set<ProductData> productDataSet)
	{
		Set<String> featuresNames = new HashSet<>();
		productDataSet.stream().forEach(productData -> productData.getClassifications()
				.stream().forEach(classificationData -> classificationData.getFeatures()
						.stream().forEach(featureData -> featuresNames.add(featureData.getName()))));
		return featuresNames;
	}

	@Required
	public void setUserService(UserService userService)
	{
		this.userService = userService;
	}

	@Required
	public void setProductService(ProductService productService)
	{
		this.productService = productService;
	}

	@Required
	public void setComparisonService(ComparisonService comparisonService)
	{
		this.comparisonService = comparisonService;
	}

	@Required
	public void setComparisonComponentProductConverter(Converter<ProductModel, ProductData> comparisonComponentProductConverter)
	{
		this.comparisonComponentProductConverter = comparisonComponentProductConverter;
	}

	@Required
	public void setComparisonProductsToCategoryConverter(
			Converter<Set<ProductModel>, ComparisonData> comparisonProductsToCategoryConverter)
	{
		this.comparisonProductsToCategoryConverter = comparisonProductsToCategoryConverter;
	}

	@Required
	public void setComparisonProductSetConverter(
			Converter<Set<ProductModel>, LinkedHashSet<ProductData>> comparisonProductSetConverter)
	{
		this.comparisonProductSetConverter = comparisonProductSetConverter;
	}
}
