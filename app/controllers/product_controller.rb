class ProductController < ApplicationController
  protect_from_forgery
  def new
    @product = Product.new
  end
  def create
    @product = Product.create(product_params)
       respond_to do |format|
    if @product.save
        format.html {redirect_to welcome_path(session[:user_id]), :notice => "Successfully Add Product"}
        format.json {render :json => {:message => "Successfully Add Product"}}
        format.xml {render :xml => {:message => "Successfully Add Product"}}
    else
      format.html { render :action => "new" }
      format.xml  { render :xml => @product.errors.to_xml, :status => 400 }
      format.json { render :json => @product.errors.to_json, :status => 400 }
  end
    end
  end

  def edit
    @products = Product.where(:id => params[:id]).first
  end

  def update
    @products = Product.where(:id => params[:product][:id]).first
    @products.update_attributes(product_params)
    respond_to do |format|
    if @products.save
        format.html {redirect_to welcome_path(session[:user_id]), :notice => "Successfully Update Product"}
        format.json {render :json => {:message => "Successfully Update Product"}}
        format.xml {render :xml => {:message => "Successfully Update Product"}}
    else
      format.html { render :action => "new" }
      format.xml  { render :xml => @products.errors.to_xml, :status => 400 }
      format.json { render :json => @products.errors.to_json, :status => 400 }
  end
    end
  end

  def delete
    @products = Product.where(:id => params[:id]).first
    respond_to do |format|
      if @products.present?
        @products.destroy
        format.html {redirect_to welcome_path(session[:user_id]), :notice => "Successfully Deleted Product"}
        format.json {render :json => {:message => "Successfully Deleted Product"}}
        format.xml {render :xml => {:message => "Successfully Deleted Product"}}
      else
       format.html { render :action => "welcome" , :controller => "home" , :id => session[:user_id] }
      format.xml  { render :xml =>  {:message => "Product is Not Available", :status => 400 } }
      format.json { render :json =>{:message => "Product is Not Available", :status => 400 }}
      end
  end
    end

  
  def show
    @products = Product.all
    respond_to do |format|
      if @products.present?
        format.json {render :json => @products}
        format.xml {render :xml => @products}
      else
        format.xml  { render :xml => {:message => "There is no Product"} }
        format.json { render :json => {:message => "There is no Product"} }
      end
    end
  end



    private

  def product_params
    params.require(:product).permit(:id ,:name, :price)
  end
end
