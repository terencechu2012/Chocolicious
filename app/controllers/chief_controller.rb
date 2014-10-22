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
    bigarray = []
    bigarray<<['Transfer from', 'Transfer to', 'Amount']
    year = control.year
    semester = control.semester
    # clubs = Club.where("clubtype NOT IN ('smusa','infinity')")
    
    
    returnr1 = 0.0
    returnr2 = 0.0
    returnr3 = 0.0
    returnr4 = 0.0
    returnr5 = 0.0
    returnr6 = 0.0
    acf = ExpenditureAccount.find_by_clubid("ACF")
    balance1 = acf.Category1Balance
    balance2 = acf.Category2Balance
    racf = ReserveAccount.find_by_clubid("ACF")
    if balance1 > balance2
      returnr1 = returnr1 + balance1 - balance2
      returnr2 += balance2
      racf.update_attribute(:balance, racf.balance + balance2)
      bigarray<<[Club.find_by_clubid('ACF').clubcode, 'R001', '$'+(balance1-balance2).to_s]
      bigarray<<[Club.find_by_clubid('ACF').clubcode, 'R002', '$'+(balance2).to_s]
    else
      returnr2 += balance1
      racf.update_attribute(:balance, racf.balance + balance1)
      bigarray<<[Club.find_by_clubid('ACF').clubcode, 'R002', '$'+(balance1).to_s]
    end
    
    acf.update_attribute(:Category1Balance, 0)
    acf.update_attribute(:Category2Balance, 0)
    
    acfclubs = ExpenditureAccount.where(["clubid in (SELECT clubid from clubs where clubtype = ?)", "ACF"])
    acfclubs.each do |a|
      balance1 = a.Category1Balance
      balance2 = a.Category2Balance
      
      ra = ReserveAccount.find_by_clubid(a.clubid)
      
      if balance1 > balance2
        returnr1 = returnr1 + balance1 - balance2
        returnr2 += balance2
        ra.update_attribute(:balance, ra.balance + balance2)
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R001', '$'+(balance1-balance2).to_s]
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R002', '$'+(balance2).to_s]
        
      else
        returnr2 += balance1
        ra.update_attribute(:balance, ra.balance + balance1)
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R002', '$'+(balance1).to_s]
      end
      a.update_attribute(:Category1Balance, 0)
      a.update_attribute(:Category2Balance, 0)
    end
    
    acf = ExpenditureAccount.find_by_clubid("SICS")
    balance1 = acf.Category1Balance
    balance2 = acf.Category2Balance
    racf = ReserveAccount.find_by_clubid("SICS")
    if balance1 > balance2
      returnr1 = returnr1 + balance1 - balance2
      returnr3 += balance2
      racf.update_attribute(:balance, racf.balance + balance2)
      bigarray<<[Club.find_by_clubid('SICS').clubcode, 'R001', '$'+(balance1-balance2).to_s]
      bigarray<<[Club.find_by_clubid('SICS').clubcode, 'R003', '$'+(balance2).to_s]

    else
      returnr3 += balance1
      racf.update_attribute(:balance, racf.balance + balance1)
      bigarray<<[Club.find_by_clubid('SICS').clubcode, 'R003', '$'+(balance1).to_s]
    end
    
    acf.update_attribute(:Category1Balance, 0)
    acf.update_attribute(:Category2Balance, 0)
    
    acfclubs = ExpenditureAccount.where(["clubid in (SELECT clubid from clubs where clubtype = ?)", "SICS"])
    acfclubs.each do |a|
      balance1 = a.Category1Balance
      balance2 = a.Category2Balance
      
      ra = ReserveAccount.find_by_clubid(a.clubid)
      
      if balance1 > balance2
        returnr1 = returnr1 + balance1 - balance2
        returnr3 += balance2
        ra.update_attribute(:balance, ra.balance + balance2)
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R001', '$'+(balance1-balance2).to_s]
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R003', '$'+(balance2).to_s]

      else
        returnr3 += balance1
        ra.update_attribute(:balance, ra.balance + balance1)
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R003', '$'+(balance1).to_s]
      end
      a.update_attribute(:Category1Balance, 0)
      a.update_attribute(:Category2Balance, 0)
    end
    
    acf = ExpenditureAccount.find_by_clubid("SMUX")
    balance1 = acf.Category1Balance
    balance2 = acf.Category2Balance
    racf = ReserveAccount.find_by_clubid("SMUX")
    if balance1 > balance2
      returnr1 = returnr1 + balance1 - balance2
      returnr4 += balance2
      racf.update_attribute(:balance, racf.balance + balance2)
      bigarray<<[Club.find_by_clubid('SMUX').clubcode, 'R001', '$'+(balance1-balance2).to_s]
      bigarray<<[Club.find_by_clubid('SMUX').clubcode, 'R004', '$'+(balance2).to_s]
    else
      returnr4 += balance1
      racf.update_attribute(:balance, racf.balance + balance1)
      bigarray<<[Club.find_by_clubid('SMUX').clubcode, 'R004', '$'+(balance1).to_s]
    end
    
    acf.update_attribute(:Category1Balance, 0)
    acf.update_attribute(:Category2Balance, 0)
    
    acfclubs = ExpenditureAccount.where(["clubid in (SELECT clubid from clubs where clubtype = ?)", "SMUX"])
    acfclubs.each do |a|
      balance1 = a.Category1Balance
      balance2 = a.Category2Balance
      
      ra = ReserveAccount.find_by_clubid(a.clubid)
      
      if balance1 > balance2
        returnr1 = returnr1 + balance1 - balance2
        returnr4 += balance2
        ra.update_attribute(:balance, ra.balance + balance2)
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R001', '$'+(balance1-balance2).to_s]
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R004', '$'+(balance2).to_s]
      else
        returnr4 += balance1
        ra.update_attribute(:balance, ra.balance + balance1)
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R004', '$'+(balance1).to_s]
      end
      a.update_attribute(:Category1Balance, 0)
      a.update_attribute(:Category2Balance, 0)
    end
    
    acf = ExpenditureAccount.find_by_clubid("SSU")
    balance1 = acf.Category1Balance
    balance2 = acf.Category2Balance
    racf = ReserveAccount.find_by_clubid("SSU")
    if balance1 > balance2
      returnr1 = returnr1 + balance1 - balance2
      returnr5 += balance2
      racf.update_attribute(:balance, racf.balance + balance2)
      bigarray<<[Club.find_by_clubid('SSU').clubcode, 'R001', '$'+(balance1-balance2).to_s]
      bigarray<<[Club.find_by_clubid('SSU').clubcode, 'R005', '$'+(balance2).to_s]
    else
      returnr5 += balance1
      racf.update_attribute(:balance, racf.balance + balance1)
    end
    
    acf.update_attribute(:Category1Balance, 0)
    acf.update_attribute(:Category2Balance, 0)
    
    acfclubs = ExpenditureAccount.where(["clubid in (SELECT clubid from clubs where clubtype = ?)", "SSU"])
    acfclubs.each do |a|
      balance1 = a.Category1Balance
      balance2 = a.Category2Balance
      
      ra = ReserveAccount.find_by_clubid(a.clubid)
      
      if balance1 > balance2
        returnr1 = returnr1 + balance1 - balance2
        returnr5 += balance2
        ra.update_attribute(:balance, ra.balance + balance2)
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R001', '$'+(balance1-balance2).to_s]
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R005', '$'+(balance2).to_s]
      else
        returnr5 += balance1
        ra.update_attribute(:balance, ra.balance + balance1)
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R005', '$'+(balance1).to_s]
      end
      a.update_attribute(:Category1Balance, 0)
      a.update_attribute(:Category2Balance, 0)
    end
    
    acf = ExpenditureAccount.find_by_clubid("ICON")
    balance1 = acf.Category1Balance
    balance2 = acf.Category2Balance
    racf = ReserveAccount.find_by_clubid("ICON")
    if balance1 > balance2
      returnr1 = returnr1 + balance1 - balance2
      returnr6 += balance2
      racf.update_attribute(:balance, racf.balance + balance2)
      bigarray<<[Club.find_by_clubid('ICON').clubcode, 'R001', '$'+(balance1-balance2).to_s]
      bigarray<<[Club.find_by_clubid('ICON').clubcode, 'R006', '$'+(balance2).to_s]
    else
      returnr6 += balance1
      racf.update_attribute(:balance, racf.balance + balance1)
      bigarray<<[Club.find_by_clubid('ICON').clubcode, 'R006', '$'+(balance1).to_s]
    end
    
    acf.update_attribute(:Category1Balance, 0)
    acf.update_attribute(:Category2Balance, 0)
    
    acfclubs = ExpenditureAccount.where(["clubid in (SELECT clubid from clubs where clubtype = ?)", "ICON"])
    acfclubs.each do |a|
      balance1 = a.Category1Balance
      balance2 = a.Category2Balance
      
      ra = ReserveAccount.find_by_clubid(a.clubid)
      
      if balance1 > balance2
        returnr1 = returnr1 + balance1 - balance2
        returnr6 += balance2
        ra.update_attribute(:balance, ra.balance + balance2)
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R001', '$'+(balance1-balance2).to_s]
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R006', '$'+(balance2).to_s]
      else
        returnr6 += balance1
        ra.update_attribute(:balance, ra.balance + balance1)
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R006', '$'+(balance1).to_s]
      end
      a.update_attribute(:Category1Balance, 0)
      a.update_attribute(:Category2Balance, 0)
    end
    
    
    
    
    #old code starts here
    
    
    
    
    
    
    # acf = ExpenditureAccount.find_by_clubid("SICS")
    # returnr1 += acf.Category1Balance
    # returnr3 += acf.Category2Balance
    # racf = ReserveAccount.find_by_clubid("SICS")
    # racf.update_attribute(:balance, racf.balance + acf.Category2Balance)
    # acf.update_attribute(:Category1Balance, 0)
    # acf.update_attribute(:Category2Balance, 0)
    # acfclubs = ExpenditureAccount.where(["clubid in (SELECT clubid from clubs where clubtype = ?)", "SICS"])
    # acfclubs.each do |a|
      # returnr1 += a.Category1Balance
      # returnr3 += acf.Category2Balance
      # ra = ReserveAccount.find_by_clubid(a.clubid)
      # ra.update_attribute(:balance, ra.balance + a.Category2Balance)
      # a.update_attribute(:Category1Balance, 0)
      # a.update_attribute(:Category2Balance, 0)
    # end
