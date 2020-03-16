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
			addProductToSessionComparison(user, product);
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
		Set<ProductModel> productModelSet = getProductsFromUser(user);
		productModelSet.add(product);
		return updateSessionComparison(user, productModelSet);
/*		Optional<List<ComparisonModel>> userComparisonProducts = comparisonDao.getByUser(user);
		if (userComparisonProducts.isPresent())
		{
			if(userComparisonProducts.get().size() == 0){
				return createSessionComparison(user, product);
			}
			List<ComparisonModel> comparisonModelList = userComparisonProducts.get();
			Set<ProductModel> productModelList = comparisonModelList.stream().findFirst().get().getProducts();
			for (ProductModel productModel: productModelList)
			{
				addProductToSessionComparison(user, productModel);
			}
		}
		return createSessionComparison(user, product);*/
	}

	private ComparisonModel addProductToSessionComparison(UserModel user, ProductModel product)
	{
		Session session = sessionService.getCurrentSession();

		synchronized (session)
		{
			ComparisonModel comparisonModel = session.getAttribute(SESSION_COMPARISON);
			Set<ProductModel> updateProducts = new HashSet<>();
			if(comparisonModel == null)
			{
				comparisonModel = new ComparisonModel();
				updateProducts.add(product);
			}
			else
			{
				if (comparisonModel.getProducts() != null)
				{
					updateProducts = new HashSet<>(comparisonModel.getProducts());
					if (!updateProducts.contains(product))
					{
						updateProducts.add(product);
					}
				}
			}

			return updateComparisonModel(comparisonModel, session, updateProducts, user);
		}
	}

	private ComparisonModel updateComparisonModel(ComparisonModel comparisonModel, Session session, Set<ProductModel> productModelSet
			, UserModel user)
	{
		comparisonModel.setProducts(productModelSet);
		comparisonModel.setSessionId(session.getSessionId());
		comparisonModel.setUser(user);
		session.setAttribute(SESSION_COMPARISON, comparisonModel);
		modelService.save(comparisonModel);
		return comparisonModel;
	}

	private ComparisonModel createSessionComparison(UserModel user, ProductModel product)
	{
		String sessionId = sessionService.getCurrentSession().getSessionId();
		return sessionService.getOrLoadAttribute(SESSION_COMPARISON,
				() -> comparisonFactory.createComparison(user, sessionId, product));
	}

	private ComparisonModel updateSessionComparison(UserModel user, Set<ProductModel> productModelSet)
	{
		String sessionId = sessionService.getCurrentSession().getSessionId();
		return sessionService.getOrLoadAttribute(SESSION_COMPARISON,
				() -> comparisonFactory.updateComparison(user, sessionId, productModelSet));
	}

	@Override
	public String deleteCategory(UserModel user, String categoryCode)
	{
		if (hasSessionComparison())
		{
			deleteCategoryProductFromSessionComparison(categoryCode);
		}
		else
		{
			deleteCategoryProductFromUserOldSessionComparison(user, categoryCode);
		}
		return categoryCode;
	}

	private ComparisonModel deleteCategoryProductFromSessionComparison(String categoryCode)
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

	private ComparisonModel deleteCategoryProductFromUserOldSessionComparison(UserModel user, String categoryCode)
	{
		ComparisonModel comparisonModel = new ComparisonModel();
		if (userService.isAnonymousUser(user))
		{
			return comparisonModel;
		}
		Optional<List<ComparisonModel>> userComparisonProducts = comparisonDao.getByUser(user);
		return (userComparisonProducts.isPresent()) ? deleteCategoryProductFromSessionComparison(categoryCode) : comparisonModel;
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

	private Set<ProductModel> getProductByCode (ComparisonModel comparisonModel, String productCode)
	{
		return comparisonModel.getProducts().stream()
				.filter(productModel ->
						productModel.getCode().equals(productCode))
				.collect(Collectors.toSet());
	}

	@Override
	public String deleteProduct(UserModel user, String productCode)
	{
		if (hasSessionComparison())
		{
			deleteProductFromSessionComparison(productCode);
		}
		else
		{
			deleteProductFromUserOldSessionComparison(user, productCode);
		}
		return productCode;
	}

	private ComparisonModel deleteProductFromSessionComparison(String productCode)
	{
		Session session = sessionService.getCurrentSession();
		synchronized (session)
		{
			ComparisonModel comparisonModel = session.getAttribute(SESSION_COMPARISON);
			Set<ProductModel> deleteProduct = getProductByCode(comparisonModel, productCode);
			return removeFromComparisonProducts(comparisonModel, deleteProduct);
		}
	}

	private ComparisonModel deleteProductFromUserOldSessionComparison(UserModel user, String productCode)
	{
		ComparisonModel comparisonModel = new ComparisonModel();
		if (userService.isAnonymousUser(user))
		{
			return comparisonModel;
		}
		Optional<List<ComparisonModel>> userComparisonProducts = comparisonDao.getByUser(user);
		return (userComparisonProducts.isPresent()) ? deleteProductFromSessionComparison(productCode) : comparisonModel;
	}

	@Override
	public void userChangeComparisonSession(String previousUserUid)
	{
		UserModel user = userService.getCurrentUser();
		Session session = sessionService.getCurrentSession();
		synchronized (session) {
				createComparisonSessionOnce(session, user);
		}
	}
	private Set<ProductModel> getProductsFromUser( UserModel user)
	{
		Set<ProductModel> productModelSet = new HashSet<>();
		Optional<List<ComparisonModel>> userComparisonProducts = comparisonDao.getByUser(user);
		if (userComparisonProducts.isPresent()) {
			Integer lastSizeNumber = userComparisonProducts.get().size()-1;
			ComparisonModel comparisonModel = userComparisonProducts.get().get(lastSizeNumber);
			if (comparisonModel != null) {
				if (comparisonModel.getProducts().size() > 0) {
					productModelSet = comparisonModel.getProducts();
				}
			}

		}
		return productModelSet;
	}

	private void createComparisonSessionOnce (Session session, UserModel user)
	{
		Set<ProductModel> productModelSet;
		ComparisonModel comparisonModel = session.getAttribute(SESSION_COMPARISON);
		if (comparisonModel == null) {
			productModelSet = getProductsFromUser(user);
			updateSessionComparison(user, productModelSet);
		}
		else
		{
			Set<ProductModel> anonymousProducts;
			if (comparisonModel.getProducts().size() != 0)
			{
				anonymousProducts = new HashSet<>(comparisonModel.getProducts());
				productModelSet = getProductsFromUser(user);
				List<ProductModel> listAdd = new ArrayList<>(productModelSet);
				listAdd.addAll(anonymousProducts);
                updateComparisonModel(comparisonModel, session, new HashSet<>(listAdd), user);
			}
		}
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
