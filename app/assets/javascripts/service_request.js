$(document).ready(function () {
    $('select[name*="[product_category_id]"]').live('change', function () {
        //[name*="[defect_description]"]
        if (description_is_edited()) {

            var r = confirm("Informace z formuláře budou ztracena, pokud budete pokračovat");
            if (r == false) {
                return false;
            }
        }

        var selected = $('option:selected', this).attr('value');
        if (selected) {
            $.ajax({
                url:'/product_categories/' + selected,
                dataType:"script",
                success:function () {
                }
            });
        }
    })

    var defect_description = $('textarea[name*="[defect_description]"]');
    var defect_description_edited = $('input[name*="[defect_description_edited]"]');

    var description_is_edited = function () {
        if (defect_description.data('edited') == 'true' ||
            defect_description_edited.attr('value') == 'true' ||
            defect_description_edited.attr('value') == '1') {
            return true;
        }
    };
    // POPOVER HELP
    defect_description.popover({
        trigger:'hover',
        live:true,
        content:function (el) {
            return $(this).data('content') || 'Nejdříve vyberte kategorii produktu';
        },
        title:function () {
            return $(this).attr('title') || 'Nápověda';
        }
    });

    defect_description.focusin(function () {
        $(this).data('edited', true);
        defect_description_edited.attr('value', true);
    })

    $('a.alternative_date').click(function () {
        $('div.alternative_date').toggle('slow');
    });

    // POPOVER PICKUP INFO
    $('textarea[name*="[pickup_info]"]').popover({
        trigger:'hover'
    });

    $('input[rel="popover"]').popover({
        trigger:'hover',
        live:true,
        content:function (el) {
            return $(this).data('content') || 'Nejdříve vyberte kategorii produktu';
        },
        title:function () {
            return $(this).attr('title') || 'Nápověda';
        }
    });

    // SWITCH REGISTER LOGIN FORM
    $('.switch_account input').click(function () {
        $('.switch').hide();
        var value = $(this).val();
        $('#switch_' + value).show('slow');
    })
    $('.switch_account input:checked').trigger('click');

})