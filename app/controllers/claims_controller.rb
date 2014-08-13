class ClaimsController < ApplicationController
  def addremark
    @rejectclaim = Claim.find_by_id(params[:id])
    @status = params[:status]
  end

  def newclaim
    @new_claim = Claim.new
  end

  def editclaim
    @claim = Claim.find_by_id(params[:id])
  end

  def viewclaim
      @normalclaims = Claim.where(userid:session[:userid], clubid:session[:club])
  end

  def add
    test = false
    if current_user.nric.nil? || current_user.nric.empty?
      flash[:error] = 'There was a problem adding your claim. Have you updated your NRIC?'
    else
      test = Claim.create(claim_params).valid?
    end

    if !test
      flash[:error] = 'There was a problem adding your claim. Have you attached a supporting document?'
    end
    redirect_to :action => 'viewclaim'
  end

  def claim_params
    params.require(:claim).permit!
  end

  def edit
    c = Claim.find_by_id(params[:claim][:id])
    c.update_attributes(claim_params)
    redirect_to :action => 'viewclaim'
  end

  def submitclaim
    c = Claim.find_by_id(params[:id])
    newstatus = c.status + 1

    c.update_attribute(:status, newstatus)
    redirect_to :action => 'viewclaim'
  end

  def resubmitclaim
    c = Claim.find_by_id(params[:id])
    if c.status == 12
    newstatus = c.status + 1
    else
    newstatus = c.status + 2
    end

    c.update_attribute(:status, newstatus)
    c.update_attribute(:remarks, nil)
    redirect_to :action => 'viewclaim'
  end

  def confirmrejectclaim
    c = Claim.find_by_id(params[:claim][:id])

    c.update_attribute(:remarks, params[:claim][:remarks])
    c.update_attribute(:status, params[:claim][:status])
    redirect_to :action => 'viewclaim'
  end

  def endorseclub
    require 'prawn'
    claim = Claim.find_by_id(params[:id])
    claim.update_attribute(:status, 4)
    claimant = User.find_by_userid(claim.userid)
    fullname = claimant.fullname
    contact = claimant.contactno
    nric = claim.nric
    eventname = claim.event
    amount = claim.amount
    category = claim.category
    clubfinsec = Club.find_by_clubid(claim.clubid).finsecid
    clubpres = Club.find_by_clubid(claim.clubid).presidentid
    cbdfinsec = current_user.userid
    claimid = claim.id
    clubname = Club.find_by_clubid(claim.clubid).clubname
    cbdname = session[:club]
    date = Date.today
    Prawn::Document.generate("public/toprint.pdf") do
      text 'Claim ID:'+claimid.to_s

      text 'Payee Name: '+fullname.to_s
      text 'Contact Number: '+contact.to_s
      text 'NRIC: '+nric.to_s
      text "Date: "+date.to_s
      move_down 30
      table([['Event Name', 'Amount', 'Category'],[eventname, amount, category]])
      move_down 30
      table([['Prepared and verified by', 'Certified by', 'Endorsed/Approved by'], [clubfinsec, clubpres,cbdfinsec], [clubname, clubname, cbdname], ['Club finance secretary', 'Club president', 'CBD finance secretary']], :cell_style => {:borders => []})
    end
    redirect_to '/toprint.pdf'
  end

  def endorsecbdmc
    require 'prawn'
    claim = Claim.find_by_id(params[:id])
    claim.update_attribute(:status, 10)
    claimant = User.find_by_userid(claim.userid)
    fullname = claimant.fullname
    contact = claimant.contactno
    nric = claim.nric
    eventname = claim.event
    amount = claim.amount
    category = claim.category
    cbdfinsec = Club.find_by_clubid(claim.clubid).finsecid
    cbdpres = Club.find_by_clubid(claim.clubid).presidentid
    smusafinsec = current_user.userid
    claimid = claim.id
    clubname = Club.find_by_clubid(claim.clubid).clubname
    cbdname = session[:club]
    date = Date.today
    Prawn::Document.generate("public/toprint.pdf") do
      text 'Claim ID:'+claimid.to_s

      text 'Payee Name: '+fullname.to_s
      text 'Contact Number: '+contact.to_s
      text 'NRIC: '+nric.to_s
      text "Date: "+date.to_s
      move_down 30
      table([['Event Name', 'Amount', 'Category'],[eventname, amount, category]])
      move_down 30
      table([['Prepared and verified by', 'Certified by', 'Endorsed/Approved by'], [cbdfinsec, cbdpres,smusafinsec], [clubname, clubname, cbdname], ['CBD finance secretary', 'CBD president', 'SMUSA finance secretary']], :cell_style => {:borders => []})
    end
    redirect_to '/toprint.pdf'
  end

  def endorsesmusasec
    require 'prawn'
    claim = Claim.find_by_id(params[:id])
    claim.update_attribute(:status, 14)
    claimant = User.find_by_userid(claim.userid)
    fullname = claimant.fullname
    contact = claimant.contactno
    nric = claim.nric
    eventname = claim.event
    amount = claim.amount
    category = claim.category
    smusasec = claimant.userid
    smusafinsec = current_user.userid
    claimid = claim.id
    clubname = Club.find_by_clubid(claim.clubid).clubname
    cbdname = session[:club]
    date = Date.today
    Prawn::Document.generate("public/toprint.pdf") do
      text 'Claim ID:'+claimid.to_s

      text 'Payee Name: '+fullname.to_s
      text 'Contact Number: '+contact.to_s
      text 'NRIC: '+nric.to_s
      text "Date: "+date.to_s
      move_down 30
      table([['Event Name', 'Amount', 'Category'],[eventname, amount, category]])
      move_down 30
      table([['Prepared and verified by', 'Endorsed/Approved by'], [smusasec,smusafinsec], [clubname, cbdname], ['SMUSA honourary secretary', 'SMUSA finance secretary']], :cell_style => {:borders => []})
    end
    redirect_to '/toprint.pdf'
  end

end