#     
#     
    # acf = ExpenditureAccount.find_by_clubid("SMUX")
    # returnr1 += acf.Category1Balance
    # returnr4 += acf.Category2Balance
    # racf = ReserveAccount.find_by_clubid("SMUX")
    # racf.update_attribute(:balance, racf.balance + acf.Category2Balance)
    # acf.update_attribute(:Category1Balance, 0)
    # acf.update_attribute(:Category2Balance, 0)
    # acfclubs = ExpenditureAccount.where(["clubid in (SELECT clubid from clubs where clubtype = ?)", "SMUX"])
    # acfclubs.each do |a|
      # returnr1 += a.Category1Balance
      # returnr4 += acf.Category2Balance
      # ra = ReserveAccount.find_by_clubid(a.clubid)
      # ra.update_attribute(:balance, ra.balance + a.Category2Balance)
      # a.update_attribute(:Category1Balance, 0)
      # a.update_attribute(:Category2Balance, 0)
    # end
#     
    # acf = ExpenditureAccount.find_by_clubid("SSU")
    # returnr1 += acf.Category1Balance
    # returnr5 += acf.Category2Balance
    # racf = ReserveAccount.find_by_clubid("SSU")
    # racf.update_attribute(:balance, racf.balance + acf.Category2Balance)
    # acf.update_attribute(:Category1Balance, 0)
    # acf.update_attribute(:Category2Balance, 0)
    # acfclubs = ExpenditureAccount.where(["clubid in (SELECT clubid from clubs where clubtype = ?)", "SSU"])
    # acfclubs.each do |a|
      # returnr1 += a.Category1Balance
      # returnr5 += acf.Category2Balance
      # ra = ReserveAccount.find_by_clubid(a.clubid)
      # ra.update_attribute(:balance, ra.balance + a.Category2Balance)
      # a.update_attribute(:Category1Balance, 0)
      # a.update_attribute(:Category2Balance, 0)
    # end
