class DailyMenuItemsController < ApplicationController

    def index

        if params[:menu_item_id] == nil
            render :json => DailyMenuItem.all, :only => :price, :include =>
            [:menu_item => { :only => :title }, :daily_menu => { :only => :date }]
        else
            render :json =>
            DailyMenuItem.where(menu_item_id: params[:menu_item_id]).
                          #joins(:daily_menu).
                          eager_load(:daily_menu).
                          order(date: :desc).
                          limit(1),
            :only => :price, :include => [:menu_item => { :only => :title }, :daily_menu => { :only => :date }]
        end

    end

end
