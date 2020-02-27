package es.fs.fscomparisonaddon.controllers;

/*import de.hybris.platform.acceleratorcms.model.components.ComparisonComponentModel;*/

import es.fs.fscomparisonaddon.model.components.ComparisonComponentModel;


/**
 */
public interface FscomparisonaddonControllerConstants
{
    interface Actions
    {
        interface Cms // NOSONAR
        {
            String _Prefix = "/view/"; // NOSONAR
            String _Suffix = "Controller"; // NOSONAR

            /**
             * CMS components that have specific handlers
             */
            String ComparisonComponent  = _Prefix + ComparisonComponentModel._TYPECODE + _Suffix; // NOSONAR
        }
    }

    interface Views {
        interface Cms // NOSONAR
        {
            String ComponentPrefix = "cms/"; // NOSONAR
        }
    }
}
