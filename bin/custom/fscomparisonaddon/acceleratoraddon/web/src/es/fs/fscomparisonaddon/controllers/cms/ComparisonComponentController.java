package es.fs.fscomparisonaddon.controllers.cms;

import de.hybris.platform.acceleratorcms.model.components.ComparisonComponentModel;
import de.hybris.platform.addonsupport.controllers.cms.AbstractCMSAddOnComponentController;
import es.fs.fscomparisonaddon.constants.FscomparisonaddonConstants;
import es.fs.fscomparisonaddon.controllers.FscomparisonaddonControllerConstants;
import es.fs.fscomparisonaddon.facades.ComparisonFacade;
import es.fs.fscomparisonaddon.facades.dto.ComparisonCategoryData;
import es.fs.fscomparisonaddon.facades.dto.ComparisonData;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;


@Controller("ComparisonComponentController")
@RequestMapping(value = FscomparisonaddonControllerConstants.Actions.Cms.ComparisonComponent)
public class ComparisonComponentController extends AbstractCMSAddOnComponentController<ComparisonComponentModel>
{

	@Resource(name = "comparisonFacadeImpl")
	private ComparisonFacade comparisonFacade;

	@Override
	protected void fillModel(HttpServletRequest request, Model model, ComparisonComponentModel component)
	{
		ComparisonData comparisonData = comparisonFacade.getProducts();

		long products = comparisonData.getComparisonCategoriesData().stream()
				.mapToLong((comparisonCategoryData) -> comparisonCategoryData.getProducts().size())
				.sum();

		model.addAttribute("shownProductCount", products);
		model.addAttribute("comparisonCategories", comparisonData.getComparisonCategoriesData());

	}

	@Override
	protected String getAddonUiExtensionName(final ComparisonComponentModel component)
	{
		return FscomparisonaddonConstants.EXTENSIONNAME;
	}
}
