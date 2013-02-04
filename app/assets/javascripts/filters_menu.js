$(document).ready(function () {

    // Activate deactivate filter icon and color
    $('.filters ul.dropdown-menu a').click(function () {
        var menu_list = $(this).parents('ul.dropdown-menu');
        var main_button = $(this).parents('ul.dropdown-menu').prev();
        var link_text = $(this).text().trim();
        var active_link = $('.icon-ok', menu_list);
        var menu_width = main_button.css('width');

        //main_button.css('width', menu_width); // keep original width
        active_link.removeClass('icon-ok');
        $('i', this).addClass('icon-ok');
        update_main_filter_button(main_button, link_text);

        // Click on option remove filter
        if (/v.echny|zru.it/i.test(link_text)) {
            main_button.removeClass('active');
            $('i', this).removeClass('icon-ok');
            main_button.html(main_button.data('content-original'));
         // Other filter options
        } else {
            main_button.addClass('active');
        }
        set_remove_filters_button();
    })
    var update_main_filter_button = function (el, new_text) {
        el.contents().eq(1).wrap('<span />').parent().text(' ' + new_text + ' ').contents().unwrap();
    }

    var toggle_remove_filters_button = function (action) {
        $('.filters div.filters-remove').css('visibility', action);
    }

    var set_remove_filters_button = function () {
        var active_filters = $('.filters .dropdown-menu a .icon-ok');
        if (active_filters.size() > 0) {
            toggle_remove_filters_button('visible');
        } else {
            toggle_remove_filters_button('hidden');
        }
    }

    // Activate filters
    $('.filters .dropdown-menu a .icon-ok').each(function () {
        var active_link = $(this).parent();
        var link_text = active_link.text();
        var main_button = $(this).parents('ul.dropdown-menu').prev();
        toggle_remove_filters_button('visible');
        main_button.addClass('active');
        update_main_filter_button(main_button, link_text);

    })
    // Save original content for main filter button
    $('.filters a.dropdown-toggle').each(function () {
        var link = $(this);
        link.data('content-original', link.html());
    })


})