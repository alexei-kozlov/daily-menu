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
		@daily_menu_items = @menu.daily_menu_items.eager_load(:menu_item => :category).group_by { |item| item.menu_item.category }
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

		if @menu.destroy
			redirect_to daily_menus_path
		else
			redirect_to @menu
			flash.notice = "Дневное меню на #{l @menu.date} года не может быть удалено, т.к. есть действующий заказ, созданный на его основе!"
		end
	end

	private

	def daily_menu_params
		params.require(:daily_menu)
			  .permit(:id, :date,
					  daily_menu_items_attributes: [
						:id,
						:menu_item_id,
						:price,
						:_destroy
					  ])
	end

	def sort_column
		DailyMenu.column_names.include?(params[:sort]) ? params[:sort] : "date"
	end

	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end

end
