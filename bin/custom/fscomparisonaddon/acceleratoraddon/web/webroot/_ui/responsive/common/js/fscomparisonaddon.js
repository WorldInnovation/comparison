ACC.fscomparisonaddon = {

    _autoload: [
        "addProductToComparison",
        "appendComparisonButton",
        "refreshComparisonList",
        "refreshComparisonTable"
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
                ACC.fscomparisonaddon.refreshComparisonList();
                ACC.fscomparisonaddon.refreshComparisonTable();
            }
        })


    },

    appendComparisonButton: function () {
        $(".btn-comparison").append('<button type="button" class="btn-enter btn btn-primary btn-block"> COMPARE </button>');

    },

    refreshComparisonList: function () {
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

    refreshComparisonTable: function () {
        $('#comparisonTable').on('click', '.comparisonItemLinkClose' , function () {
            debugger;
            const comparisonItemRemove = $(this).data('compare-category-code');
            const baseUrl = $("#comparisonComponent").data('compare-url-category-delete');
            $.ajax({
                url: baseUrl,
                type: 'POST',
                data: {
                    code: comparisonItemRemove
                },
                success: function (data) {
                    ACC.fscomparisonaddon.getComparisonProduct();
                }

            })

        });

    }

    /*   onListenerComparisonCategoryCompare: function () {
        *        $('#comparisonComponent').on('click', '.comparisonCategoryCompare' , function () {
                     debugger;
                     alert("turn off this event");
                     const comparisonCategoryCode = $(this).data('compare-category-code');
                     const baseUrl = $("#comparisonComponent").data('comp-url-category-compare');
         /*            $.ajax({
                         url: baseUrl,
                         type: 'POST',
                         data: {
                             code: comparisonCategoryCode
                         },
                         success: function (data) {
                             /!*ACC.fscomparisonaddon.getComparisonProduct();*!/
                         }

                     })

          });
      }*/


};
