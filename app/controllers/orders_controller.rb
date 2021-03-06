class OrdersController < ApplicationController

	def index
		@orders = Order.all.order(created_at: :desc).paginate(page: params[:page], :per_page => 10)
	end

	def new
		@order = Order.new

		if params.key? :daily_menu_id
			@daily_menu = DailyMenu.find params[:daily_menu_id]
			@order.daily_menu = @daily_menu
			@daily_menu_items = @daily_menu
								  .daily_menu_items
								  .eager_load(:menu_item => :category)
								  .group_by { |item| item.menu_item.category }
		end
	end

	def create
		@order = Order.new(order_params)

		if @order.save
			redirect_to @order
		else
			@daily_menu_items = @order
								  .daily_menu
								  .daily_menu_items
								  .eager_load(:menu_item => :category)
								  .group_by { |item| item.menu_item.category } if @order.daily_menu.present?
			render 'new'
		end
	end

	def show
		@order = Order.find(params[:id])
	end

	def edit
		@order = Order.find(params[:id])
		@daily_menu_items = @order
							  .daily_menu
							  .daily_menu_items
							  .eager_load(:menu_item => :category)
							  .group_by { |item| item.menu_item.category }
	end

	def update
		@order = Order.find(params[:id])

		if @order.update(order_params)
			redirect_to @order
		else
			@daily_menu_items = @order
								  .daily_menu
								  .daily_menu_items
								  .eager_load(:menu_item => :category)
								  .group_by { |item| item.menu_item.category }
			render 'edit'
		end
	end

	def destroy
		@order = Order.find(params[:id])

		@order.destroy
		redirect_to orders_path
	end

	private

	def order_params
		params.require(:order)
			  .permit(:id, :total_cost, :daily_menu_id,
					  order_items_attributes: [
						:id,
						:daily_menu_item_id,
						:quantity_por,
						:quantity_vol,
						:cost,
						:_destroy
					  ])
	end
end