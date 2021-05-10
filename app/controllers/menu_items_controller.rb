class MenuItemsController < ApplicationController
    http_basic_authenticate_with name: "admin", password: "qwerty",
    except: [:index, :show]

    def index
        @dishes = MenuItem.all
    end

    def new
        @dish = MenuItem.new
        @categories = Category.all.map{|c| [ c.title, c.id ] }
        @pricings = Pricing.all.map{|p| [ p.pricing_type, p.id ] }
    end

    def show
        @dish = MenuItem.find(params[:id])
    end

    def edit
        @dish = MenuItem.find(params[:id])
        @categories = Category.all.map{|c| [ c.title, c.id ] }
        @pricings = Pricing.all.map{|p| [ p.pricing_type, p.id ] }
    end

    def update
        @dish = MenuItem.find(params[:id])
        @dish.category_id = params[:category_id]
        @dish.pricing_id = params[:pricing_id]

        if @dish.update(dish_params)
          redirect_to menu_items_path
        else
          render 'edit'
        end
    end

    def destroy
        @dish = MenuItem.find(params[:id])

        @dish.destroy
        redirect_to menu_items_path
    end

    def create
        # render plain: params[:menu_item].inspect
        @dish = MenuItem.new(dish_params)
        @categories = Category.all.map{|c| [ c.title, c.id ] }
        @pricings = Pricing.all.map{|p| [ p.pricing_type, p.id ] }

        if @dish.save
          redirect_to menu_items_path
        else
          render 'new'
        end
    end

    private def dish_params
        params.require(:menu_item).permit(:title, :category_id, :pricing_id, :price)
    end
end
