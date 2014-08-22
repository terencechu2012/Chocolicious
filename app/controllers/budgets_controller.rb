class BudgetsController < ApplicationController
  def index
    @control = BudgetControl.find_by_id(1)
   
    @past = Budget.find_by_sql("select distinct year, semester from budgets where clubid ='"+session[:club]+"'")
  end
  def main
    c = BudgetControl.find_by_id(1)
    @check = c.open
    year = c.year
    semester = c.semester
    @budgets = Budget.where(:clubid => session[:club], :year => year, :semester => semester)
    
  end
  
  def reviewmain
    if !params[:clubid].nil?
      session[:tempclub] = params[:clubid]
      session[:tempyear] = params[:year]
      session[:tempsem] = params[:semester]
    
      
    end
    @budgets = Budget.where(:clubid => session[:tempclub], :year => session[:tempyear], :semester => session[:tempsem])
  end
  def control
    @control = BudgetControl.find_by_id(1)
    @control2 = BudgetControl.find_by_id(2)
  end
  def allow
    c = BudgetControl.find_by_id(1)
    c.update_attributes(:open => true, :year => params[:year], :semester => params[:semester])
    redirect_to :back
  end
  
  def allowspending
    c = BudgetControl.find_by_id(2)
    c.update_attributes(:year => params[:year], :semester => params[:semester])
    redirect_to :back
  end
  def disallow
    c = BudgetControl.find_by_id(1)
    c.update_attribute(:open, false)
    redirect_to :back
  end
  
  def additem
    c = BudgetControl.find_by_id(1)
    categoryarray = params[:categories]
    categories = ''
    categoryarray.each do |ca|
      categories = categories + ca.to_s + ','
    end
    categories = categories.chop
    Budget.create(:clubid => session[:club], :year => c.year, :semester => c.semester, :event => params[:event], :startdate => params[:startdate], :enddate => params[:enddate], :estnopar => params[:estnopar], :category => categories, :explanation => params[:explanations], :poster => params[:poster])
    redirect_to :back
  end
  
  def delete
    b = Budget.find_by_id(params[:id])
    b.destroy
    redirect_to :back
  end
  
  def managebreakdown
    c = BudgetControl.find_by_id(1)
    @check = c.open
    id = params[:id]
    @b = Budget.find_by_id(id)
    @expenditures = BudgetExpense.where(:budget_id => id)
    @incomes = BudgetIncome.where(:budget_id => id)
    @id = id
    @newexpenditure = BudgetExpense.new
    @newincome = BudgetIncome.new
  end
  
  def reviewmanagebreakdown
    c = BudgetControl.find_by_id(1)
    
    id = params[:id]
    @b = Budget.find_by_id(id)
    @expenditures = BudgetExpense.where(:budget_id => id)
    @incomes = BudgetIncome.where(:budget_id => id)
    @id = id
    @newexpenditure = BudgetExpense.new
    @newincome = BudgetIncome.new
  end
  
  def addexpenditure
    BudgetExpense.create(budget_expense_params)
    b = Budget.find_by_id(params[:budget_expense][:budget_id])
    requestsac = b.requestsac
    requestreserves = b.requestreserves
    requestsac += params[:budget_expense][:requestsac].to_f
    requestreserves += params[:budget_expense][:requestreserves].to_f
    b.update_attribute(:requestsac, requestsac)
    b.update_attribute(:requestreserves, requestreserves)
    redirect_to :back
  end
  
  def addincome
    BudgetIncome.create(budget_income_params)
    b = Budget.find_by_id(params[:budget_income][:budget_id])
    requestsac = b.requestsac
    requestsac -= params[:budget_income][:income].to_f
    projectedincome = b.projectedincome
    projectedincome += params[:budget_income][:income].to_f
    b.update_attribute(:requestsac, requestsac)
    b.update_attribute(:projectedincome, projectedincome)
    redirect_to :back
  end
  
  def deleteexpenditure
    be = BudgetExpense.find_by_id(params[:id])
    b = Budget.find_by_id(be.budget_id)
    requestsac = b.requestsac
    requestreserves = b.requestreserves
    requestsac -= be.requestsac
    requestreserves -= be.requestreserves
    b.update_attribute(:requestsac, requestsac)
    b.update_attribute(:requestreserves, requestreserves)
    be.delete
    redirect_to :back
  end
  
  def deleteincome
    be = BudgetIncome.find_by_id(params[:id])
    b = Budget.find_by_id(be.budget_id)
    requestsac = b.requestsac
    projectedincome = b.projectedincome
    requestsac += be.income
    projectedincome -= be.income
    b.update_attribute(:requestsac, requestsac)
    b.update_attribute(:projectedincome, projectedincome)
    be.delete
    redirect_to :back
  end
  
  def budget_expense_params
    params.require(:budget_expense).permit!
  end
  def budget_income_params
    params.require(:budget_income).permit!
  end
  
  def show
    year = params[:year]
    semester = params[:semester]
    @budgets = Budget.where(:clubid => session[:club], :year => year, :semester => semester)
  end
  
  def viewbreakdown
    id = params[:id]
    @b = Budget.find_by_id(id)
    @expenditures = BudgetExpense.where(:budget_id => id)
    @incomes = BudgetIncome.where(:budget_id => id)
  end
  
  # def fullsummary
    # @past = Budget.find_by_sql("select distinct year, semester from budgets")
    # year = params[:year]
    # semester = params[:semester]
    # if !year.nil? && !semester.nil?
      # @test = true
      # allbudgets = Budget.where(:year => year, :semester => semester)
      # @totalsac = 0.0
      # @totalreserves = 0.0
      # allbudgets.each do |a|
        # @totalsac += a.requestsac
        # @totalreserves += a.requestreserves
      # end
      # cbds = Club.where(clubtype: 'cbd')
      # @cbdtotal = []
      # cbds.each do |c|
        # cbdbudgets = allbudgets.where("clubid in (select clubid from clubs where clubtype = '"+c.clubid+"')")
        # cbditself = allbudgets.where(clubid: c.clubid)
        # cbdbudgets = cbdbudgets + cbditself
        # subtotalsac = 0.0
        # subtotalreserves = 0.0
        # cbdbudgets.each do |d|
          # subtotalsac += d.requestsac
          # subtotalreserves += d.requestreserves
        # end
