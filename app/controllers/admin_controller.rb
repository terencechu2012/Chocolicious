class AdminController < ApplicationController
  def register
    @userList=Clubusers.where(clubid:session[:club])
    @users=User.where.not(userid: session[:userid])
    @allClubs = Club.where("clubtype != 'cbd' and clubtype <> 'smusa' and clubtype != 'infinite'")
    @clubsUnderCbd = Club.where(clubtype: session[:club])
    @cbds = Club.where(clubtype: 'cbd')
    @clubRequests = Request.where(clubid:session[:club])
    @cbdList = Clubusers.where(role:'cbdfinsec')
    @clubFinSecList = Clubusers.where(['clubid in (select clubid from clubs where clubtype = ?) AND role = ?', session[:club], 'clubfinsec'])
    @clubs = Request.joins("INNER JOIN clubs on clubs.clubid = requests.clubid").where(:userid => session[:userid])
    @cbdmcList = Clubusers.where(clubid:session[:club])
    @smusasecList = Clubusers.where(role: 'smusasec')
    @departments = Club.where(clubtype: 'smusa')
  end

  def requestClub
    if params[:cName] == ""
      flash[:error] = "Problem with request!"
      redirect_to :action => 'register'
    else
      begin
        Request.create(:userid => session[:userid], :clubid => params[:cName])

      rescue
        flash[:error] = "Problem with request!"

      end
      redirect_to :action => 'register'
    end

  end

  def delete
    if params[:toDelete] != nil
      params[:toDelete].each do |x|
        y = x.split(",")
        d = Clubusers.find_by_userid_and_clubid(y[0],y[1])
        d.delete
        
      end
    end
    redirect_to :action => 'register'
  end

  def deleteRequest
    r = Request.find_by_id(params[:id])
    r.delete
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
      begin
        Clubusers.create(:userid => params[:userid], :clubid => params[:club], :role => params[:role])
      rescue
        flash[:error] = "Problem with request!"
      end
      
    end
    redirect_to :action => 'register'
  end

  def addLeader
    c = Club.find_by_clubid(params[:club])
    if params[:role] == 'cbdfinsec' || params[:role] == 'clubfinsec'
      c.update_attribute(:finsecid, params[:userid])
    elsif params[:role] == 'president'
      c.update_attribute(:presidentid, params[:userid])
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
    redirect_to :action => 'users/sign_in', :layout => false
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
    elsif userarray.size >= 1
      session[:userid]=user
      @userarray = Clubusers.find_by_sql(["select distinct clubid from clubusers where userid = ? order by clubid", session[:userid]])
      firstClub = @userarray[0]
      firstClubid = firstClub.clubid
      session[:club] = firstClubid
      @userarray2 = Clubusers.where(userid:session[:userid], clubid:firstClubid)
      roles = []
      @userarray2.each { |clubuser|
        roles << clubuser.role
      }
      session[:role] = roles.join(',')
      redirect_to :action => 'home'
    elsif userarray.size == 1
      session[:userid]=user
      session[:role] = userarray[0].role
      session[:club] = userarray[0].clubid
      redirect_to :action => 'home'
    end
  end

  def chooserole
    # @userarray = Clubusers.where(userid:session[:userid])
    @userarray = Clubusers.find_by_sql(["select distinct clubid from clubusers where userid = ?", session[:userid]])
    club = params[:club]
    if !club.nil?
      @userarray2 = Clubusers.where(userid:session[:userid], clubid:club)
      @club = club
    end
  end

  def chooseroleProcess
    session[:role]=params[:role]
    session[:club]=params[:club]
    redirect_to :action => 'home'
  end
  
  def selectClub
    clubid = params[:selected_club_id]
    session[:club] = clubid
    @userarray2 = Clubusers.where(userid:session[:userid], clubid:clubid)
      roles = []
      @userarray2.each { |clubuser|
        roles << clubuser.role
      }
      session[:role] = roles.join(',')
    redirect_to :action => 'home'
  end

  def logout
    session[:userid] = nil
    session[:role] = nil
    session[:club] = nil
    redirect_to :action => 'login', :layout => false
  end

  def home
  end

  def newrequest
  end

  def viewrequests
  end
  
  def registerclub
    @newclub = Club.new
    @users=User.where.not(userid: session[:userid])
    @cbds = Club.where(clubtype: 'cbd')
    @clubs = Club.all
  end
  
  def addclub
    Club.create(club_params)
    ExpenditureAccount.create(:clubid => params[:club][:clubid])
    if params[:club][:clubtype] != 'smusa'
      ReserveAccount.create(:clubid => params[:club][:clubid], :limit => 20000, :balance => 0)
    end
    redirect_to :back
  end
  
  def club_params
    params.require(:club).permit!
  end
  
  def deleteclub
    clubid = params[:clubid]
    Claim.delete_all(clubid: clubid)
    Clubusers.delete_all(clubid: clubid)
    Request.delete_all(clubid: clubid)
    ReserveAccount.delete_all(clubid: clubid)
    ExpenditureAccount.delete_all(clubid: clubid)
    c = Club.find_by_clubid(clubid)
   
    c.delete
    
    # e = ExpenditureAccount.find_by_clubid(clubid)
    # r = ReserveAccount.find_by_clubid(clubid)
    # if !e.nil?
      # e.delete
    # end
    # if !r.nil?
      # r.delete
    # end
    redirect_to :back
  end
  
  def setnric
    @user = current_user
  end
  def setnric2
    current_user.update(user_params)
    redirect_to :back
  end
  def user_params
    params.require(:user).permit!
  end
end
