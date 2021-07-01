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

        // Get last price to list > item
        let selectedValue = this.options[this.selectedIndex].value,
            itemBlock = $(this).closest('.menu-item-block').find('.prev-price__item'),
            listBlock = $(this).closest('.menu-item-block').find('.prev-price__list'),
            loader = $(this).closest('.menu-item-block').find('#loader');
        $.ajax({
            url: '/daily_menu_items?menu_item_id=' + selectedValue + '&order=date&sort=desc&limit=1',
            type: 'GET',
            dataType: 'json',
            context: this,
            data: selectedValue,
            beforeSend: function () {
                loader.show();
                listBlock.hide();
            },
            complete: function () {
                loader.hide();
                listBlock.show();
            },
            success: function (data) {
                if (data.length !== 0)
                    itemBlock
                        .attr('data-price', data[0].price)
                        .html(`${data[0].price} грн (${data[0].daily_menu.date})`);
                else
                    itemBlock
                        .attr('data-price', 'not-found')
                        .html('Цена не найдена');
            },
            error: function () {
                itemBlock
                    .attr('data-price', 'not-change')
                    .html('Блюдо не выбрано');
            }
        });
    });
    $(document).ready(function () {
        $('.menu-item-list').trigger('change');
    });

    // Add last price to input
    $(document).on('click', '.prev-price__item', function () {
        let prevPrice = $(this).attr('data-price');
        if (prevPrice !== 'not-found' && prevPrice !== 'not-change')
            $(this)
                .closest('.menu-item-block')
                .find('.price-field')
                .val(prevPrice);
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
