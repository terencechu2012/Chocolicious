class ClaimsController < ApplicationController
  def addremark
    @rejectclaim = Claim.find_by_id(params[:id])
    @status = params[:status]
  end

  def newclaim
    @new_claim = Claim.new
    clubid = session[:club]
    control = BudgetControl.find_by_id(2)
    year = control.year
    semester = control.semester
    @events = Budget.where(clubid:clubid, year:year, semester:semester)
  end

  def editclaim
    @claim = Claim.find_by_id(params[:id])
    clubid = session[:club]
    control = BudgetControl.find_by_id(2)
    year = control.year
    semester = control.semester
    @events = Budget.where(clubid:clubid, year:year, semester:semester)
    @own = params[:own]
  end
  
  def deleteclaim
    c = Claim.find_by_id(params[:id])
    c.delete
    redirect_to :back
  end

  def viewclaim
      @normalclaims = Claim.where(userid:session[:userid], clubid:session[:club])
  end
  def clubclaims
    role = session[:role]
    if role.include? 'clubfinsec'
      @normalclaims = Claim.where(:clubid => session[:club], :status => [1..5, 17..19])
    elsif role.include? 'cbdfinsec'
      @normalclaims = Claim.where(['clubid in (select clubid from clubs where clubtype = ?) and ((status > 2 and status < 6) or (status>16 and status<20))', session[:club]])
      @cbdmcclaims = Claim.where(clubid:session[:club], status: [7..11, 20..22])
    elsif role.include? 'president'
      @normalclaims = Claim.where(clubid:session[:club], status: [2..5, 17..19])
      @cbdmcclaims = Claim.where(clubid:session[:club], status: [8..11, 20..22])
      @claims = @normalclaims + @cbdmcclaims
      if session[:club] == 'smusa'
        @thirdclaims = Claim.where(['clubid in (select clubid from clubs where clubtype = ?) and ((status > 12 and status < 17) or (status > 22 and status < 26))', 'smusa'])
        @claims = @normalclaims + @cbdmcclaims + @thirdclaims
      end
      
    elsif role.include? 'smusafinsec'
      @cbdmcclaims = Claim.where(status: [9..11, 20..22])
      @smusasecclaims = Claim.where(status: [14..16, 23..25])
    elsif role.include? 'osl'
      @oslclaims = Claim.where(status: [17..25])
    end
  end

  def add
    test = false
   
    balance = ExpenditureAccount.find_by_clubid(session[:club]).Category1Balance
    amount = params[:claim][:amount]
    if current_user.nric.nil? || current_user.nric.empty?
      flash[:error] = 'There was a problem adding your claim. Have you updated your NRIC?'
    elsif amount.to_d > balance
      flash[:error] = 'There are insufficient funds in the expenditure account'
    else
      p 'Hellos!!'
      test = Claim.create(claim_params).valid?
      if !test
        flash[:error] = 'There was a problem adding your claim. Have you attached a supporting document?'
      end
    end

    
    redirect_to :action => 'viewclaim'
  end

  def claim_params
    params.require(:claim).permit!
  end

  def edit
    c = Claim.find_by_id(params[:claim][:id])
    c.update_attributes(claim_params)
    redirect_to :action => 'clubclaims'
  end
  
  def editown
    c = Claim.find_by_id(params[:claim][:id])
    c.update_attributes(claim_params)
    redirect_to :action => 'viewclaim'
  end

  def submitclaim
    c = Claim.find_by_id(params[:id])
    newstatus = c.status + 1
    ClaimTime.create(claimid: c.id, status: newstatus,date: Date.today)
    c.update_attribute(:status, newstatus)
    # redirect_to :action => 'viewclaim'
    redirect_to :back
  end
  
  def completeclaim
    c = Claim.find_by_id(params[:id])
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
    redirect_to :back
  end

  def resubmitclaim
    c = Claim.find_by_id(params[:id])
    if c.status == 12
    newstatus = c.status + 2
    else
    newstatus = c.status + 2
    end

    c.update_attribute(:status, newstatus)
    c.update_attribute(:remarks, nil)
    # redirect_to :action => 'viewclaim'
    redirect_to :back
  end

  def confirmrejectclaim
    c = Claim.find_by_id(params[:claim][:id])

    c.update_attribute(:remarks, params[:claim][:remarks])
    c.update_attribute(:status, params[:claim][:status])
    redirect_to :action => 'clubclaims'
  end

  def endorseclub
    require 'prawn'
    claim = Claim.find_by_id(params[:id])
    claim.update_attribute(:status, 4)
    ClaimTime.create(claimid: claim.id, status: 4,date: Date.today)
    claimant = User.find_by_userid(claim.userid)
    fullname = claimant.fullname
    contact = claimant.contactno
    nric = claim.nric
    eventname = claim.event
    amount = claim.amount
    category = claim.category
    expense = claim.expense
    clubfinsec = Club.find_by_clubid(claim.clubid).finsecid
    clubcode = Club.find_by_clubid(claim.clubid).clubcode
    clubpres = Club.find_by_clubid(claim.clubid).presidentid
    cbdfinsec = current_user.userid
    claimid = claim.id
    clubname = Club.find_by_clubid(claim.clubid).clubname
    cbdname = session[:club]
    date = Date.today
    Prawn::Document.generate("public/toprint.pdf") do
      text 'Claim ID:'+claimid.to_s
      text 'Club Code:'+clubcode.to_s
      text 'Payee Name: '+fullname.to_s
      text 'Contact Number: '+contact.to_s
      text 'NRIC: '+nric.to_s
      text "Date: "+date.to_s
      move_down 30
      table([['Event Name', 'Amount', 'Category','Expense'],[eventname, amount, category, expense]])
      move_down 30
      table([['Prepared and verified by', 'Certified by', 'Endorsed/Approved by'], [clubfinsec, clubpres,cbdfinsec], [clubname, clubname, cbdname], ['Club finance secretary', 'Club president', 'CBD finance secretary']], :cell_style => {:borders => []})
    end
    redirect_to '/toprint.pdf'
  end

  def endorsecbdmc
    require 'prawn'
    claim = Claim.find_by_id(params[:id])
    claim.update_attribute(:status, 10)
    ClaimTime.create(claimid: claim.id, status: 10,date: Date.today)
    claimant = User.find_by_userid(claim.userid)
    fullname = claimant.fullname
    contact = claimant.contactno
    nric = claim.nric
    eventname = claim.event
    amount = claim.amount
    category = claim.category
    expense = claim.expense
    cbdfinsec = Club.find_by_clubid(claim.clubid).finsecid
    clubcode = Club.find_by_clubid(claim.clubid).clubcode
    cbdpres = Club.find_by_clubid(claim.clubid).presidentid
    smusafinsec = current_user.userid
    claimid = claim.id
    clubname = Club.find_by_clubid(claim.clubid).clubname
    cbdname = session[:club]
    date = Date.today
    Prawn::Document.generate("public/toprint.pdf") do
      text 'Claim ID:'+claimid.to_s
      text 'Club Code:'+clubcode.to_s
      text 'Payee Name: '+fullname.to_s
      text 'Contact Number: '+contact.to_s
      text 'NRIC: '+nric.to_s
      text "Date: "+date.to_s
      move_down 30
      table([['Event Name', 'Amount', 'Category','Expense'],[eventname, amount, category, expense]])
      move_down 30
      table([['Prepared and verified by', 'Certified by', 'Endorsed/Approved by'], [cbdfinsec, cbdpres,smusafinsec], [clubname, clubname, cbdname], ['CBD finance secretary', 'CBD president', 'SMUSA finance secretary']], :cell_style => {:borders => []})
    end
    redirect_to '/toprint.pdf'
  end

  def endorsesmusasec
    require 'prawn'
    claim = Claim.find_by_id(params[:id])
    claim.update_attribute(:status, 15)
    ClaimTime.create(claimid: claim.id, status: 15,date: Date.today)
    claimant = User.find_by_userid(claim.userid)
    fullname = claimant.fullname
    contact = claimant.contactno
    nric = claim.nric
    eventname = claim.event
    amount = claim.amount
    category = claim.category
    expense = claim.expense
    smusasec = claimant.userid
    smusafinsec = current_user.userid
    smusapres = Club.find_by_clubid('smusa').presidentid
    clubcode = Club.find_by_clubid(claim.clubid).clubcode
    claimid = claim.id
    clubname = Club.find_by_clubid(claim.clubid).clubname
    cbdname = session[:club]
    date = Date.today
    Prawn::Document.generate("public/toprint.pdf") do
      text 'Claim ID:'+claimid.to_s
      text 'Club Code:'+clubcode.to_s
      text 'Payee Name: '+fullname.to_s
      text 'Contact Number: '+contact.to_s
      text 'NRIC: '+nric.to_s
      text "Date: "+date.to_s
      move_down 30
      table([['Event Name', 'Amount', 'Category','Expense'],[eventname, amount, category, expense]])
      move_down 30
      table([['Prepared and verified by', 'Certified by','Endorsed/Approved by'], [smusasec, smusapres, smusafinsec], [clubname,cbdname, cbdname], ['SMUSA honourary secretary', 'SMUSA President','SMUSA finance secretary']], :cell_style => {:borders => []})
    end
    redirect_to '/toprint.pdf'
  end
  
  def submitosl
    c = Claim.find_by_id(params[:id])
    status = c.status
    if status == 3
      newstatus = 17
    elsif status == 9
      newstatus = 20
    elsif status == 14
      newstatus = 23
    end

    c.update_attribute(:status, newstatus)
    # redirect_to :action => 'viewclaim'
    redirect_to :back
  end

end
