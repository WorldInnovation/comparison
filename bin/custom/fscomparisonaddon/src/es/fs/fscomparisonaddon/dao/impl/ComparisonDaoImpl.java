package es.fs.fscomparisonaddon.dao.impl;

import de.hybris.platform.servicelayer.search.FlexibleSearchQuery;
import de.hybris.platform.servicelayer.search.FlexibleSearchService;
import de.hybris.platform.servicelayer.search.SearchResult;
import es.fs.fscomparisonaddon.dao.ComparisonDao;
import es.fs.fscomparisonaddon.model.ComparisonModel;
import org.springframework.beans.factory.annotation.Required;

import java.util.List;
import java.util.Optional;

public class ComparisonDaoImpl implements ComparisonDao {
    private final static String GET_COMPARISON_BY_USER = "SELECT {*} FROM {Comparison} where {user} =?user";
    private final static String GET_COMPARISON_BY_USER_AND_PRODUCT = "SELECT {*} FROM {Comparison} WHERE {sessionId} =?sessionId";

    private FlexibleSearchService flexibleSearchService;

    @Override
    public Optional<List<ComparisonModel>> getByUser(String user)
    {
        String fsq = GET_COMPARISON_BY_USER;
        FlexibleSearchQuery query = new FlexibleSearchQuery(fsq);
        query.addQueryParameter("user", user);
        SearchResult<ComparisonModel> result = flexibleSearchService.search(query);
        return Optional.ofNullable(result.getResult());
    }

    @Override
    public List<ComparisonModel> getBySessionId(String sessionId)
    {
        String fsq = GET_COMPARISON_BY_USER_AND_PRODUCT;
        FlexibleSearchQuery query = new FlexibleSearchQuery(fsq);
        query.addQueryParameter("sessionId", sessionId);
        SearchResult<ComparisonModel> result = flexibleSearchService.search(query);
        return result.getResult();
    }

    @Required
    public void setFlexibleSearchService(FlexibleSearchService flexibleSearchService) {
        this.flexibleSearchService = flexibleSearchService;
    }
}
