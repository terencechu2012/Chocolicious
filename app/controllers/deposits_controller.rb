class DepositsController < ApplicationController
  def addremark
    @rejectdeposit = Deposit.find_by_id(params[:id])
    @status = params[:status]
  end

  def clubdeposits
    role = session[:role]
    if role.include? 'clubfinsec'
      @normaldeposits = Deposit.where(:clubid => session[:club], :status => 1..5)
    elsif role.include? 'cbdfinsec'
      @normaldeposits = Deposit.where(['clubid in (select clubid from clubs where clubtype = ?) and status > 2 and status < 6', session[:club]])
      @cbdmcdeposits = Deposit.where(clubid:session[:club], status: 7..11)
    elsif role.include? 'president'
      @normaldeposits = Deposit.where(clubid:session[:club], status: 2..5)
      @cbdmcdeposits = Deposit.where(clubid:session[:club], status: 8..11)
      @deposits = @normaldeposits+ @cbdmcdeposits
      if session[:club] == 'smusa'
        @thirddeposits = Deposit.where(['clubid in (select clubid from clubs where clubtype = ?) and status > 12 and status < 17', 'smusa'])
        @deposits = @normaldeposits + @cbdmcdeposits + @thirddeposits
      end
      
    elsif role.include? 'smusafinsec'
      @cbdmcdeposits = Deposit.where(status: 9..11)
      @smusasecdeposits = Deposit.where(status: 14..16)
    end
  end

  def editdeposit
    @deposit = Deposit.find_by_id(params[:id])
    clubid = session[:club]
    @own = params[:own]
  end

  def newdeposit
    @new_deposit = Deposit.new
  end
  
  def viewdeposit
    @normaldeposits = Deposit.where(userid:session[:userid], clubid:session[:club])
  end
  def add
    Deposit.create(deposit_params)

    if session[:role].include? 'clubfinsec'
      redirect_to :action => 'clubdeposits'
    else
      redirect_to :action => 'viewdeposit'
    end
    
  end
  
  def deposit_params
    params.require(:deposit).permit!
  end
  
  def edit
    c = Deposit.find_by_id(params[:deposit][:id])
    c.update_attributes(deposit_params)
    redirect_to :action => 'clubdeposits'
  end
  
  def editown
    c = Deposit.find_by_id(params[:deposit][:id])
    c.update_attributes(deposit_params)
    redirect_to :action => 'viewdeposit'
  end
  
  
  def submitdeposit
    c = Deposit.find_by_id(params[:id])
    newstatus = c.status + 1

    c.update_attribute(:status, newstatus)
    # redirect_to :action => 'viewclaim'
    redirect_to :back
  end
  
  def completedeposit
    c = Deposit.find_by_id(params[:id])
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
    redirect_to :back
  end

  def resubmitdeposit
    c = Deposit.find_by_id(params[:id])
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

  def confirmrejectdeposit
    c = Deposit.find_by_id(params[:deposit][:id])

    c.update_attribute(:remarks, params[:deposit][:remarks])
    c.update_attribute(:status, params[:deposit][:status])
    redirect_to :action => 'clubdeposits'
  end
  
  
  def endorseclub
    require 'prawn'
    deposit = Deposit.find_by_id(params[:id])
    deposit.update_attribute(:status, 4)
    claimant = User.find_by_userid(deposit.userid)
    fullname = claimant.fullname
    contact = claimant.contactno
    datedeposit = deposit.date
    receipts = deposit.receipts
    purpose = deposit.purpose
    amount = deposit.amount
    donorname = deposit.donorname
    donoradd = deposit.donoradd
    donoric = deposit.donoric
    clubfinsec = Club.find_by_clubid(deposit.clubid).finsecid
    clubcode = Club.find_by_clubid(deposit.clubid).clubcode
    clubpres = Club.find_by_clubid(deposit.clubid).presidentid
    cbdfinsec = current_user.userid
    depositid = deposit.id
    clubname = Club.find_by_clubid(deposit.clubid).clubname
    cbdname = session[:club]
    date = Date.today
    Prawn::Document.generate("public/toprint.pdf") do
      text 'Deposit ID:'+depositid.to_s
      text 'Club Code:'+clubcode.to_s
      text 'Deposit By: '+fullname.to_s
      text 'Contact Number: '+contact.to_s
    
      text "Date: "+date.to_s
      move_down 30
      table([['Date of deposit', 'Amount', 'Receipt Nos', 'Purpose'],[datedeposit, amount, receipts, purpose]])
      move_down 30
      table([['Donor name', 'Donor Address', 'Donor IC'],[donorname, donoradd, donoric]])
      move_down 30
      table([['Prepared and verified by', 'Certified by', 'Endorsed/Approved by'], [clubfinsec, clubpres,cbdfinsec], [clubname, clubname, cbdname], ['Club finance secretary', 'Club president', 'CBD finance secretary']], :cell_style => {:borders => []})
    end
    redirect_to '/toprint.pdf'
  end
  
  def endorsecbdmc
    require 'prawn'
    deposit = Deposit.find_by_id(params[:id])
    deposit.update_attribute(:status, 10)
    claimant = User.find_by_userid(deposit.userid)
    fullname = claimant.fullname
    contact = claimant.contactno
    datedeposit = deposit.date
    receipts = deposit.receipts
    purpose = deposit.purpose
    
    amount = deposit.amount
    donorname = deposit.donorname
    donoradd = deposit.donoradd
    donoric = deposit.donoric
    cbdfinsec = Club.find_by_clubid(deposit.clubid).finsecid
    clubcode = Club.find_by_clubid(deposit.clubid).clubcode
    cbdpres = Club.find_by_clubid(deposit.clubid).presidentid
    smusafinsec = current_user.userid
    depositid = deposit.id
    clubname = Club.find_by_clubid(deposit.clubid).clubname
    cbdname = session[:club]
    date = Date.today
    Prawn::Document.generate("public/toprint.pdf") do
      text 'Deposit ID:'+depositid.to_s
      text 'Club Code:'+clubcode.to_s
      text 'Deposit By: '+fullname.to_s
      text 'Contact Number: '+contact.to_s
     
      text "Date: "+date.to_s
      move_down 30
      table([['Date of deposit', 'Amount', 'Receipt Nos', 'Purpose'],[datedeposit, amount, receipts, purpose]])
      move_down 30
      table([['Donor name', 'Donor Address', 'Donor IC'],[donorname, donoradd, donoric]])
      move_down 30
      table([['Prepared and verified by', 'Certified by', 'Endorsed/Approved by'], [cbdfinsec, cbdpres,smusafinsec], [clubname, clubname, cbdname], ['CBD finance secretary', 'CBD president', 'SMUSA finance secretary']], :cell_style => {:borders => []})
    end
    redirect_to '/toprint.pdf'
  end
  
  def endorsesmusasec
    require 'prawn'
    deposit = Deposit.find_by_id(params[:id])
    deposit.update_attribute(:status, 15)
    claimant = User.find_by_userid(deposit.userid)
    fullname = claimant.fullname
    contact = claimant.contactno
    datedeposit = deposit.date
    receipts = deposit.receipts
    purpose = deposit.purpose
   
    amount = deposit.amount
    donorname = deposit.donorname
    donoradd = deposit.donoradd
    donoric = deposit.donoric
    smusasec = claimant.userid
    smusafinsec = current_user.userid
    smusapres = Club.find_by_clubid('smusa').presidentid
    clubcode = Club.find_by_clubid(deposit.clubid).clubcode
    depositid = deposit.id
    clubname = Club.find_by_clubid(deposit.clubid).clubname
    cbdname = session[:club]
    date = Date.today
    Prawn::Document.generate("public/toprint.pdf") do
      text 'Deposit ID:'+depositid.to_s
      text 'Club Code:'+clubcode.to_s
      text 'Deposit By: '+fullname.to_s
      text 'Contact Number: '+contact.to_s

      text "Date: "+date.to_s
      move_down 30
      table([['Date of deposit', 'Amount', 'Receipt Nos', 'Purpose'],[datedeposit, amount, receipts, purpose]])
      move_down 30
      table([['Donor name', 'Donor Address', 'Donor IC'],[donorname, donoradd, donoric]])
      move_down 30
      table([['Prepared and verified by', 'Certified by','Endorsed/Approved by'], [smusasec,smusapres, smusafinsec], [clubname, cbdname, cbdname], ['SMUSA honourary secretary', 'SMUSA President','SMUSA finance secretary']], :cell_style => {:borders => []})
    end
    redirect_to '/toprint.pdf'
  end
  
end
