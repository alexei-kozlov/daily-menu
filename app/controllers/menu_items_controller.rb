class MenuItemsController < ApplicationController

	def index
		@dishes = MenuItem.all
	end

	def new
		@dish = MenuItem.new
	end

	def create
		@dish = MenuItem.new(dish_params)

		if @dish.save
			redirect_to @dish
		else
			render 'new'
		end
	end

	def show
		@dish = MenuItem.find(params[:id])
	end

	def edit
		@dish = MenuItem.find(params[:id])
	end

	def update
		@dish = MenuItem.find(params[:id])

		if @dish.update(dish_params)
			redirect_to menu_items_path
		else
			render 'edit'
		end
	end

	def destroy
		@dish = MenuItem.find(params[:id])

		if @dish.destroy
			redirect_to menu_items_path
		else
			redirect_to @dish
			flash.notice = "Блюдо «#{@dish.title}» не может быть удалено, т.к. оно включено в дневное меню!"
			# flash.notice = "«#{@dish.title}» can not be deleted, because it is included in the daily menu!"
		end
	end

	private def dish_params
		params.require(:menu_item).permit(:title, :category_id, :pricing_id, :volume, :unit_id)
	end

end
