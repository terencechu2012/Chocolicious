class AdminController < ApplicationController
  def register
    @userList=Clubusers.where(clubid:session[:club])
    # @users=User.where.not(userid: session[:userid])
    @users=User.all
    @allexceptme = User.where.not(userid: session[:userid])
    @allClubs = Club.where("clubtype != 'cbd' and clubtype <> 'smusa' and clubtype != 'infinity'")
    @clubsUnderCbd = Club.where(clubtype: session[:club])
    @cbds = Club.where(clubtype: 'cbd')
    @clubRequests = Request.where(clubid:session[:club])
    @cbdList = Clubusers.where(role:'cbdfinsec')
    @clubFinSecList = Clubusers.where(['clubid in (select clubid from clubs where clubtype = ?) AND role = ?', session[:club], 'clubfinsec'])
    @clubs = Request.joins("INNER JOIN clubs on clubs.clubid = requests.clubid").where(:userid => session[:userid])
    @clublist = Clubusers.where(:userid => session[:userid])
    @cbdmcList = Clubusers.where(clubid:session[:club])
    @smusasecList = Clubusers.where(role: 'smusasec')
    list2 = Clubusers.where(clubid: 'smusa', role: 'president')
    @smusasecList = @smusasecList + list2
    @departments = Club.where(clubtype: 'smusa')
    @oslList = Clubusers.where(role: 'osl')
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
    if (user.nil? || user == "")&& user.confirmation_token.nil?
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
      session[:role] = ''
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
    role = session[:role]
    if role.include? 'clubfinsec'
      @normalclaims = Claim.where(:clubid => session[:club], :status => 1)
      @normaldeposits = Deposit.where(:clubid => session[:club], :status => 1)
      @normalpayments = Payment.where(:clubid => session[:club], :status => [1..5, 17..19])
    elsif role.include? 'cbdfinsec'
      @normalclaims = Claim.where(['clubid in (select clubid from clubs where clubtype = ?) and status = 3', session[:club]])
      @cbdmcclaims = Claim.where(clubid:session[:club], status: 7)
      @normaldeposits = Deposit.where(['clubid in (select clubid from clubs where clubtype = ?) and status = 3', session[:club]])
      @cbdmcdeposits = Deposit.where(clubid:session[:club], status: 7)
      @normalpayments = Payment.where(['clubid in (select clubid from clubs where clubtype = ?) and ((status > 2 and status < 6) or (status>16 and status<20))', session[:club]])
      @cbdmcpayments = Payment.where(clubid:session[:club], status: [7..11, 20..22])
    elsif role.include? 'president'
      @normalclaims = Claim.where(clubid:session[:club], status: 2)
      @cbdmcclaims = Claim.where(clubid:session[:club], status: 8)
      @claims = @normalclaims + @cbdmcclaims
      @normalpayments = Payment.where(clubid:session[:club], status: [2..5, 17..19])
      @cbdmcpayments = Payment.where(clubid:session[:club], status: [8..11, 20..22])
      @payments = @normalpayments + @cbdmcpayments
      if session[:club] == 'smusa'
        @thirdclaims = Claim.where(['clubid in (select clubid from clubs where clubtype = ?) and status = 13', 'smusa'])
        @claims = @normalclaims + @cbdmcclaims + @thirdclaims
        @thirdpayments = Payment.where(['clubid in (select clubid from clubs where clubtype = ?) and ((status > 12 and status < 17) or (status > 22 and status < 26))', 'smusa'])
        @payments = @normalpayments + @cbdmcpayments + @thirdpayments
      end
      @normaldeposits = Deposit.where(clubid:session[:club], status: 2)
      @cbdmcdeposits = Deposit.where(clubid:session[:club], status: 8)
      @thirddeposits = Deposit.where(['clubid in (select clubid from clubs where clubtype = ?) and status = 13', 'smusa'])
      @deposits = @normaldeposits + @cbdmcdeposits + @thirddeposits
    elsif role.include? 'smusafinsec'
      @cbdmcclaims = Claim.where(status: 9)
      @smusasecclaims = Claim.where(status: 14)
      @cbdmcdeposits = Deposit.where(status: 9)
      @smusasecdeposits = Deposit.where(status: 14)
      @cbdmcpayments = Payment.where(status: [9..11, 20..22])
      @smusasecpayments = Payment.where(status: [14..16, 23..25])
    elsif role.include? 'osl'
      @oslpayments = Payment.where(status: [17..25])
      @oslclaims = Claim.where(status: [17..25])
    end
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
    begin
      Club.create(club_params)
      ExpenditureAccount.create(:clubid => params[:club][:clubid])
      if params[:club][:clubtype] != 'smusa'
        ReserveAccount.create(:clubid => params[:club][:clubid], :limit => 20000, :balance => 0)
      end

    rescue
      flash.alert = "Duplicate entry found!"
    end

    redirect_to :back
  end

  def club_params
    params.require(:club).permit!
  end

  def deleteclub
    clubid = params[:clubid]
    # Claim.delete_all(clubid: clubid)
    # Deposit.delete_all(clubid: clubid)
    # Clubusers.delete_all(clubid: clubid)
    # Request.delete_all(clubid: clubid)
    # ReserveAccount.delete_all(clubid: clubid)
    # ExpenditureAccount.delete_all(clubid: clubid)

    budgets = Budget.where(clubid: clubid)
    budgets.each do |b|
      expenses = BudgetExpense.where(budget_id: b.id)
      incomes = BudgetIncome.where(budget_id: b.id)
      expenses.each do |e|
        newrow = ArchiveBudgetExpense.create(e.attributes)

        e.delete
      end
      incomes.each do |i|
        newrow = ArchiveBudgetIncome.create(i.attributes)

        i.delete
      end
      newrow = ArchiveBudget.create(b.attributes)

      b.delete
    end
    claims = Claim.where(clubid: clubid)
    claims.each do |cl|
      ArchiveClaim.create(cl.attributes)
      cl.delete
    end
    deposits = Deposit.where(clubid: clubid)
    deposits.each do |cl|
      ArchiveDeposit.create(cl.attributes)
      cl.delete
    end
    clubusers = Clubusers.where(clubid: clubid)
    clubusers.each do |x|
      ArchiveClubuser.create(x.attributes)
      x.delete
    end
    requests = Request.where(clubid: clubid)
    requests.each do |x|
      ArchiveRequest.create(x.attributes)
      x.delete
    end
    reserves = ReserveAccount.where(clubid: clubid)
    reserves.each do |x|
      ArchiveReserveAccount.create(x.attributes)
      x.delete
    end
    expenses = ExpenditureAccount.where(clubid: clubid)
    expenses.each do |x|
      ArchiveExpenditureAccount.create(x.attributes)
      x.delete
    end
    c = Club.find_by_clubid(clubid)
    ArchiveClub.create(c.attributes)
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
    flash.notice = 'Details have been updated.'
    if session[:club].nil?
      redirect_to :action => 'register'
    else
      redirect_to :action => 'home'
    end
    
  end

  def user_params
    params.require(:user).permit!
  end
  
  def changeclubname
    clubid = params[:clubid]
    @club = Club.find_by_clubid(clubid)
  end
  
  def changename
    c = Club.find_by_clubid(params[:club][:clubid])
    c.update_attributes(club_params)
    redirect_to :action => 'registerclub'
  end
end
