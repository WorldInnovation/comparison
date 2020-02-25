package es.fs.fscomparisonaddon.facades.populators.impl;

import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.converters.Populator;
import de.hybris.platform.converters.impl.AbstractPopulatingConverter;
import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.servicelayer.dto.converter.ConversionException;
import de.hybris.platform.servicelayer.dto.converter.Converter;
import org.springframework.beans.factory.annotation.Required;

import java.util.LinkedHashSet;
import java.util.Set;


public class ComparisonProductSetPopulator implements Populator<Set<ProductModel>, LinkedHashSet<ProductData>>
{
	private Converter<ProductModel, ProductData> comparisonProductConverter;

	@Required
	public void setComparisonProductConverter(AbstractPopulatingConverter comparisonProductConverter)
	{
		this.comparisonProductConverter = comparisonProductConverter;
	}

	@Override
	public void populate(Set<ProductModel> productModelSet, LinkedHashSet<ProductData> productData) throws ConversionException
	{
		for (ProductModel productModel : productModelSet)
		{
			productData.add(comparisonProductConverter.convert(productModel));
		}
	}
}
