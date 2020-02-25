package es.fs.fscomparisonaddon.facades;

import de.hybris.platform.commercefacades.product.data.ProductData;
import es.fs.fscomparisonaddon.facades.dto.ComparisonData;

import java.util.Set;


public interface ComparisonFacade
{

    ProductData add (String code);
    ComparisonData getProducts();
    String deleteCategory (String code);
    Set<ProductData> compare (String categoryCode);
}
