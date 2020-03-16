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
	private AfterSessionUserChangeEvent afterSessionUserChangeEvent;
	private ComparisonService comparisonService;

	@Override
	protected void onEvent(AfterSessionUserChangeEvent afterSessionUserChangeEvent)
	{
		if (this.afterSessionUserChangeEvent != null)
		{
			if (!this.afterSessionUserChangeEvent.getSource().equals(afterSessionUserChangeEvent.getSource()))
			{
				comparisonService.userChangeComparisonSession(afterSessionUserChangeEvent.getPreviousUserUID());
			}

		}
		this.afterSessionUserChangeEvent = afterSessionUserChangeEvent;
	}

	@Required
	public void setComparisonService(ComparisonServiceImpl comparisonService)
	{
		this.comparisonService = comparisonService;
	}
}
