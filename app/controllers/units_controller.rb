class UnitsController < ApplicationController

    def index
        @units = Unit.all
    end

    def new
        @unit = Unit.new
    end

    def show
        @unit = Unit.find(params[:id])
    end

    def edit
        @unit = Unit.find(params[:id])
    end

    def update
        @unit = Unit.find(params[:id])
        if @unit.update(unit_params)
          redirect_to units_path
        else
          render 'edit'
        end
    end

    def destroy
        @unit = Unit.find(params[:id])

        if @unit.destroy
           redirect_to units_path
        else
           redirect_to @unit
           flash.notice = "Эта единица измерения не может быть удалена, т.к. она используется!"
        end
    end

    def create
        @unit = Unit.new(unit_params)
        if @unit.save
          redirect_to units_path
        else
          render 'new'
        end
    end

    private def unit_params
        params.require(:unit).permit(:unit_type)
    end
end
