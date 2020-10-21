class ProductRoutesController < ApplicationController
  # GET /product_routes
  def index
  end

  # GET /product_routes/1
  def show
  end

  # POST /product_routes
  def create
    reference = product_route_params[:reference]
    if reference.blank?
      redirect_to(action: :index, notice: "Reference cannot be empty") && return
    end

    @product_route = ProductRoute.new(reference)

    render :show
  end

  private

  def product_route_params
    params.require(:product_route).permit(:reference)
  end
end
