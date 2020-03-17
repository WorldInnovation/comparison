package es.fs.fscomparisonaddon.events;

import de.hybris.platform.servicelayer.event.events.AfterSessionUserChangeEvent;
import de.hybris.platform.servicelayer.event.impl.AbstractEventListener;
import es.fs.fscomparisonaddon.service.ComparisonService;
import es.fs.fscomparisonaddon.service.impl.ComparisonServiceImpl;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Component;


@Component
public class LoginListener extends AbstractEventListener<AfterSessionUserChangeEvent>
{
	private ComparisonService comparisonService;
	private String currentUser;

	@Override
	protected void onEvent(AfterSessionUserChangeEvent afterSessionUserChangeEvent)
	{
		if (afterSessionUserChangeEvent != null)
		{
			if (currentUser == null)
			{
				currentUser = afterSessionUserChangeEvent.getPreviousUserUID();
			}
			currentUser = comparisonService.userChangeComparisonSession(currentUser);

		}
	}

	@Required
	public void setComparisonService(ComparisonServiceImpl comparisonService)
	{
		this.comparisonService = comparisonService;
	}
}
