class CategoriesController < ApplicationController

    def index
        @cats = Category.all
    end

    def new
        @cat = Category.new
    end

    def show
        @cat = Category.find(params[:id])
    end

    def edit
        @cat = Category.find(params[:id])
    end

    def update
        @cat = Category.find(params[:id])

        if @cat.update(category_params)
          redirect_to categories_path
        else
          render 'edit'
        end
    end

    def destroy
        @cat = Category.find(params[:id])

        if @cat.destroy
           redirect_to categories_path
        else
           redirect_to @cat
           flash.notice = "Категория «#{@cat.title}» не может быть удалена, т.к. содержит список блюд!"
        end
    end

    def create
        @cat = Category.new(category_params)

        if @cat.save
          redirect_to categories_path
        else
          render 'new'
        end
    end

    private def category_params
        params.require(:category).permit(:title)
    end

end
