class DailyMenusController < ApplicationController
    helper_method :sort_column, :sort_direction

    def index
        @menus = DailyMenu.all.order(sort_column + " " + sort_direction)
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

    private

    def daily_menu_params
        params.require(:daily_menu).permit(:id, :date, daily_menu_items_attributes: [:id, :menu_item_id, :price, :_destroy])
    end

    def sort_column
      DailyMenu.column_names.include?(params[:sort]) ? params[:sort] : "date"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