#     
    # acf = ExpenditureAccount.find_by_clubid("ICON")
    # returnr1 += acf.Category1Balance
    # returnr6 += acf.Category2Balance
    # racf = ReserveAccount.find_by_clubid("ICON")
    # racf.update_attribute(:balance, racf.balance + acf.Category2Balance)
    # acf.update_attribute(:Category1Balance, 0)
    # acf.update_attribute(:Category2Balance, 0)
    # acfclubs = ExpenditureAccount.where(["clubid in (SELECT clubid from clubs where clubtype = ?)", "ICON"])
    # acfclubs.each do |a|
      # returnr1 += a.Category1Balance
      # returnr6 += acf.Category2Balance
      # ra = ReserveAccount.find_by_clubid(a.clubid)
      # ra.update_attribute(:balance, ra.balance + a.Category2Balance)
      # a.update_attribute(:Category1Balance, 0)
      # a.update_attribute(:Category2Balance, 0)
    # end
    
    acfclubs = ExpenditureAccount.where("clubid in ('ASOC','BONDUE','OIKOS','THE BAR','SISS','SOSCIETY')")
    acfclubs.each do |a|
      balance1 = a.Category1Balance
      balance2 = a.Category2Balance
      
      ra = ReserveAccount.find_by_clubid(a.clubid)
      
      if balance1 > balance2
        returnr1 = returnr1 + balance1 - balance2
        returnr6 += balance2
        ra.update_attribute(:balance, ra.balance + balance2)
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R001', '$'+(balance1-balance2).to_s]
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R006', '$'+(balance2).to_s]
      else
        returnr6 += balance1
        ra.update_attribute(:balance, ra.balance + balance1)
        bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R006', '$'+(balance1).to_s]
      end
      a.update_attribute(:Category1Balance, 0)
      a.update_attribute(:Category2Balance, 0)
    end
    
    acfclubs = ExpenditureAccount.where(["clubid in (SELECT clubid from clubs where clubtype = ?)", "smusa"])
    acfclubs.each do |a|
      returnr1 += a.Category1Balance
      bigarray<<[Club.find_by_clubid(a.clubid).clubcode, 'R001', '$'+(a.Category1Balance).to_s]
      
      
      a.update_attribute(:Category1Balance, 0)
      a.update_attribute(:Category2Balance, 0)
    end
    smusaacc = ExpenditureAccount.find_by_clubid('smusa')
    smusaacc.update_attribute(:Category1Balance, smusaacc.Category1Balance + returnr1)
    Prawn::Document.generate("public/allocate.pdf") do
      # header
      bounding_box [bounds.left - 40, bounds.top + 40], :width  => bounds.width + 80 do
        cell :background_color => 'EEEEEE',
             :width => bounds.width,
             :height => 100,
             :align => :center,
             :text_color => "EEEEEE",
             :borders => [:bottom],
             :border_width => 2,
             :border_color => "rgb(1, 99, 172)",
             :padding => 12
        move_down 20
        image "#{Rails.root}/app/assets/images/smusa-new-logo.png", :at => [35, cursor], :width => 150
      end
      move_down 90
      text 'Pullback done on '+Date.today.to_s
      move_down 20
      text 'Total to:'
      text 'R001: '+returnr1.to_s
      text 'R002: '+returnr2.to_s
      text 'R003: '+returnr3.to_s
      text 'R004: '+returnr4.to_s
      text 'R005: '+returnr5.to_s
      text 'R006: '+returnr6.to_s
      move_down 20
      #Body
      #Applicant Data
      data = bigarray
      table(data, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 8, :size=>10, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
      move_down 20
    end
    file = File.open('public/allocate.pdf')
    ar = AllocationReport.new(report: file, reporttype: "Pullback")
    ar.save
    # @report = [returnr1, returnr2, returnr3, returnr4, returnr5, returnr6]
    flash.notice = 'Pullback of funds completed'
    redirect_to :action => 'allocationreports'
    # @arr = []
    # clubs.each do |c|
      # clubid = c.clubid
      # expenses = Transaction.where(year: year, semester: semester, clubid: clubid, typeoftransaction: ['claim','transferout'])
      # expensesamount = expenses.sum(:amount)
#       
      # revenues = Transaction.where(year: year, semester: semester, clubid: clubid, typeoftransaction: ['deposit','transfer'])
      # revenuesamount = revenues.sum(:amount)
#       
      # budget = Budget.where(year: year, semester: semester, clubid: clubid)
      # allocatedbudget = 0.0
      # allocatefromreserves = 0.0
      # budget.each do |b|
        # allocatedbudget += b.requestsac
        # allocatedbudget += b.requestreserves
        # allocatefromreserves += b.requestreserves
      # end
#       
#       
      # proportion = allocatefromreserves/allocatedbudget
#       
      # accountbalance = ExpenditureAccount.find_by_clubid(clubid).Category1Balance
#       
      # if expensesamount >= allocatedbudget
        # surplus = allocatedbudget - expensesamount + revenuesamount
      # elsif expensesamount < allocatedbudget
        # surplus = revenuesamount
        # if proportion != 0
          # unspentbudget = allocatedbudget - expensesamount
          # unspentreserves = proportion*unspentbudget
          # surplus += unspentreserves
        # end
      # end
#       
      # returnsac = accountbalance - surplus
#       
      # reserveaccount = ReserveAccount.find_by_clubid(clubid)
      # reservelimitdifference = reserveaccount.limit - reserveaccount.balance
#       
      # if reservelimitdifference < surplus
        # x = surplus - reservelimitdifference
        # surplus -= x
        # returnsac += x
      # end
#       
      # @arr << {'clubname' => c.clubname, 'clubcode' => c.clubcode,'expenses' => expenses, 'expensesamount' => expensesamount, 'revenues' => revenues, 'revenuesamount' => revenuesamount, 'allocatedbudget' => allocatedbudget, 'allocatefromreserves' => allocatefromreserves, 'surplus' => surplus, 'returnsac' => returnsac}
    # end
  end

  def changeformula
  end

  def allocate
    bigarray = []
    summaryhash = {'R001' => 0.0, 'R002' => 0.0,'R003' => 0.0,'R004' => 0.0,'R005' => 0.0,'R006' => 0.0}
    bigarray<<['Transfer from', 'Transfer to', 'Amount']
    uniqbudgets = Budget.where(year: params[:year], semester: params[:semester]).uniq.pluck(:clubid)
    smusaaccount = ExpenditureAccount.find_by_clubid('smusa')
    uniqbudgets.each do |u|
      clubid = u
      clubtype = Club.find_by_clubid(clubid).clubtype
      reservecode = {'ACF'=>'R002', 'SICS' => 'R003', 'SMUX' => 'R004', 'SSU' => 'R005', 'ASOC'=>'R006', 'BONDUE'=>'R006', 'ICON'=>'R006', 'OIKOS'=>'R006', 'SISS'=>'R006', 'SOSCIETY'=>'R006', 'THE BAR'=>'R006'}
      tocode = Club.find_by_clubid(clubid).clubcode
      budgets = Budget.where(year: params[:year], semester: params[:semester], clubid: clubid)
      reserveaccount = ReserveAccount.find_by_clubid(clubid)
      expenditureaccount = ExpenditureAccount.find_by_clubid(clubid)
      requestsac = 0.0
      requestreserves = 0.0
      
      budgets.each do |b|
        requestsac += b.requestsac
        requestreserves += b.requestreserves
      end
      
      if !reserveaccount.nil?
        balance = reserveaccount.balance
        newbalance = balance - requestreserves
        contributionrate = Contribution.find_by_id(1).rate
        amounttocontribute = (contributionrate/100*requestsac).round(2)
        if amounttocontribute <= newbalance && clubid != 'ise' && clubid != 'eurhythmix' && clubid != 'sambam'
          requestsac -= amounttocontribute
          requestreserves += amounttocontribute
        end
        reserveaccount.update_attribute(:balance, balance-requestreserves)
        originalcat1 = expenditureaccount.Category1Balance
        expenditureaccount.update_attribute(:Category1Balance, originalcat1 + requestreserves)
        originalcat2 = expenditureaccount.Category2Balance
        expenditureaccount.update_attribute(:Category2Balance, originalcat2 + requestreserves)
        if clubtype == 'cbd'
          fromcode = reservecode[clubid]
        else
          fromcode = reservecode[clubtype]
        end
        bigarray<<[fromcode, tocode, '$'+requestreserves.to_s]
        summaryhash[fromcode] += requestreserves
      end
      originalcat1 = expenditureaccount.Category1Balance
      expenditureaccount.update_attribute(:Category1Balance, originalcat1 + requestsac)
      originalsmusa = smusaaccount.Category1Balance
      smusaaccount.update_attribute(:Category1Balance, originalsmusa - requestsac)
      bigarray<<['R001', tocode, '$'+requestsac.to_s]
      summaryhash['R001'] += requestsac
    end
    require 'prawn'
    Prawn::Document.generate("public/allocate.pdf") do
      # header
      bounding_box [bounds.left - 40, bounds.top + 40], :width  => bounds.width + 80 do
        cell :background_color => 'EEEEEE',
             :width => bounds.width,
             :height => 100,
             :align => :center,
             :text_color => "EEEEEE",
             :borders => [:bottom],
             :border_width => 2,
             :border_color => "rgb(1, 99, 172)",
             :padding => 12
        move_down 20
        image "#{Rails.root}/app/assets/images/smusa-new-logo.png", :at => [35, cursor], :width => 150
      end
      move_down 90
      text 'Allocation done on '+Date.today.to_s
      move_down 20
      text 'Total from:'
      text 'R001: ' + summaryhash['R001'].to_s 
      text 'R002: ' + summaryhash['R002'].to_s 
      text 'R003: ' + summaryhash['R003'].to_s 
      text 'R004: ' + summaryhash['R004'].to_s 
      text 'R005: ' + summaryhash['R005'].to_s 
      text 'R006: ' + summaryhash['R006'].to_s 
      #Body
      #Applicant Data
      move_down 20
      data = bigarray
      table(data, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 8, :size=>10, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
      move_down 20
    end
    file = File.open('public/allocate.pdf')
    ar = AllocationReport.new(report: file, reporttype: 'Allocation')
    ar.save
    flash.notice = 'Budgeted funds have been allocated'
    redirect_to :action => 'allocationreports'
    
  end
  
  

  def injectfunds
  end
  
  def setcontributionrate
    @contribution = Contribution.find_by_id(1)
  end
  
  def setrate
    c = Contribution.find_by_id(1)
    c.update_attribute(:rate, params[:contribution][:rate])
    flash.alert = 'New rate has been set'
    redirect_to :back
  end
  
  def calculation
    today = Date.today
    @a = Array(today.year-5..today.year).reverse
    if !params[:year].nil? && !params[:year].empty?
      @test = true
      incomes = Deposit.where(['(status = 5 or status = 11 or status = 16) and year(date) = ?', params[:year]])
      @clubprofits = 0.0
      @clubdonations = 0.0
      incomes.each do |i|
        if i.donorname.nil? || i.donorname.empty?
          @clubprofits += i.amount
        else
          @clubdonations += i.amount
        end
      end
      
      claims = Claim.where(['(status = 5 or status = 11 or status = 16) and year(created_at) = ?', params[:year]])
      @hash = Hash.new
      @arr = Array.new(14,0.0)
      @hash[65]=0.0
      @hash[66]=0.0
      @hash[67]=0.0
      @hash[68]=0.0
      @hash[69]=0.0
      @hash[70]=0.0
      @hash[71]=0.0
      claims.each do |c|
        if c.category == 'A'
          @hash[65] += c.amount
        elsif c.category == 'B'
           @hash[66] += c.amount
        elsif c.category == 'C'
           @hash[67] += c.amount
        elsif c.category == 'D'
           @hash[68] += c.amount
        elsif c.category == 'E'
           @hash[69] += c.amount
        elsif c.category == 'F'
           @hash[70] += c.amount
        elsif c.category == 'G'
           @hash[71] += c.amount
        end
        
        expense = c.expense
        if !expense.nil?
          @arr[expense.to_i] += c.amount
        end
      end
      
      
    end
  end
  
  def claimtimes
    if !params[:year].nil? && !params[:month].nil?
      @test = true
      claims = Claim.where(['year(created_at)=? and month(created_at)=?',params[:year], params[:month]])
      @clubhash = []
      @cbdhash = []
      
      @smusahash = []
      claims.each do |c|
        id = c.id
        minimum = ClaimTime.where(claimid:id).minimum(:status)
        timings = ClaimTime.where(claimid:id)
        hash = Hash.new
        hash['id']=c
        if minimum == 1
          timings.each do |t|
            
            hash[t.status]=t.date
          end
          @clubhash << hash
        elsif minimum == 7
          timings.each do |t|
            
            
            hash[t.status]=t.date
          end
          @cbdhash << hash
        elsif minimum ==13
          timings.each do |t|
            
            hash[t.status]=t.date
          end
          @smusahash << hash
        end
        
      end
    end
  end
  
  def allocationreports
    @reports = AllocationReport.all
  end
  
  def deleteallocationreport
    c = AllocationReport.find_by_id(params[:id])
    c.delete
    redirect_to :back
  end
  
  def reconcile
    
  end
  def autoreconcile
    file = params[:file]
    @superarray = []
    acceptedstatuses = [4,19,10,22,15,25]
    spreadsheet = open_spreadsheet(file).sheet('Others')
    (1..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      if !row.include?nil
        desc = row[3]
        
        start = desc.index('#')
        if !start.nil?
          last = desc.index('#',start+1)
        else
          last = nil
        end
        if !start.nil? && !last.nil?
          id = desc[start+1..last-1].to_i
          amount = row[4].to_d
          if amount > 0
            c = Deposit.find_by_id(id)
            if !c.nil? && acceptedstatuses.include?(c.status) && c.amount == (amount)
              newstatus = c.status + 1

              c.update_attribute(:status, newstatus)
              # redirect_to :action => 'viewclaim'
              club = c.clubid
              amount = c.amount
              account = ExpenditureAccount.find_by_clubid(club)
              balance = account.Category1Balance
              balance += amount
              account.update_attribute(:Category1Balance, balance)
              balance2 = account.Category2Balance
              balance2 += amount
              account.update_attribute(:Category2Balance, balance2)
              @superarray << row
            end 
          else
            c = Claim.find_by_id(id)
            if !c.nil? && acceptedstatuses.include?(c.status) && c.amount == (amount * -1)
              newstatus = c.status + 1
              ClaimTime.create(claimid: c.id, status: newstatus,date: Date.today)
              c.update_attribute(:status, newstatus)
              # redirect_to :action => 'viewclaim'
              club = c.clubid
              amount = c.amount
              account = ExpenditureAccount.find_by_clubid(club)
              balance = account.Category1Balance
              balance -= amount
              account.update_attribute(:Category1Balance, balance)
              @superarray << row
            end
            
          end
        end
      end
      
    end
  end
  
  def open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Csv.new(file.path, nil, :ignore)
  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end
end
