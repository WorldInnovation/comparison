package es.fs.fscomparisonaddon.service.impl;

import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.core.model.user.UserModel;
import de.hybris.platform.servicelayer.model.ModelService;
import es.fs.fscomparisonaddon.constants.ComparisonConstants;
import es.fs.fscomparisonaddon.model.ComparisonModel;
import es.fs.fscomparisonaddon.service.ComparisonFactory;
import org.springframework.beans.factory.annotation.Required;

import java.util.HashSet;
import java.util.Set;

public class ComparisonFactoryImpl implements ComparisonFactory, ComparisonConstants {
    private ModelService modelService;

    @Override
    public ComparisonModel createComparison(UserModel user, String sessionId, ProductModel  productModel)
    {
        Set<ProductModel> productModelSet = new HashSet<>();
        productModelSet.add(productModel);
        return saveComparison(user, sessionId, productModelSet);
    }

    @Override
    public ComparisonModel updateComparison(UserModel user, String sessionId, Set<ProductModel>  productModelSet)
    {
        return  saveComparison(user, sessionId, productModelSet);
    }

    private ComparisonModel saveComparison(UserModel user, String sessionId, Set<ProductModel>  productModelSet)
    {
        ComparisonModel comparisonModel = modelService.create(ComparisonModel.class);
        comparisonModel.setUser(user);
        comparisonModel.setProducts(productModelSet);
        comparisonModel.setSessionId(sessionId);
        modelService.save(comparisonModel);
        return comparisonModel;
    }

    @Required
    public void setModelService(ModelService modelService) {
        this.modelService = modelService;
    }

}
