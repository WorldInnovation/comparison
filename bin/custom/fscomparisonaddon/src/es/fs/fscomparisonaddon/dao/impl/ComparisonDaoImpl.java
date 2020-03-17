package es.fs.fscomparisonaddon.dao.impl;

import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.core.model.user.UserModel;
import de.hybris.platform.servicelayer.search.FlexibleSearchQuery;
import de.hybris.platform.servicelayer.search.FlexibleSearchService;
import de.hybris.platform.servicelayer.search.SearchResult;
import es.fs.fscomparisonaddon.dao.ComparisonDao;
import es.fs.fscomparisonaddon.model.ComparisonModel;
import org.springframework.beans.factory.annotation.Required;

import java.util.List;
import java.util.Optional;

public class ComparisonDaoImpl implements ComparisonDao {
    private final static String GET_COMPARISON_BY_USER = "SELECT {pk} FROM {Comparison} where {user} =?user";
    private final static String GET_COMPARISON_BY_USER_AND_PRODUCT = "SELECT {pk} FROM {Comparison} WHERE {sessionId} =?sessionId";
    private final static String GET_PRODUCTS_BY_COMPARISON_PK = "select {Product.pk}  from {Comparison}, {Product} , "
          + "{Comparison2Product as c2p} where {c2p.source} = {Comparison.pk} and {c2p.target} = {Product.pk} and {Comparison.pk}"
          + " =?comparisonPk";
    private final static String GET_COMPARISON_BY_USER_UID = "SELECT {pk} FROM {Comparison } where {user} IN ({{" +
            " SELECT {pk} FROM {User} where {uid}=?uid}})";

    private FlexibleSearchService flexibleSearchService;

    @Override
    public Optional<List<ComparisonModel>> getByUser (UserModel user)
    {
        FlexibleSearchQuery query = new FlexibleSearchQuery(GET_COMPARISON_BY_USER);
        query.addQueryParameter("user", user);
        SearchResult<ComparisonModel> result = flexibleSearchService.search(query);
        return Optional.ofNullable(result.getResult());
    }

    @Override
    public Optional<List<ComparisonModel>> getByUserUid(String userUid) {
        FlexibleSearchQuery query = new FlexibleSearchQuery(GET_COMPARISON_BY_USER_UID);
        query.addQueryParameter("uid", userUid);
        SearchResult<ComparisonModel> result = flexibleSearchService.search(query);
        return Optional.ofNullable(result.getResult());
    }

    @Override
    public Optional<List<ComparisonModel>> getBySessionId(String sessionId)
    {
        FlexibleSearchQuery query = new FlexibleSearchQuery(GET_COMPARISON_BY_USER_AND_PRODUCT);
        query.addQueryParameter("sessionId", sessionId);
        SearchResult<ComparisonModel> result = flexibleSearchService.search(query);
        return Optional.ofNullable(result.getResult());
    }

    @Override
    public Optional<List<ProductModel>> getProductsByComparisonPk (String comparisonPk)
    {
        FlexibleSearchQuery query = new FlexibleSearchQuery(GET_PRODUCTS_BY_COMPARISON_PK);
        query.addQueryParameter("comparisonPk", comparisonPk);
        SearchResult<ProductModel> result = flexibleSearchService.search(query);
        return Optional.ofNullable(result.getResult());
    }

    @Required
    public void setFlexibleSearchService(FlexibleSearchService flexibleSearchService) {
        this.flexibleSearchService = flexibleSearchService;
    }
}
