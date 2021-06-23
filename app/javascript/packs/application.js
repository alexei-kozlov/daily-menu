// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

window.jQuery = $;
window.$ = $;
import $ from 'jquery';
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
        if (pricing)
            $(this)
                .closest('.menu-item-block')
                .find('.pricing')
                .html(pricing_desc[pricing] + volume + unit_desc[unit]);

        // Get last price to select > option
        /*let selectedValue = this.options[this.selectedIndex].value;
        let options = $('.prev-price option:last-child');
        $.ajax({
            url: '/daily_menu_items?menu_item_id=' + selectedValue,
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                console.log(data);
                if (data.length !== 0)
                    options
                        .replaceWith($('<option/>')
                            .attr('id', 'option-price')
                            .val(data[0].price)
                            .html(`${data[0].price} грн (${data[0].daily_menu.date})`));
                else options
                    .replaceWith($('<option/>')
                        .attr('id', 'option-price')
                        .val('not-found')
                        .html('Цена не найдена'));
            },
            error: function () {
                console.log('Error');
            }
        });*/
    });
    $(document).ready(function () {
        $('.menu-item-list').trigger('change');
    });

    // Add last price to input
    $(document).on('change', '.prev-price', function () {
        let prevPrice = $('.prev-price option:selected').attr('value');
        let input = $('.price-field').val(prevPrice);
        console.log(input);
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
