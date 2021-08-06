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
    // Add onChange event for MenuItem
    $(document).on('change', '.menu-item-list', function () {
        // Add description library
        let pricing_desc = {
                'per_unit': '/за объем пропорционально ',
                'per_qty': '/за порцию в размере '
            },
            unit_desc = {
                'ml': ' мл',
                'gr': ' грамм'
            };

        // Initializing & calling function to add description for DailyMenuItem
        let selectedOption = this.options[this.selectedIndex].dataset,
            volume = selectedOption.volume,
            pricing = selectedOption.pricing,
            unit = selectedOption.unit;
        if (pricing)
            $(this)
                .closest('.menu-item-block')
                .find('.pricing')
                .html(pricing_desc[pricing] + volume + unit_desc[unit]);
        else $(this)
            .closest('.menu-item-block')
            .find('.pricing')
            .html('');

        // Initializing & calling function to get prev price to list > item
        let selectedValue = this.options[this.selectedIndex].value,
            itemBlock = $(this).closest('.menu-item-block').find('.prev-price__item'),
            listBlock = $(this).closest('.menu-item-block').find('.prev-price__list'),
            loader = $(this).closest('.menu-item-block').find('#loader');
        if (selectedValue) {
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
                }
            });
        } else {
            itemBlock
                .attr('data-price', 'not-change')
                .html('Блюдо не выбрано');
        }
    });

    // Add prev price to input
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

    // Add MenuItem (dish) to :new DailyMenu
    $(document).on('click', '[data-link-to-add-field]', function (e) {
        let fields_html, regexp, time;
        e.preventDefault();
        time = new Date().getTime();
        regexp = new RegExp($(this).data('link-to-add-field-id'), 'g');
        fields_html = $(this).data('link-to-add-field').replace(regexp, time);
        return $(this).before(fields_html);
    });

    // Initializing & calling function to get value DailyMenu.select
    $(document).on('change', '.date-list', function () {
        let selectedDateValue = this.options[this.selectedIndex].value;
        window.location.href = $('.date-list :selected').data('url') + selectedDateValue;
    });

    // Initializing function to get Order's total cost
    function totalCost() {
        let orderTotalCost = $('.order__total-cost'),
            orderTotalCostDesc = $('.order__total-cost-desc'),
            totalCost = 0;
        $('.order__cost').each(function () {
            if ($(this).val() > 0)
                totalCost += +$(this).val();
        });
        orderTotalCost.val(totalCost.toFixed(2));
        orderTotalCostDesc.text(totalCost.toFixed(2) + ' грн.');
    }

    // Change event on edit OrderItem's quantity of dish
    $(document).on('change', '.order__por', function () {
        let currentQtyPor = $(this).closest('.order__form-group').find('.order__por').val(),
            currentCost = $(this).closest('.order__form-group').find('.order__cost'),
            currentCostDesc = $(this).closest('.order__form-group').find('.order__cost-desc'),
            portion = $(this).closest('.order__item').find('.order__check').data('portion'),
            price = $(this).closest('.order__item').find('.order__check').data('price'),
            cost = (price * currentQtyPor / portion).toFixed(2);

        if (currentQtyPor < 0) cost = '—';
        currentCost.val(cost);
        currentCostDesc.text(cost + ' грн.');
        totalCost();
    });

    // Change event on edit OrderItem's volume of dish
    $(document).on('change', '.order__vol', function () {
        let currentQtyVol = $(this).closest('.order__form-group').find('.order__vol').val(),
            currentCost = $(this).closest('.order__form-group').find('.order__cost'),
            currentCostDesc = $(this).closest('.order__form-group').find('.order__cost-desc'),
            volume = $(this).closest('.order__item').find('.order__check').data('volume'),
            price = $(this).closest('.order__item').find('.order__check').data('price'),
            cost = (price * currentQtyVol / volume).toFixed(2);

        if (currentQtyVol < 0) cost = '—';
        currentCost.val(cost);
        currentCostDesc.text(cost + ' грн.');
        totalCost();
    });

    // Checked event on create OrderItem from DailyMenuItem
    $(document).on('click', '.order__check', function () {
        let destroyField = $(this).closest('.order__item').find('.destroy-field'),
            prevCost = $(this).closest('.order__item').find('.order__cost'),
            prevCostDesc = $(this).closest('.order__item').find('.order__cost-desc'),
            prevQtyPor = $(this).closest('.order__item').find('.order__por'),
            prevQtyVol = $(this).closest('.order__item').find('.order__vol'),
            volume = $(this).data('volume'),
            portion = $(this).data('portion'),
            price = $(this).data('price');

        if ($(this).is(':checked')) {
            destroyField.val(0);
            prevQtyPor.removeAttr('disabled').val(portion);
            prevQtyVol.removeAttr('disabled').val(volume);
            prevCost.val(price);
            prevCostDesc.text(price + ' грн.');
            $('input[type=submit]').removeAttr('disabled');
            $('.order_message').hide();
        } else {
            destroyField.val(1);
            prevQtyPor.attr('disabled', 'disabled').val('');
            prevQtyVol.attr('disabled', 'disabled').val('');
            prevCost.val('');
            prevCostDesc.text('0.00 грн');
        }

        $('.order__por').trigger('change');
        $('.order__vol').trigger('change');
        totalCost();
    });

    // Validation of checkboxes Order's form (checked / unchecked)
    $(document).on('submit', '#new_order', function (e) {
        $('.order__check').each(function () {
            if ($('.order__check').is(':checked') === false) {
                $('.order_message').show();
                e.preventDefault();
            } else return false;
        });
    });

    // Add trigger some events
    $(document).ready(function () {
        $('.menu-item-list').trigger('change');
        $('.order__por').trigger('change');
        $('.order__vol').trigger('change');

        // Calling function to get value DailyMenu.select in some actions (:new or :edit)
        $('.date-list option').each(function () {
            let url = window.location.href,
                host = window.location.host;
            if (url.indexOf(host + '/orders/') !== -1) {
                if ($(this).val().length !== 0)
                    $(this).attr('data-url', 'new?daily_menu_id=');
                else
                    $(this).attr('data-url', 'new');
            } else {
                if ($(this).val().length !== 0)
                    $(this).attr('data-url', '/orders/new?daily_menu_id=');
                else
                    $(this).attr('data-url', '/orders/new');
            }
        });

        // Calculate OrderItem's quantity of portion & volume, cost on edit Order
        $('.order__check[checked=checked]').each(function () {
            let checkItem = $(this).closest('.order__item');
            checkItem.find('.destroy-field').val(0);
            checkItem.find('.order__por').removeAttr('disabled');
            checkItem.find('.order__vol').removeAttr('disabled');
        });
    });
})(jQuery);


