class AccountsController < ApplicationController
  def viewaccount
    @club=ExpenditureAccount.find_by_clubid(session[:club])
    @reserve=ReserveAccount.find_by_clubid(session[:club])
  end

  def viewcbdaccounts
    if session[:role].include? 'smusafinsec'
      @CBD = Club.where(clubtype:"cbd")
      @totalBdgt = 0.00
      @budgetArr = []
      @CBD.each do|x|
        cb = findClubs(x.clubid)
        cb2 = findCBD(x.clubid)
        cb = cb + cb2
        budget = calculateAllBudget(cb)
        @totalBdgt+=budget
        @budgetArr << budget
      end
      @clubArr=[]
      # @choiceofCBD=ExpenditureAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', "cbd"])
      # wah whoever wrote the above line made me scratch my head and owe me a meal
      if params[:choice] != ""
        @clubArr = ExpenditureAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', params[:choice]])
        @choiceofCBD = ExpenditureAccount.where(clubid:params[:choice])
        # @clubArr = @clubArr
      else
        @choiceofCBD = []
      end
    end
    if session[:role].include?'cbdfinsec'
      @clubArr = ExpenditureAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', session[:club]])
      @choiceofCBD = ExpenditureAccount.where(clubid:session[:club])
    end
  end
  
  def viewcbdaccountsreserve
    if session[:role].include? 'smusafinsec'
      @CBD = Club.where(clubtype:"cbd")
      @totalBdgt = 0.00
      @budgetArr = []
      @CBD.each do|x|
        budget = 0
        cbd = ReserveAccount.find_by_clubid(x.clubid)
        budget += cbd.balance if !cbd.nil?
        clubsUnder = ReserveAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', x.clubid])
        clubsUnder.each do |cu|
          budget += cu.balance
        end
        @totalBdgt+=budget
        @budgetArr << budget
      end
      @clubArr=[]
      # @choiceofCBD=ReserveAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', "cbd"])
      # this bloody line again
      if params[:choice] != ""
        @clubArr = ReserveAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', params[:choice]])
        @choiceofCBD = ReserveAccount.where(clubid:params[:choice])
        # @clubArr = @clubArr
      else
        @choiceofCBD = []
      end
    end
    if session[:role].include?'cbdfinsec'
      @clubArr = ReserveAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', session[:club]])
      @choiceofCBD = ReserveAccount.where(clubid:session[:club])
    end
  end
  

  def viewallaccounts
    @CBD = Club.where(clubtype:"cbd")
    @totalBdgt = 0.00
    @budgetArr = []
    @CBD.each do|x|
      cb = findCBD(x.clubid)
      budget = calculateAllBudget(cb)
      @totalBdgt+=budget
      @budgetArr << budget
    end
    @clubArr=[]
    if params[:choice] != nil
      @clubArr = ExpenditureAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', params[:choice]])
    end
  end
  
  def viewsecaccount
    @clubArr = ExpenditureAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', 'smusa'])
  end

  def deposit
  end

  def editaccount
    @clubid=params[:id]
    @destination=params[:destination]
    @clubexpAcc=ExpenditureAccount.find_by(:clubid=>params[:id])
  end
  
  def editaccountreserve
    @club = ReserveAccount.find_by_clubid(params[:id])
    
  end

  def fundstransfer
  end

  def findCBD(cid)
    @clubs=[]
    @clubs=ExpenditureAccount.where(clubid:cid)
    return @clubs
  end

  def findClubs(cid)
    @clubs=[]
    @clubs=ExpenditureAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', cid])
    return @clubs
  end

  def calculateAllBudget(clubArr)
    @clubBudget = 0.00
    clubArr.each do|x|
      @clubBudget = @clubBudget + (x.Category1Balance)
    end
    return @clubBudget
  end

  def update
    m = ExpenditureAccount.find_by_clubid(params[:id])
    m.update_attribute(:Category1Balance, params[:cat1])
    m.update_attribute(:Category2Balance, params[:cat2])
    # m.update_attribute(:Category3Balance, params[:cat3])
    # m.update_attribute(:Category4Balance, params[:cat4])
    # m.update_attribute(:Category5Balance, params[:cat5])
    # m.update_attribute(:Category6Balance, params[:cat6])
    # m.update_attribute(:Category7Balance, params[:cat7])
    # m.update_attribute(:Category8Balance, params[:cat8])
    # m.update_attribute(:Category9Balance, params[:cat9])
    # m.update_attribute(:Category10Balance, params[:cat10])
    # m.update_attribute(:Category11Balance, params[:cat11])
    # m.update_attribute(:Category12Balance, params[:cat12])
    # m.update_attribute(:Category13Balance, params[:cat13])
    # m.update_attribute(:MiscellaneousBalance, params[:misc])
    redirect_to :action => params[:destination]
  end
  def updatereserve
    r = ReserveAccount.find_by_clubid(params[:reserve_account][:clubid])
    r.update_attributes(reserve_params)
    redirect_to :action => 'viewcbdaccountsreserve'
  end
  
  def editjustification
    r = ReserveAccount.find_by_clubid(params[:reserve_account][:clubid])
    r.update_attributes(reserve_params)
    redirect_to :action => 'viewaccount'
  end
  
  
  #to throw away
  def forconvenience
    @new = ReserveAccount.new
    @cbds = Club.all
  end
  def add
    ReserveAccount.create(reserve_params)
    redirect_to :action => 'forconvenience'
  end
  def reserve_params
    params.require(:reserve_account).permit!
  end
  
  def sacaccount
    @sac = ExpenditureAccount.find_by_id(121)
    acfclubs = ReserveAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', 'ACF'])
    acf = ReserveAccount.find_by_clubid('ACF')
    @acfreserves = acf.balance
    acfclubs.each do |a|
      @acfreserves += a.balance
    end
    sicsclubs = ReserveAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', 'SICS'])
    sics = ReserveAccount.find_by_clubid('SICS')
    @sicsreserves = sics.balance
    sicsclubs.each do |a|
      @sicsreserves += a.balance
    end
    
    smuxclubs = ReserveAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', 'SMUX'])
    smux = ReserveAccount.find_by_clubid('SMUX')
    @smuxreserves = smux.balance
    smuxclubs.each do |a|
      @smuxreserves += a.balance
    end
    
    
    ssuclubs = ReserveAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', 'SSU'])
    ssu = ReserveAccount.find_by_clubid('SSU')
    @ssureserves = ssu.balance
    ssuclubs.each do |a|
      @ssureserves += a.balance
    end
    
    @schoolreserves = 0.0
    schools = []
    iconclubs = ReserveAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', 'ICON'])
    iconclubs.each do |ic|
      @schoolreserves += ic.balance
    end
    schools << ReserveAccount.find_by_clubid('ASOC')
    schools << ReserveAccount.find_by_clubid('BONDUE')
    schools << ReserveAccount.find_by_clubid('OIKOS')
    schools << ReserveAccount.find_by_clubid('THE BAR')
    schools << ReserveAccount.find_by_clubid('SISS')
    schools << ReserveAccount.find_by_clubid('SOSCIETY')
    schools << ReserveAccount.find_by_clubid('ICON')
    schools.each do |s|
      if !s.nil?
        @schoolreserves += s.balance
      end
    end
    
  end
  
  def inject
    amount = params[:amount].to_d
    a = ExpenditureAccount.find_by_id(121)
    balance = a.Category1Balance
    balance += amount
    a.update_attribute(:Category1Balance, balance)
    redirect_to :back
  end
  
end
