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
			ordered = params[:order] if %w[date price].include?(params[:order].downcase)
			if ordered
				sorted = params[:sort].downcase == 'desc' ? 'desc' : 'asc'
				finder = finder.order(ordered => sorted)
			end
		end

		render :json => finder
						  .eager_load(:daily_menu, :menu_item),
			   :only => [:price, :id],
			   :include => [
				 :menu_item => { :only => :title },
				 :daily_menu => { :only => :date }
			   ]
	end

end