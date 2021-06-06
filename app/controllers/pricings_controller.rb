class PricingsController < ApplicationController

    def index
        @pricings = Pricing.all
    end

    def new
        @pricing = Pricing.new
    end

    def show
        @pricing = Pricing.find(params[:id])
    end

    def edit
        @pricing = Pricing.find(params[:id])
    end

    def update
        @pricing = Pricing.find(params[:id])
        if @pricing.update(pricing_params)
          redirect_to pricings_path
        else
          render 'edit'
        end
    end

    def destroy
        @pricing = Pricing.find(params[:id])

        if @pricing.destroy
           redirect_to pricings_path
        else
           redirect_to @pricing
           flash.notice = "Этот тип ценообразования не может быть удален, т.к. он используется!"
        end
    end

    def create
        @pricing = Pricing.new(pricing_params)
        if @pricing.save
          redirect_to pricings_path
        else
          render 'new'
        end
    end

    private def pricing_params
        params.require(:pricing).permit(:pricing_type)
    end
end
