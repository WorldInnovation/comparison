package es.fs.fscomparisonaddon.controllers.pages;

import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.AbstractPageController;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.commercefacades.product.data.ProductData;
import es.fs.fscomparisonaddon.facades.ComparisonFacade;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;


@Controller
@RequestMapping("/comparison")
public class ComparisonController extends AbstractPageController
{
	final String GET_COMPONENT_NAME = "Comparison";
	final String GET_ADDON_JSP_PAGE_REFRESH =
			"addon:" + "/" + "fscomparisonaddon" + "/" + "fragments" + "/" + "comparisonajaxcomponent";
	final String GET_ADDON_JSP_PAGE_COMPARE =
			"addon:" + "/" + "fscomparisonaddon" + "/" + "pages" + "/" + "comparisoncomparepage";
	final String COMPARE_CMS_PAGE  = "compare";

	@Resource(name = "comparisonFacadeImpl")
	private ComparisonFacade comparisonFacade;

	@RequestMapping(value = "/add", method = RequestMethod.POST, params = "code")
	@ResponseBody
	public ProductData addComparison(@RequestParam("code") final String productCode)
	{
		return comparisonFacade.add(productCode);
	}

	@RequestMapping(value = "/get", method = RequestMethod.GET)
	public String getComparisonData(final HttpServletRequest request, final Model model)
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

		storeCmsPageInModel(model, getContentPageForLabelOrId(COMPARE_CMS_PAGE));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(COMPARE_CMS_PAGE));
		return getViewForPage(model);
	}

}