#         
        # @cbdtotal << {'name' => c.clubid, 'totalsac' => subtotalsac, 'totalreserves' => subtotalreserves}
#         
      # end
#       
      # @departmenttotal = []
      # departments = Club.where(clubtype: 'smusa')
      # departments.each do |d|
        # departmentbudget = allbudgets.where(clubid: d.clubid)
        # totalsac = 0.0
        # departmentbudget.each do |e|
          # totalsac += e.requestsac
        # end
        # @departmenttotal << {'name' => d.clubid, 'totalsac' => totalsac}
      # end
#       
#       
    # end
#     
  # end
  
  def cbdsummary
    cbd = params[:cbd]
    @cbd = cbd
    @clubtotal = []
    
  end
  
  def fullsummary
    @past = Budget.find_by_sql("select distinct year, semester from budgets")
    year = params[:year]
    semester = params[:semester]
    @year = year
    @semester = semester
    if !year.nil? && !semester.nil?
      @test = true
      allbudgets = Budget.where(:year => year, :semester => semester)
      @totalsac = 0.0
      @totalreserves = 0.0
      allbudgets.each do |a|
        @totalsac += a.requestsac
        @totalreserves += a.requestreserves
      end
      cbds = Club.where(clubtype: 'cbd')
      @cbdtotal = []
      @superhash = Hash.new
      cbds.each do |c|
        
        cbdbudgets = allbudgets.find_by_sql("select clubid, sum(requestsac) as sum1, sum(requestreserves) as sum2 from budgets where year='"+year+"' and semester='"+semester+"'and clubid in (select clubid from clubs where clubtype = '"+c.clubid+"')group by clubid")
        cbditself = allbudgets.find_by_sql("select clubid, sum(requestsac) as sum1, sum(requestreserves) as sum2 from budgets where year='"+year+"' and semester='"+semester+"'and clubid='"+c.clubid+"'group by clubid")
        cbdbudgets = cbdbudgets + cbditself
        subtotalsac = 0.0
        subtotalreserves = 0.0
        smallarray = []
        cbdbudgets.each do |d|
          subtotalsac += d.sum1
          subtotalreserves += d.sum2
          r = ReserveAccount.find_by_clubid(d.clubid)
          smallarray << [d.clubid, d.sum1, d.sum2, r.balance, r.justification]
        end
        if session[:role] == 'cbdfinsec' && session[:club] == c.clubid
          @superhash[c.clubid] = smallarray
        elsif session[:role] == 'smusafinsec'
          @superhash[c.clubid] = smallarray
        end
        
       
        @cbdtotal << {'name' => c.clubid, 'totalsac' => subtotalsac, 'totalreserves' => subtotalreserves}
        
      end
      
      @departmenttotal = []
      departments = Club.where(clubtype: 'smusa')
      departments.each do |d|
        departmentbudget = allbudgets.where(clubid: d.clubid)
        totalsac = 0.0
        departmentbudget.each do |e|
          totalsac += e.requestsac
        end
        @departmenttotal << {'name' => d.clubid, 'totalsac' => totalsac}
      end
      
      
    end
    
  end
end
