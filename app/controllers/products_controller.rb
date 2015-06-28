class ProductsController < ApplicationController

   def index
    @products = Shoppe::Product.root.ordered.includes(:product_categories, :variants)
    @products = @products.group_by(&:product_category)

  end

  def buy
    @product = Shoppe::Product.find_by_permalink!(params[:permalink])
    current_order.order_items.add_item(@product, 1)
    redirect_to product_path(@product.permalink), :notice => "Da meal is in your belly!"
  end

  def show
    @product = Shoppe::Product.find_by_permalink(params[:permalink])
  end

end
