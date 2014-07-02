class AccountsController < ApplicationController
  def viewaccount
    @club=ExpenditureAccount.find_by_clubid(session[:club])
  end

  def viewcbdaccounts
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
    @choiceofCBD=ExpenditureAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', "cbd"])
    if params[:choice] != ""
      @clubArr = ExpenditureAccount.where(['clubid in (select clubid from clubs where clubtype = ?)', params[:choice]])
      @choiceofCBD = ExpenditureAccount.where(clubid:params[:choice])
      @clubArr = @clubArr
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

  def deposit
  end

  def editaccount
    @clubid=params[:id]
    @destination=params[:destination]
    @clubexpAcc=ExpenditureAccount.find_by(:clubid=>params[:id])
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
      @clubBudget = @clubBudget + (x.Category1Balance + x.Category2Balance + x.Category3Balance + x.Category4Balance + x.Category5Balance + x.Category6Balance + x.Category7Balance + x.Category8Balance + x.Category9Balance + x.Category10Balance + x.Category11Balance + x.Category12Balance + x.Category13Balance + x.MiscellaneousBalance)
    end
    return @clubBudget
  end

  def update
    m = ExpenditureAccount.find_by_clubid(params[:id])
    m.update_attribute(:Category1Balance, params[:cat1])
    m.update_attribute(:Category2Balance, params[:cat2])
    m.update_attribute(:Category3Balance, params[:cat3])
    m.update_attribute(:Category4Balance, params[:cat4])
    m.update_attribute(:Category5Balance, params[:cat5])
    m.update_attribute(:Category6Balance, params[:cat6])
    m.update_attribute(:Category7Balance, params[:cat7])
    m.update_attribute(:Category8Balance, params[:cat8])
    m.update_attribute(:Category9Balance, params[:cat9])
    m.update_attribute(:Category10Balance, params[:cat10])
    m.update_attribute(:Category11Balance, params[:cat11])
    m.update_attribute(:Category12Balance, params[:cat12])
    m.update_attribute(:Category13Balance, params[:cat13])
    m.update_attribute(:MiscellaneousBalance, params[:misc])
    redirect_to :action => params[:destination]
  end
end
