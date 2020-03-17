package es.fs.fscomparisonaddon.service;

import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.core.model.user.UserModel;

import java.util.Set;

public interface ComparisonService
{
    ProductModel add(UserModel user, ProductModel product);
    boolean hasSessionComparison();
    Set<ProductModel> getComparisonForUser(UserModel user);
    String deleteCategory(UserModel user, String categoryCode);
    Set<ProductModel> compare(UserModel user, String categoryCode);
    String deleteProduct (UserModel user, String productVode);
    String userChangeComparisonSession (String userUid);
}
