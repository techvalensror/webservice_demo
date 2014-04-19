class HomeController < ApplicationController
  def index
    @user = User.new
  end
  
  def create
    
  end

  def welcome
    @user = User.where(:id => params[:id])
    @product = Product.new
    @products = Product.all
    puts"%%%%%%%%%%%%%%%%%%%%%%#{@products.inspect}"
  end

  private

  def fact_params
    params.require(:fact).permit(:id ,:title, :content, :author,:fact_image)
  end
end
