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
    let pricing_desc = {
            'per_unit': '/за объем пропорционально ',
            'per_qty': '/за порцию в размере '
        },
        unit_desc = {
            'ml': ' мл',
            'gr': ' грамм'
        };
    // Add description for DailyMenuItem
    $(document).on('change', '.menu-item-list', function () {
        let selectedOption = this.options[this.selectedIndex].dataset,
            volume = selectedOption.volume,
            pricing = selectedOption.pricing,
            unit = selectedOption.unit;

        console.log(pricing);

        if (pricing)
            $(this)
                .closest('.menu-item-block')
                .find('.pricing')
                .html(pricing_desc[pricing] + volume + unit_desc[unit]);
    });
    $(document).ready(function () {
        $('.menu-item-list').trigger('change');
    });

    /*
$(document).ready(function () {
    $('#menu_item_pricing_id option:contains("per_unit")').text(pricing_desc.per_unit);
    $('#menu_item_pricing_id option:contains("per_qty")').text(pricing_desc.per_qty)
});

$(document).on('change', '.menu-item-list', function() {
    console.log('change in work');
    let $data_pricing = $(this).find(':selected').data('pricing'),
        $data_volume = $(this).find(':selected').data('volume'),
        $data_unit = $(this).find(':selected').data('unit');
    if ($data_pricing === 'За порцию')
        $(this)
            .closest('fieldset.menu-item-block')
            .find('.pricing')
            .text(`/${$data_pricing}\n(${$data_volume} ${$data_unit})`);
    else if ($data_pricing === 'За объем') {
        $(this)
            .closest('fieldset.menu-item-block')
            .find('.pricing')
            .text(+`/за ${$data_volume} ${$data_unit}`);
    }
});
*/

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
