class AdminController < ApplicationController
  def register
  end

  def login
  end
  
  def loginProcess
    user = User.find_by_userid(params[:userid])
    if user.nil?
      flash[:error] = "No such user"
      redirect_to :action => 'login'
    elsif user.passwordhash != params[:password]
      flash[:error] = "Wrong password"
      redirect_to :action => 'login'
    else
      userarray = Clubusers.where(userid:params[:userid])
      if userarray.size == 0
        #redirect to useless page
        redirect_to :action => 'login'
      elsif userarray.size > 1
        session[:userid]=user.userid
        redirect_to :action => 'chooserole'
      elsif userarray.size == 1
        session[:userid]=user.userid
        session[:role] = userarray[0].role
        session[:club] = userarray[0].clubid
        redirect_to :action => 'home'
      end
    end
  end

  def chooserole
    @userarray = Clubusers.where(userid:session[:userid])
  end
  
  def chooseroleProcess
    session[:role]=params[:role]
    session[:club]=params[:club]
    redirect_to :action => 'home'
  end
  
  def logout
    session[:userid] = nil
    session[:role] = nil
    session[:club] = nil
    redirect_to :action => 'login'
  end

  def home
  end

  def newrequest
  end

  def viewrequests
  end
end
