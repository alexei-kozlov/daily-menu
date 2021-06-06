class DailyMenusController < ApplicationController

    def index
        @menus = DailyMenu.all
    end

    def new
        @menu = DailyMenu.new
        @menu.daily_menu_items.build
    end

    def create
        @menu = DailyMenu.new(daily_menu_params)

        if @menu.save
          redirect_to @menu
        else
          render 'new'
        end
    end

    def show
        @menu = DailyMenu.find(params[:id])
    end

    def edit
        @menu = DailyMenu.find(params[:id])
    end

    def update
        @menu = DailyMenu.find(params[:id])

        if @menu.update(daily_menu_params)
          redirect_to @menu
        else
          render 'edit'
        end
    end

    def destroy
        @menu = DailyMenu.find(params[:id])

        @menu.destroy
        redirect_to daily_menus_path
    end

    private def daily_menu_params
        params.require(:daily_menu).permit(:id, :date, daily_menu_items_attributes: [:id, :menu_item_id, :price, :_destroy])
    end

end
