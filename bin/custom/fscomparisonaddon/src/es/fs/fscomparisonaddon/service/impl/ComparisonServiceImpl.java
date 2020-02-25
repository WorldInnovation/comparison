package es.fs.fscomparisonaddon.service.impl;

import de.hybris.platform.category.model.CategoryModel;
import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.core.model.user.UserModel;
import de.hybris.platform.servicelayer.model.ModelService;
import de.hybris.platform.servicelayer.session.Session;
import de.hybris.platform.servicelayer.session.SessionService;
import de.hybris.platform.servicelayer.user.UserService;
import es.fs.fscomparisonaddon.constants.ComparisonConstants;
import es.fs.fscomparisonaddon.dao.ComparisonDao;
import es.fs.fscomparisonaddon.model.ComparisonModel;
import es.fs.fscomparisonaddon.service.ComparisonFactory;
import es.fs.fscomparisonaddon.service.ComparisonService;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.stream.Collectors;


public class ComparisonServiceImpl implements ComparisonService, ComparisonConstants
{

	private SessionService sessionService;
	private ComparisonFactory comparisonFactory;
	private UserService userService;
	private ComparisonDao comparisonDao;
	private ModelService modelService;

	@Override
	public ProductModel add(UserModel user, ProductModel product)
	{
		if (hasSessionComparison())
		{
			addProductToSessionComparison(product);
		}
		else
		{
			if (userService.isAnonymousUser(user))
			{
				createSessionComparison(user, product);
			}
			else
			{
				addProductToUserSessionComparison(user, product);
			}
		}
		return product;
	}

	private ComparisonModel addProductToUserSessionComparison(UserModel user, ProductModel product)
	{
		Optional<List<ComparisonModel>> userComparisonProducts = comparisonDao.getByUser(user.getName());
		if (userComparisonProducts.isPresent())
		{
			return addProductToSessionComparison(product);
		}
		else
		{
			return createSessionComparison(user, product);
		}
	}

	private ComparisonModel addProductToSessionComparison(ProductModel product)
	{
		Session session = sessionService.getCurrentSession();

		synchronized (session)
		{
			ComparisonModel comparisonModel = session.getAttribute(SESSION_COMPARISON);
			Set<ProductModel> updateProducts = new HashSet<>(comparisonModel.getProducts());
			if (!updateProducts.contains(product))
			{
				updateProducts.add(product);
				comparisonModel.setProducts(updateProducts);
				modelService.save(comparisonModel);
			}
			return comparisonModel;
		}
	}

	private ComparisonModel createSessionComparison(UserModel user, ProductModel product)
	{
		String sessionId = sessionService.getCurrentSession().getSessionId();
		return sessionService.getOrLoadAttribute(SESSION_COMPARISON,
				() -> comparisonFactory.createComparison(user, sessionId, product));
	}

	@Override
	public String deleteCategory(UserModel user, String categoryCode)
	{
		if (hasSessionComparison())
		{
			deleteProductFromSessionComparison(categoryCode);
		}
		else
		{
			deleteProductFromUserOldSessionComparison(user, categoryCode);
		}
		return categoryCode;
	}

	private ComparisonModel deleteProductFromSessionComparison(String categoryCode)
	{
		Session session = sessionService.getCurrentSession();

		synchronized (session)
		{
			ComparisonModel comparisonModel = session.getAttribute(SESSION_COMPARISON);
			Set<ProductModel> deleteProducts = getProductsByCategory(comparisonModel, categoryCode);
			return removeFromComparisonProducts(comparisonModel, deleteProducts);
		}
	}

	private ComparisonModel removeFromComparisonProducts (ComparisonModel comparisonModel, Set<ProductModel> deleteProducts )
	{
		Set<ProductModel> updateProducts = new HashSet<>(comparisonModel.getProducts());
		for (ProductModel product : deleteProducts)
		{
			updateProducts.remove(product);
			comparisonModel.setProducts(updateProducts);
			modelService.save(comparisonModel);
		}
		return comparisonModel;
	}

	private ComparisonModel deleteProductFromUserOldSessionComparison(UserModel user, String categoryCode)
	{
		ComparisonModel comparisonModel = new ComparisonModel();
		if (userService.isAnonymousUser(user))
		{
			return comparisonModel;
		}
		Optional<List<ComparisonModel>> userComparisonProducts = comparisonDao.getByUser(user.getName());
		return (userComparisonProducts.isPresent()) ? deleteProductFromSessionComparison(categoryCode) : comparisonModel;
	}


	public boolean hasSessionComparison()
	{
		return sessionService.getCurrentSession().getAttribute(SESSION_COMPARISON) != null;
	}

	@Override
	public Set<ProductModel> getComparisonForUser(UserModel user)
	{
		if (!hasSessionComparison())
		{
			return Collections.emptySet();
		}
		Session session = sessionService.getCurrentSession();
		ComparisonModel comparisonModel = session.getAttribute(SESSION_COMPARISON);
		return comparisonModel.getProducts();
	}

	@Override
	public Set<ProductModel> compare(UserModel user, String categoryCode)
	{
		if (!hasSessionComparison())
		{
			return Collections.emptySet();
		}
		Session session = sessionService.getCurrentSession();
		ComparisonModel comparisonModel = session.getAttribute(SESSION_COMPARISON);
		return getProductsByCategory(comparisonModel, categoryCode);
	}

	private Set<ProductModel> getProductsByCategory (ComparisonModel comparisonModel, String categoryCode)
	{
		return comparisonModel.getProducts().stream()
				.filter(productModel ->  {
					List<CategoryModel> categoryDataList = new ArrayList<>(productModel.getSupercategories());
					return (!CollectionUtils.isEmpty(categoryDataList)) && categoryDataList.get(categoryDataList.size() - 1)
							.getCode().equals(categoryCode);
				})
				.collect(Collectors.toSet());
	}

	@Required
	public void setSessionService(SessionService sessionService)
	{
		this.sessionService = sessionService;
	}

	@Required
	public void setComparisonFactory(ComparisonFactory comparisonFactory)
	{
		this.comparisonFactory = comparisonFactory;
	}

	@Required
	public void setUserService(UserService userService)
	{
		this.userService = userService;
	}

	@Required
	public void setComparisonDao(ComparisonDao comparisonDao)
	{
		this.comparisonDao = comparisonDao;
	}

	@Required
	public void setModelService(ModelService modelService)
	{
		this.modelService = modelService;
	}
}
