package es.fs.fscomparisonaddon.controllers.pages;

import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.AbstractPageController;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.servicelayer.i18n.I18NService;
import es.fs.fscomparisonaddon.facades.ComparisonFacade;
import es.fs.fscomparisonaddon.facades.dto.ComparisonData;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Set;

@Controller
@RequestMapping("/comparison")
public class ComparisonController extends AbstractPageController
{
	final String GET_COMPONENT_NAME = "Comparison";
	final String GET_ADDON_JSP_PAGE_REFRESH =
			"addon:" + "/" + "fscomparisonaddon" + "/" + "fragments" + "/" + "comparisonajaxcomponent";
	final String COMPARISON_CATEGORY_CONTENT_PAGE = "comparisonCategory";
	final String COMPARE_CONTENT_PAGE  = "compare";

	@Resource(name = "comparisonFacadeImpl")
	private ComparisonFacade comparisonFacade;

	@RequestMapping(value = "/add", method = RequestMethod.POST, params = "code")
	@ResponseBody
	public ProductData addComparison(@RequestParam("code") final String productCode)
	{
		return comparisonFacade.add(productCode);
	}

	@Resource(name = "messageSource")
	private MessageSource messageSource;

	@Resource(name = "i18nService")
	private I18NService i18nService;

	@RequestMapping(value = "/get", method = RequestMethod.GET)
	public String getComparisonData(final Model model)
	{
		model.addAttribute("component", GET_COMPONENT_NAME);
		return GET_ADDON_JSP_PAGE_REFRESH;
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST, params = "code")
	@ResponseBody
	public String deleteComparison(@RequestParam("code") final String categoryCode)
	{
		return comparisonFacade.deleteCategory(categoryCode);
	}

	@RequestMapping(value = "/deleteProduct", method = RequestMethod.POST, params = "productCode")
	@ResponseBody
	public String deleteComparisonProduct(@RequestParam("productCode") final String productCode)
	{
		return comparisonFacade.deleteProduct(productCode);
	}

	@RequestMapping(value = "/compare/{categoryCode}", method = RequestMethod.GET)
	public String compareComparison(final Model model, @PathVariable final String categoryCode)
			throws CMSItemNotFoundException
	{
		Set<ProductData> comparison = comparisonFacade.compare(categoryCode);
		Set<String> featureNames = comparisonFacade.getFeatureNames(comparison);
		model.addAttribute("categoryCode", categoryCode);
		model.addAttribute("comparison", comparison);
		model.addAttribute("featureNames", featureNames);
		getMessagesFromProperties(model);

		storeCmsPageInModel(model, getContentPageForLabelOrId(COMPARE_CONTENT_PAGE));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(COMPARE_CONTENT_PAGE));
		return getViewForPage(model);
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String allComparison(final Model model) throws CMSItemNotFoundException
	{
		ComparisonData comparisonData = comparisonFacade.getProducts();
		model.addAttribute("comparisonCategories", comparisonData.getComparisonCategoriesData());
		getMessagesFromProperties(model);

		storeCmsPageInModel(model, getContentPageForLabelOrId(COMPARISON_CATEGORY_CONTENT_PAGE));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(COMPARISON_CATEGORY_CONTENT_PAGE));
		return getViewForPage(model);
	}

	private Model getMessagesFromProperties(Model model)
	{
		String titleTable = messageSource.getMessage("fscomparisonaddon.page.title.product.comparison", null, i18nService.getCurrentLocale());
		model.addAttribute("titleTable", titleTable);
		String comparisonList = messageSource.getMessage("fscomparisonaddon.page.title.category.comparison", null, i18nService.getCurrentLocale());
		model.addAttribute("comparisonList", comparisonList);

		return model;
	}

}
