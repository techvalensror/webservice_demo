class RegistrationController < ApplicationController
  protect_from_forgery
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    respond_to do |format|
    if @user.save
        format.html {redirect_to root_url, :notice => "Successfully Registerd"}
        format.json {render :json => {:message => "Successfully Registerd"}}
        format.xml {render :xml => {:message => "Successfully Registerd"}}
    else
      format.html { render :action => "new" }
      format.xml  { render :xml => @user.errors.to_xml, :status => 400 }
      format.json { render :json => @user.errors.to_json, :status => 400 }
  end
    end

    end
# curl -X POST -d "user[first_name]=Yogesh&user[last_name]=Waghmare&user[email]=yogesh@gmail.com&user[password]=123&user[password_confirmation]=123" http://192.168.1.38:3000/registration/create.json
#  curl -X POST -d "user[email]=yogesh@gmail.com&user[password]=123" http://192.168.1.38:3000/login/create.json
#  curl -X POST -d "product[name]=TV&product[price]=5000" http://192.168.1.38:3000/product/create.json
#  curl -X POST -d "product[id]=3&product[name]=TV&product[price]=5000" http://192.168.1.38:3000/product/update.json
#  curl -X POST -d "product[id]=3" http://192.168.1.38:3000/product/delete/3.json
#  curl -X GET  http://192.168.1.38:3000/product/show.json
  private

  def user_params
    params.require(:user).permit(:id ,:first_name, :last_name, :email,:password_hash, :password_salt, :password,:password_confirmation)
  end
end
