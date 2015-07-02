class OrdersController < ApplicationController

  def checkout
    @order = Shoppe::Order.find(current_order.id)
    if request.patch?
      if @order.proceed_to_confirm(params[:order].permit(:first_name, :last_name, :billing_address1, :billing_address2, :billing_address3, :billing_address4, :billing_country_id, :billing_postcode, :email_address, :phone_number))
        @order.confirm!
        session[:order_id] = nil
        redirect_to checkout_confirmation_path, :notice => "Order has been placed successfully!"
      end
    end
  end

  def confirmation

  end

  def destroy
    current_order.destroy
    session[:order_id] = nil
    redirect_to products_path, :notice => "Your belly is empty again."
  end

end
