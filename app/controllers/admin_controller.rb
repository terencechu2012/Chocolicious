class AdminController < ApplicationController
  def register
    @userList=Clubusers.where(clubid:session[:club])
    @users=User.all
    @allClubs = Club.all
    @cbds = Club.where(clubtype: 'cbd')
    @clubRequests = Request.where(clubid:session[:club])
    @cbdList = Clubusers.where(role:'cbdfinsec')
    @clubs = Request.joins("INNER JOIN clubs on clubs.clubid = requests.clubid").where(:userid => session[:userid])
  end

  def requestClub
    Request.create(:userid => session[:userid], :clubid => params[:cName])
    redirect_to :action => 'register'
  end

  def delete
    if params[:toDelete] != nil
      params[:toDelete].each do |userid|
        d = Clubusers.find_by_userid_and_clubid(userid,params[:club])
        d.delete
      end
    end
    redirect_to :action => 'register'
  end

  def notifications
    if params[:newRegister] != nil && params[:choice] == "Add"
      params[:newRegister].each do |userid|
        @userCount=Clubusers.where("clubid = ? AND userid = ?", session[:club], userid).count
        if @userCount==0
          Clubusers.create(:userid => userid, :clubid => session[:club], :role => "normal")
          Request.find_by_userid_and_clubid(userid, session[:club]).delete
        else
          Request.find_by_userid_and_clubid(userid, session[:club]).delete
          flash[:error]="Member already exists"        
        end
      end
    elsif params[:newRegister] != nil && params[:choice] == "Reject"
      params[:newRegister].each do |userid|
        Request.find_by_userid_and_clubid(userid, session[:club]).delete
      end
    end

    redirect_to :action => 'register'
  end

  def add
    @userCount=Clubusers.where("clubid = ? AND userid = ? AND role = ?", session[:club], params[:userid], params[:role]).count
    if @userCount==0
      Clubusers.create(:userid => params[:userid], :clubid => params[:club], :role => params[:role])
    end
    redirect_to :action => 'register'
  end

  def addLeader
    c = Club.find_by_clubid(params[:club])
    if params[:role] == 'cbdfinsec' || params[:role] == 'clubfinsec'
      c.update_attribute(:finsecid, params[:userid])

    end
    add
  end

  def login
  end

  def setUserId
    user = current_user.email
    location = user.index('@')
    id = user.slice(0,location+1)
    userrec = User.find_by_email(user)
    userrec.update_attribute(userid:id)
    redirect_to :action => 'users/sign_in'
  end

  def loginProcess
    # user = User.find_by_userid(params[:userid])
    # if user.nil?
    # flash[:error] = "No such user"
    # redirect_to :action => 'login'
    # elsif user.passwordhash != params[:password]
    # flash[:error] = "Wrong password"
    # redirect_to :action => 'login'
    user = current_user.userid
    if user.nil? || user == ""
      user = current_user.email
      location = user.index('@')
      temp = user.slice(0,location)

      p 'HERE!!!'
      userrec = User.find_by_email(user)
      p userrec
      userrec.update_attribute(:userid, temp)
    end
    user = current_user.userid
    userarray = Clubusers.where(userid:user)
    p userarray.size
    if userarray.size == 0
      #redirect to useless page
      session[:userid]=user
      session[:role] = nil
      session[:club] = nil
      redirect_to :action => 'register'
    elsif userarray.size > 1
      session[:userid]=user
      redirect_to :action => 'chooserole'
    elsif userarray.size == 1
      session[:userid]=user
      session[:role] = userarray[0].role
      session[:club] = userarray[0].clubid
      redirect_to :action => 'home'
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
