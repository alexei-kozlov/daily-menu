class DailyMenuItemsController < ApplicationController

    def index

         finder = DailyMenuItem.all

         if params.key? :menu_item_id
            menu_item = MenuItem.find params[:menu_item_id]
            finder = finder.where menu_item_id: menu_item
         end

         if params.key? :limit
            finder = finder.limit params[:limit]
         end

         if params.key? :order
            sort = if params.key? :sort
               params[:sort]
            else
               :asc
            end
            finder = finder.order(params[:order] => sort)
         end

         render :json => finder
                        .eager_load(:daily_menu, :menu_item),
                :only => :price,
                :include => [
                             :menu_item => { :only => :title },
                             :daily_menu => { :only => :date }
                             ]
    end

end
