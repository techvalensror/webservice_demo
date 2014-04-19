class LoginController < ApplicationController
   protect_from_forgery
  def new
    @user = User.new
  end

  def create
    @user = User.new
    user = User.authenticate(params[:user][:email], params[:user][:password])
    respond_to do |format|
      if user.present?
        session[:user_id] = user.id
        format.html {flash[:notice] = 'Welcome #{user.first_name}'
        redirect_to welcome_path(user)}
        format.json {render :json => {:message => user}}
        format.xml {render :xml => {:message => user}}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => "Invalid Login ID or Password !", :status => 400 }
        format.json { render :json => 'Invalid Login ID or Password !', :status => 400 }
      end
    end
  end
end
