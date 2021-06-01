class DailyMenusController < ApplicationController
    http_basic_authenticate_with name: "admin", password: "qwerty",
    except: [:index, :show]

    def index
        @menus = DailyMenu.all
    end

    def new
        @menu = DailyMenu.new
        @menu.daily_menu_items.build
        @items = MenuItem.all.map{|i| [ i.title, i.id ] }
    end

    def create
        @menu = DailyMenu.new(daily_menu_params)
        @items = MenuItem.all.map{|i| [ i.title, i.id  ] }

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
        @items = MenuItem.all.map{|i| [ i.title, i.id ] }
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
