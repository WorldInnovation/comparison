package es.fs.fscomparisonaddon.facades.populators.impl;

import de.hybris.platform.commercefacades.product.data.CategoryData;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.converters.Populator;
import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.servicelayer.dto.converter.ConversionException;
import de.hybris.platform.servicelayer.dto.converter.Converter;
import es.fs.fscomparisonaddon.facades.dto.ComparisonCategoryData;
import es.fs.fscomparisonaddon.facades.dto.ComparisonData;
import org.apache.commons.lang3.StringUtils;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.stream.Collectors;


public class ComparisonCategoryPopulator
		implements Populator<Set<ProductModel>, ComparisonData>
{
	private Converter<ProductModel, ProductData> comparisonProductConverter;

	@Override
	public void populate(Set<ProductModel> productDataSet, ComparisonData comparisonData) throws ConversionException
	{

		Map<String, ComparisonCategoryData> comparisonCategories = productDataSet.stream()
				.map((productModel) -> comparisonProductConverter.convert(productModel))
				.collect(Collectors.toMap((productData) -> {
					List<CategoryData> categoryDataList = new ArrayList<>(productData.getCategories());
					return (!CollectionUtils.isEmpty(categoryDataList)) ?
							categoryDataList.get(categoryDataList.size() - 1).getCode() :
							StringUtils.EMPTY;
				}, (productData) -> {
					ComparisonCategoryData comparisonCategoryData = new ComparisonCategoryData();
					Set<ProductData> products = new LinkedHashSet<>();
					products.add(productData);
					comparisonCategoryData.setProducts(products);

					List<CategoryData> categoryDataList = new ArrayList<>(productData.getCategories());
					if (!CollectionUtils.isEmpty(categoryDataList))
					{
						CategoryData category = categoryDataList.get(categoryDataList.size() - 1);
						comparisonCategoryData.setName(category.getName());
						comparisonCategoryData.setCode(category.getCode());
					}

					return comparisonCategoryData;
				}, (oldValue, newValue) -> {
					oldValue.getProducts().addAll(newValue.getProducts());
					return oldValue;
				}, HashMap::new));

		comparisonData.setComparisonCategoriesData(new ArrayList<>(comparisonCategories.values()));

		//		Set<ComparisonCategoryData> comparisonCategoryDataSet = new LinkedHashSet<>();
		//		Map<String, ComparisonCategoryData> comparisonCategoryDataMap = new HashMap<>();
		//		for (ProductData productData : productDataSet)
		//		{
		//			ComparisonCategoryData comparisonCategoryData = new ComparisonCategoryData();
		//			if (!productData.getCategories().isEmpty())
		//			{
		//				List<CategoryData> categoryDataList = new ArrayList<>(productData.getCategories());
		//				CategoryData categoryData = categoryDataList.get(categoryDataList.size() - 1);
		//
		//				Set<ProductData> productDataSetCategory = new LinkedHashSet<>();
		//				if (comparisonCategoryDataMap.containsKey(categoryData.getCode()))
		//				{
		//					comparisonCategoryData = comparisonCategoryDataMap.get(categoryData.getCode());
		//					productDataSetCategory.addAll(comparisonCategoryData.getProducts());
		//				}
		//				else
		//				{
		//					comparisonCategoryData.setCode(categoryData.getCode());
		//					comparisonCategoryData.setName(categoryData.getName());
		//				}
		//				productDataSetCategory.add(productData);
		//				comparisonCategoryData.setProducts(productDataSetCategory);
		//
		//				comparisonCategoryDataMap.put(categoryData.getCode(), comparisonCategoryData);
		//			}
		//
		//			comparisonCategoryDataSet.add(comparisonCategoryData);
		//		}
		//		comparisonData.setComparisonCategoriesData(comparisonCategoryDataSet);
	}

	public void setComparisonProductConverter(
			Converter<ProductModel, ProductData> comparisonProductConverter)
	{
		this.comparisonProductConverter = comparisonProductConverter;
	}
}
