ACC.fscomparisonaddon = {

    _autoload: [
        "addProductToComparison",
        "appendComparisonButton",
        "bindListenerToComparisonComponent",
        "bindListenerToComparePage",
        "bindListenerToComparisonCategoryPage"
    ],

    addProductToComparison: function () {
        $('.btn-comparison').on("click", function () {
            debugger;
            const baseUrl = $("#comparisonComponent").data('compare-url');
            const productCode = $(this).data('product-code');

            $.ajax({
                url: baseUrl,
                type: 'POST',
                data: {
                    code: productCode
                },
                success: function (data) {
                    ACC.fscomparisonaddon.getComparisonProduct();

                }

            });
        })

    },

    getComparisonProduct: function () {
        const baseUrlGet = $("#comparisonComponent").data('compare-url-get');
        debugger;
        $.ajax({
            url: baseUrlGet,
            type: 'GET',
            success: function (data) {
                $("#comparisonComponent").replaceWith(data);
                ACC.fscomparisonaddon.bindListenerToComparisonComponent();
            }
        })


    },

    appendComparisonButton: function () {
        $(".btn-comparison").append('<button type="button" class="btn-enter btn btn-primary btn-block"> COMPARE </button>');

    },

    bindListenerToComparisonComponent: function () {
            $('#comparisonComponent').on('click', '.comparisonCategoryLinkClose' , function () {
                debugger;
                const comparisonCategoryRemove = $(this).data('compare-category-code');
                const baseUrl = $("#comparisonComponent").data('compare-url-category-delete');
                $.ajax({
                    url: baseUrl,
                    type: 'POST',
                    data: {
                        code: comparisonCategoryRemove
                    },
                    success: function (data) {
                        ACC.fscomparisonaddon.getComparisonProduct();
                    }

                })

            });

    },

    bindListenerToComparePage: function () {
        $('#comparisonTable td').on('click', '.comparisonProductDelete' , function () {
            debugger;
            const comparisonProductRemove = $(this).data('compare-product-code');
            const baseUrl = $("#comparisonTable").data('compare-url-product-delete');
            const idProductRemove = '#' + 'comparison-product-column-' +  comparisonProductRemove;
            const tableColumnId = $(idProductRemove).index() - 1;
            const urlBrands = $("#comparisonTable").data('compare-url-brands');

            $.ajax({
                url: baseUrl,
                type: 'POST',
                data: {
                    productCode: comparisonProductRemove
                },
                success: function (data) {
                    ACC.fscomparisonaddon.deleteColumnTable(idProductRemove,tableColumnId);
                    if(($("#comparisonTable td").length) === 0){ $(location).attr('href', urlBrands); }
                    else{ACC.fscomparisonaddon.getComparisonProduct();}
                }

            })

        });

    },

    deleteColumnTable: function (idProductRemove, tableColumnId) {
         const res = 'td:eq(' + tableColumnId + '),tr:eq(' + tableColumnId + ')';
        $('#comparisonTable tr').find(res).remove();
    },

    bindListenerToComparisonCategoryPage: function () {
    $('table td').on('click', '.comparisonProductDelete' , function () {
        debugger;
        const comparisonProductRemove = $(this).data('compare-product-code');
        const baseUrl = $("table").data('compare-url-product-delete');
        const idProductRemove = '#' + 'comparison-product-column-' +  comparisonProductRemove;
        const tableColumnId = $(idProductRemove).index() - 1;
        const urlBrands = $("table").data('compare-url-brands');

        $.ajax({
            url: baseUrl,
            type: 'POST',
            data: {
                productCode: comparisonProductRemove
            },
            success: function (data) {
                $(idProductRemove).remove();
                if(($("table td").length) === 0){ $(location).attr('href', urlBrands); }
                ACC.fscomparisonaddon.getComparisonProduct();
            }

        })

    });

}

};
