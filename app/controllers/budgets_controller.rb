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
    @grouped_expense = {
      'Assets maintenance and repair' => [['Equipment with life-span of > 1 year','1']],
      'Assets purchases (Equipment with life-span of > 1 year)' => [['Assets purchases <= $100','2'],['Assets purchases $100 < X < $500','3'],['Assets purchases > $500','4']],
      'Attire' => [['Attire used for competitive purposes or authorized by the SMUSA Finance Secretary','5']],
      'Coaching Fees' => [['Fees to trainers/coaches','6']],
      'Facilities booking/clubs membership payment to organisation' => [['Rent Fees/Membership Payment','7']],
      'Gifts' => [['Gifts/Prizes/Awards','8']],
      'Publicity' => [['General costs of marketing materials etc','9']],
      'Stationery' => [['Stationery material for club administrative purposes','10']],
      'Food and Beverages' => [['Welfare events such as BBQ, food gathering, FOR MEMBERS OF CLUB ONLY','11']],
      'Transport' => [['Fees for transportation','12']],
      'Miscellaneous' => [['Any misc. expenses that do not fall into the above cateogories','13']]
    }
  end
  
  def reviewmain
    if !params[:clubid].nil?
      session[:tempclub] = params[:clubid]
      session[:tempyear] = params[:year]
      session[:tempsem] = params[:semester]
    
      
    end
    @budgets = Budget.where(:clubid => session[:tempclub], :year => session[:tempyear], :semester => session[:tempsem])
    @grouped_expense = {
      'Assets maintenance and repair' => [['Equipment with life-span of > 1 year','1']],
      'Assets purchases (Equipment with life-span of > 1 year)' => [['Assets purchases <= $100','2'],['Assets purchases $100 < X < $500','3'],['Assets purchases > $500','4']],
      'Attire' => [['Attire used for competitive purposes or authorized by the SMUSA Finance Secretary','5']],
      'Coaching Fees' => [['Fees to trainers/coaches','6']],
      'Facilities booking/clubs membership payment to organisation' => [['Rent Fees/Membership Payment','7']],
      'Gifts' => [['Gifts/Prizes/Awards','8']],
      'Publicity' => [['General costs of marketing materials etc','9']],
      'Stationery' => [['Stationery material for club administrative purposes','10']],
      'Food and Beverages' => [['Welfare events such as BBQ, food gathering, FOR MEMBERS OF CLUB ONLY','11']],
      'Transport' => [['Fees for transportation','12']],
      'Miscellaneous' => [['Any misc. expenses that do not fall into the above cateogories','13']]
    }
 
  end
  def control
    @control = BudgetControl.find_by_id(1)
    @control2 = BudgetControl.find_by_id(2)
    @contribution = Contribution.find_by_id(1)
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
    if !params[:review].nil? && params[:review] == 'true'
      club = session[:tempclub]
    else
      club = session[:club]
    end
    
    Budget.create(:clubid => club, :year => c.year, :semester => c.semester, :event => params[:event], :startdate => params[:startdate], :enddate => params[:enddate], :estnopar => params[:estnopar], :category => categories, :explanation => params[:explanations], :poster => params[:poster])
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
    
    b = Budget.find_by_id(params[:budget_expense][:budget_id])
    requestsac = b.requestsac
    requestreserves = b.requestreserves
    requestsac += params[:budget_expense][:requestsac].to_f
    requestreserves += params[:budget_expense][:requestreserves].to_f
    if !params[:budget_expense][:requestreserves].nil?
      reservebalance = ReserveAccount.find_by_clubid(b.clubid).balance
      if reservebalance < requestreserves
        flash.alert = 'Not enough funds in reserve account'
      else
        BudgetExpense.create(budget_expense_params)
        b.update_attribute(:requestsac, requestsac)
        b.update_attribute(:requestreserves, requestreserves)
      end
    else
        BudgetExpense.create(budget_expense_params)
        b.update_attribute(:requestsac, requestsac)
      
    end
    
    
    redirect_to :back
  end
  
  def addincome
    BudgetIncome.create(budget_income_params)
    b = Budget.find_by_id(params[:budget_income][:budget_id])
    requestsac = b.requestsac
    requestsac -= params[:budget_income][:income].to_f
    if requestsac < 0
      requestsac = 0
    end
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
      @totalcontribute = 0.0
      # allbudgets.each do |a|
        # @totalsac += a.requestsac
        # @totalreserves += a.requestreserves
      # end
      cbds = Club.where(clubtype: 'cbd')
      @cbdtotal = []
      @superhash = Hash.new
      cbds.each do |c|
        
        cbdbudgets = allbudgets.find_by_sql("select clubid, sum(requestsac) as sum1, sum(requestreserves) as sum2 from budgets where year='"+year+"' and semester='"+semester+"'and clubid in (select clubid from clubs where clubtype = '"+c.clubid+"')group by clubid")
        cbditself = allbudgets.find_by_sql("select clubid, sum(requestsac) as sum1, sum(requestreserves) as sum2 from budgets where year='"+year+"' and semester='"+semester+"'and clubid='"+c.clubid+"'group by clubid")
        cbdbudgets = cbdbudgets + cbditself
        subtotalsac = 0.0
        subtotalreserves = 0.0
        subtotalcontribute = 0.0
        smallarray = []
        cbdbudgets.each do |d|
          r = ReserveAccount.find_by_clubid(d.clubid)
          clubid = d.clubid
          sum1 = d.sum1
          sum2 = d.sum2
          balance = r.balance
          newbalance = balance - d.sum2
          contributionrate = Contribution.find_by_id(1).rate
          amounttocontribute = (contributionrate/100*newbalance).round(2)
          if sum1 < amounttocontribute
            amounttocontribute = sum1
          end
          if amounttocontribute <= newbalance && clubid != 'ise' && clubid != 'eurhythmix' && clubid != 'sambam'
            sum1 -= amounttocontribute
            
          else
            amounttocontribute = 0
          end
          
          
          subtotalsac += sum1
          subtotalreserves += sum2
          subtotalcontribute += amounttocontribute
          @totalsac += sum1
          @totalreserves += sum2
          @totalcontribute += amounttocontribute
          smallarray << [d.clubid, sum1, sum2, r.balance, r.justification, amounttocontribute]
        end
       
        if (session[:role].include? 'cbdfinsec') && (session[:club].casecmp(c.clubid)==0)
          @superhash[c.clubid] = smallarray
        elsif session[:role].include? 'smusafinsec'
          @superhash[c.clubid] = smallarray
        end
        
       
        @cbdtotal << {'name' => c.clubid, 'totalsac' => subtotalsac, 'totalreserves' => subtotalreserves, 'totalcontribute' => subtotalcontribute}
        
      end
      
      @departmenttotal = []
      departments = Club.where(clubtype: 'smusa')
      departments.each do |d|
        departmentbudget = allbudgets.where(clubid: d.clubid)
        totalsac = 0.0
        departmentbudget.each do |e|
          totalsac += e.requestsac
        end
        @totalsac += totalsac
        @departmenttotal << {'name' => d.clubid, 'totalsac' => totalsac}
      end
      
      
    end
    
  end
end
