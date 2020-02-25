package es.fs.fscomparisonaddon.service;

import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.core.model.user.UserModel;
import es.fs.fscomparisonaddon.model.ComparisonModel;

import java.util.Set;

public interface ComparisonFactory
{
    ComparisonModel createComparison(UserModel user, String sessionId, ProductModel productModelSet);
}
