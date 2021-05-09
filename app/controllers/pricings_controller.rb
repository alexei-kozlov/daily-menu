class PricingsController < ApplicationController
    http_basic_authenticate_with name: "admin", password: "qwerty",
    except: [:index]

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

        @pricing.destroy
        redirect_to pricings_path
    end

    def create
        # render plain: params[:pricing].inspect
        @pricing = Pricing.new(pricing_params)

        if @pricing.save
          redirect_to pricings_path
        else
          render 'new'
        end
    end

    private def pricing_params
        params.require(:pricing).permit(:pricing_type, :volume_id)
    end
end
