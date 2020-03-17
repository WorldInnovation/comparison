package es.fs.fscomparisonaddon.dao;

import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.core.model.user.UserModel;
import es.fs.fscomparisonaddon.model.ComparisonModel;
import jdk.nashorn.internal.runtime.options.Option;

import java.util.List;
import java.util.Optional;

public interface ComparisonDao
{
    Optional<List<ComparisonModel>> getByUser(UserModel user);
    Optional<List<ComparisonModel>> getByUserUid(String userUid);
    Optional<List<ComparisonModel>> getBySessionId(String sessionId);
    Optional<List<ProductModel>> getProductsByComparisonPk (String comparisonPk);
}
