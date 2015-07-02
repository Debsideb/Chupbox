class ProductsController < ApplicationController

   def index
    @products = Shoppe::Product.root.ordered.includes(:product_categories, :variants)
    @products = @products.group_by(&:product_category)

  end

  def buy
    @product = Shoppe::Product.root.find_by_permalink!(params[:permalink])
    current_order.order_items.add_item(@product, 1)
    current_order.reload
    payload = {
      total_items: current_order.total_items,
      total_before_tax: current_order.total_before_tax
    }
    render json: payload
  end

  def show
    @product = Shoppe::Product.root.find_by_permalink(params[:permalink])
  end

end
