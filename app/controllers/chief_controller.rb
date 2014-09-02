class ChiefController < ApplicationController
  def changereserveslimit
  end

  def transferfunds
  end

  def modifyuserrole
  end

  def manageclub
  end

  def pullback
    control = BudgetControl.find_by_id(2)
    year = control.year
    semester = control.semester
    clubs = Club.where("clubtype NOT IN ('smusa','infinity')")
    @arr = []
    clubs.each do |c|
      clubid = c.clubid
      expenses = Transaction.where(year: year, semester: semester, clubid: clubid, typeoftransaction: ['claim','transferout'])
      expensesamount = expenses.sum(:amount)
      
      revenues = Transaction.where(year: year, semester: semester, clubid: clubid, typeoftransaction: ['deposit','transfer'])
      revenuesamount = revenues.sum(:amount)
      
      budget = Budget.where(year: year, semester: semester, clubid: clubid)
      allocatedbudget = 0.0
      allocatefromreserves = 0.0
      budget.each do |b|
        allocatedbudget += b.requestsac
        allocatedbudget += b.requestreserves
        allocatefromreserves += b.requestreserves
      end
      
      
      proportion = allocatefromreserves/allocatedbudget
      
      accountbalance = ExpenditureAccount.find_by_clubid(clubid).Category1Balance
      
      if expensesamount >= allocatedbudget
        surplus = allocatedbudget - expensesamount + revenuesamount
      elsif expensesamount < allocatedbudget
        surplus = revenuesamount
        if proportion != 0
          unspentbudget = allocatedbudget - expensesamount
          unspentreserves = proportion*unspentbudget
          surplus += unspentreserves
        end
      end
      
      returnsac = accountbalance - surplus
      
      reserveaccount = ReserveAccount.find_by_clubid(clubid)
      reservelimitdifference = reserveaccount.limit - reserveaccount.balance
      
      if reservelimitdifference < surplus
        x = surplus - reservelimitdifference
        surplus -= x
        returnsac += x
      end
      
      @arr << {'clubname' => c.clubname, 'clubcode' => c.clubcode,'expenses' => expenses, 'expensesamount' => expensesamount, 'revenues' => revenues, 'revenuesamount' => revenuesamount, 'allocatedbudget' => allocatedbudget, 'allocatefromreserves' => allocatefromreserves, 'surplus' => surplus, 'returnsac' => returnsac}
    end
  end

  def changeformula
  end

  def allocate
  end

  def injectfunds
  end
end
