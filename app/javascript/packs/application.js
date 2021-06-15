// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import $ from 'jquery';
window.jQuery = $;
window.$ = $;

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
ActiveStorage.start()

;(function ($) {
    // Add description for DailyMenuItem
    $(document).on('change', '.menu-item-list', function() {
        let $data_pricing = [],
            $data_volume = [],
            $data_unit = [];
        $('.menu-item-list option:selected').each(function(i, selected){
            $data_pricing[i] = $(selected).data('pricing');
            $data_volume[i] = $(selected).data('volume');
            $data_unit[i] = $(selected).data('unit');
            if ($data_pricing[i] === 'За порцию')
            $(this)
                .closest('fieldset.menu-item-block')
                .find('.pricing')
                .text('/' + $data_pricing[i] + '\n' + '(' + $data_volume[i] + ' ' + $data_unit[i] + ')');
            else if ($data_pricing[i] === 'За объем') {
                $(this)
                    .closest('fieldset.menu-item-block')
                    .find('.pricing')
                    .text('/за ' + $data_volume[i] + ' ' + $data_unit[i]);
            }
        });
    });
    $(document).ready(function() {
        $('.menu-item-list').trigger('change');
    });

    // Remove MenuItem (dish) from :new DailyMenu
    $(document).on('click', '[data-link-to-remove-field]', function (e) {
        let $field, target;
        e.preventDefault();
        $(this).prev('input[type=hidden]').val('1');
        target = $(this).data('link-to-remove-field');
        $field = $(this).closest(target);
        return $field.hide();
    });

    // Add MenuItem (dish) from :new DailyMenu
    $(document).on('click', '[data-link-to-add-field]', function (e) {
        let fields_html, regexp, time;
        e.preventDefault();
        time = new Date().getTime();
        regexp = new RegExp($(this).data('link-to-add-field-id'), 'g');
        fields_html = $(this).data('link-to-add-field').replace(regexp, time);
        return $(this).before(fields_html);
    });
})(jQuery);
