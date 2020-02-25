package es.fs.fscomparisonaddon.facades.populators.impl;

import de.hybris.platform.category.impl.DefaultCategoryService;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.commerceservices.category.impl.DefaultCommerceCategoryService;
import de.hybris.platform.converters.Populator;
import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.servicelayer.dto.converter.ConversionException;
import de.hybris.platform.servicelayer.dto.converter.Converter;
import es.fs.fscomparisonaddon.facades.dto.ComparisonData;
import es.fs.fscomparisonaddon.model.ComparisonModel;
import org.springframework.beans.factory.annotation.Required;

import java.util.HashSet;
import java.util.Set;

public class DefaultComparisonProductPopulator implements Populator<ComparisonModel, ComparisonData> {
    private DefaultCategoryService categoryService;
    private DefaultCommerceCategoryService defaultCommerceCategoryService;
    private Converter<ProductModel, ProductData> productConverter;

    @Override
    public void populate(ComparisonModel comparisonModel, ComparisonData comparisonData) throws ConversionException {
        if (comparisonModel instanceof ComparisonModel) {
            Set<ProductModel> productModelSet = comparisonModel.getProducts();
            Set<ProductData> productDataSet = new HashSet<>();
/*            for (ProductModel productModel : productModelSet
            ) {
                productDataSet.add(productConverter.convert(productModel));
            }
            comparisonData.setProducts(productDataSet);*/
        }

    }

    @Required
    public void setCategoryService(DefaultCategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @Required
    public void setDefaultCommerceCategoryService(DefaultCommerceCategoryService defaultCommerceCategoryService) {
        this.defaultCommerceCategoryService = defaultCommerceCategoryService;
    }

    @Required
    public void setProductConverter(Converter<ProductModel, ProductData> converter) {
        this.productConverter = converter;
    }
}
