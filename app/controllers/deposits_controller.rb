class DepositsController < ApplicationController
  def addremark
    @rejectdeposit = Deposit.find_by_id(params[:id])
    @status = params[:status]
  end

  def clubdeposits
    role = session[:role]
    if role.include? 'clubfinsec'
      @normaldeposits = Deposit.where(:clubid => session[:club], :status => [1..5, 17..19, 26..28])
    elsif role.include? 'cbdfinsec'
      @normaldeposits = Deposit.where(['clubid in (select clubid from clubs where clubtype = ?) and ((status > 2 and status < 6) or (status>16 and status<20) or (status>25 and status<29))', session[:club]])
      @cbdmcdeposits = Deposit.where(clubid:session[:club], status: [7..11, 20..22, 26..28])
    elsif role.include? 'president'
      @normaldeposits = Deposit.where(clubid:session[:club], status: [2..5, 17..19, 26..28])
      @cbdmcdeposits = Deposit.where(clubid:session[:club], status: [8..11, 20..22, 26..28])
      @deposits = @normaldeposits+ @cbdmcdeposits
      if session[:club] == 'smusa'
        @thirddeposits = Deposit.where(['clubid in (select clubid from clubs where clubtype = ?) and ((status > 12 and status < 17) or (status > 22 and status < 26))', 'smusa'])
        @deposits = @normaldeposits + @cbdmcdeposits + @thirddeposits
      end
      
    elsif role.include? 'smusafinsec'
      @cbdmcdeposits = Deposit.where(status: [9..11, 20..22]) + Deposit.where(status: [26..28], claimtype: 'cbd')
      @smusasecdeposits = Deposit.where(status: [14..16, 23..25])+ Deposit.where(status: [26..28], claimtype: 'smusasec')
    elsif role == 'osl'
      clubs = Club.where(oslstaff: session[:userid]).pluck(:clubid)
      u = User.find_by_userid(session[:userid]).fullname
      if u.nil?
        u = session[:userid]
      end
      @osldeposits = Deposit.where(status: [17,20,23,26,27,28], clubid: clubs) | Deposit.where(["approvedby LIKE ?", "%"+u+"%"])
      
    elsif role =='oslad'
      cbds = Club.where(oslstaff: session[:userid]).pluck(:clubid)
      u = User.find_by_userid(session[:userid]).fullname
      if u.nil?
        u = session[:userid]
      end
      clubs = Club.where(clubtype: cbds).pluck(:clubid) + cbds
      @osldeposits = Deposit.where(status: [26,27,28], clubid: clubs) | Deposit.where(["approvedby LIKE ?", "%"+u+"%"])
    elsif role == 'osld'
      u = User.find_by_userid(session[:userid]).fullname
      if u.nil?
        u = session[:userid]
      end
      @osldeposits = Deposit.where(status: [27,28]) | Deposit.where(["approvedby LIKE ?", "%"+u+"%"])
    elsif role == 'dos'
      u = User.find_by_userid(session[:userid]).fullname
      if u.nil?
        u = session[:userid]
      end
      @osldeposits = Deposit.where(status: [28]) | Deposit.where(["approvedby LIKE ?", "%"+u+"%"])
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
    test = Deposit.create(deposit_params).valid?
    if !test
      flash[:error] = 'There was a problem adding your deposit. Have you attached a supporting document?'
    end

    if session[:role].include? 'clubfinsec'
      redirect_to :action => 'clubdeposits'
    else
      redirect_to :action => 'viewdeposit'
    end
    
  end
  
    def viewrejecteddeposit
    @rejecteddeposits = RejectedDeposit.all
  end

  
  def deposit_params
    params.require(:deposit).permit!
  end
  
  def edit
    c = Deposit.find_by_id(params[:deposit][:id])
    begin
      c.update_attributes(deposit_params)
    rescue Exception => e
      p e.backtrace
      p 'HERE'
    end
    # Rails.logger.info(c.errors.messages.inspect)
    redirect_to :action => 'clubdeposits'
  end
  
  def editown
    c = Deposit.find_by_id(params[:deposit][:id])
    begin
      c.update_attributes(deposit_params)
    rescue Exception => e
      p e.backtrace
      p 'HERE'
    end
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
    
    rc = RejectedDeposit.find_by_depositid(params[:id])
    if rc.status == 12
    newstatus = rc.status + 2
    else
    newstatus = rc.status + 2
    end

    rc.update_attribute(:status, newstatus)
    rc.update_attribute(:remarks, nil)
    
    
    # redirect_to :action => 'viewclaim'
    redirect_to :back
  end

  def confirmrejectdeposit
    c = Deposit.find_by_id(params[:deposit][:id])

    c.update_attribute(:remarks, params[:deposit][:remarks])
    c.update_attribute(:status, params[:deposit][:status])
    RejectedDeposit.create(depositid: c.id, clubid: c.clubid, madeby: c.userid, rejectedby: current_user.userid, amount: c.amount, status: params[:deposit][:status], remarks: params[:deposit][:remarks])
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
    if !clubfinsec.nil?
      clubfinsec = User.find_by_userid(clubfinsec).fullname
    end
    clubcode = Club.find_by_clubid(deposit.clubid).clubcode
    clubpres = Club.find_by_clubid(deposit.clubid).presidentid
    if !clubpres.nil?
      clubpres = User.find_by_userid(clubpres).fullname
    end
    cbdfinsec = current_user.userid
    if !cbdfinsec.nil?
      cbdfinsec = User.find_by_userid(cbdfinsec).fullname
    end
    depositid = deposit.id
    clubname = Club.find_by_clubid(deposit.clubid).clubname
    cbdname = session[:club]
    approvedby = deposit.approvedby
    if approvedby.nil?
      approvedby = "No OSL staff approval needed"
    end
    approved2 = approvedby.split(',')
    sectors = approved2.size
    date = Date.today
    Prawn::Document.generate("public/toprint.pdf") do
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
      #Body
      #Applicant Data
      data = [
                ["<b>Deposit ID</b>"," : "+depositid.to_s],
                ['<b>Club Code</b>'," : "+clubcode.to_s],
                [" "," "],
                ['<b>Deposit by</b>'," : "+fullname.to_s],
                ['<b>Contact Number</b>'," : "+contact.to_s],
                [" "," "],
                ["<b>Date</b>"," : "+date.to_s]
              ]
      table(data, :cell_style => { :border_color => "FFFFFF", :padding => 2, :size=>10, :inline_format => true})
      move_down 30
      #Application Details
      details = [
                  ["<b>Date of Deposit</b>","<b>Amount</b>","<b>Receipt No.</b>","<b>Purpose</b>"],
                  [datedeposit.to_s, "$ "+amount.to_s, receipts.to_s, purpose.to_s]
                ]
      table(details, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 8, :size=>10, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
      move_down 20
      donortable = [
                  ["<b>Donor name</b>","<b>Donor Address</b>","<b>Donor IC</b>"],
                  [donorname.to_s, donoradd.to_s, donoric.to_s]
                ]
      table(donortable, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 8, :size=>10, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
      move_down 60
      #Approval Details
      approval = [
                  ["<b>Prepared and verified by</b>","<b>Certified by</b>","<b>Endorsed/Approved by</b>"],
                  [clubfinsec.to_s, clubpres.to_s,cbdfinsec.to_s],
                  [clubname.to_s+", Club Finance Secretary",clubname.to_s+", Club President", cbdname.to_s+", CBd Finance Secretary"]
                ]
      table(approval, :width => bounds.width, :cell_style => { :border_color => "FFFFFF", :padding => 6, :size=>10, :inline_format => true})
      #Footer
      if sectors != 1
          
        for i in 1..sectors/2
          
          newapprove = [
            ['<b>Approved by</b>'],[approved2[2*i-2].to_s+', '+approved2[2*i-1]]
          ]
          table(newapprove, :width => bounds.width, :cell_style => { :border_color => "FFFFFF", :padding => 6, :size=>10, :inline_format => true})
        end
      end
      bounding_box [bounds.left-40, bounds.bottom], :width  => bounds.width+80 do
        cell :content => 'Generated Report using the SMUSA Accounting Information System',
             :background_color => 'EEEEEE',
             :width => bounds.width,
             :height => 40,
             :align => :center,
             :text_color => "#202020",
             :borders => [:top],
             :border_width => 2,
             :border_color => "rgb(1, 99, 172)",
             :padding => 12
      end
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
    if !cbdfinsec.nil?
      cbdfinsec = User.find_by_userid(cbdfinsec).fullname
    end
    clubcode = Club.find_by_clubid(deposit.clubid).clubcode
    cbdpres = Club.find_by_clubid(deposit.clubid).presidentid
    if !cbdpres.nil?
      cbdpres = User.find_by_userid(cbdpres).fullname
    end
    smusafinsec = current_user.userid
    if !smusafinsec.nil?
      smusafinsec = User.find_by_userid(smusafinsec).fullname
    end
    depositid = deposit.id
    clubname = Club.find_by_clubid(deposit.clubid).clubname
    approvedby = deposit.approvedby
    if approvedby.nil?
      approvedby = "No OSL staff approval needed"
    end
    approved2 = approvedby.split(',')
    sectors = approved2.size
    cbdname = session[:club]
    date = Date.today
    Prawn::Document.generate("public/toprint.pdf") do
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
      #Body
      #Applicant Data
      data = [
                ["<b>Deposit ID</b>"," : "+depositid.to_s],
                ['<b>Club Code</b>'," : "+clubcode.to_s],
                [" "," "],
                ['<b>Deposit by</b>'," : "+fullname.to_s],
                ['<b>Contact Number</b>'," : "+contact.to_s],
                [" "," "],
                ["<b>Date</b>"," : "+date.to_s]
              ]
      table(data, :cell_style => { :border_color => "FFFFFF", :padding => 2, :size=>10, :inline_format => true})
      move_down 30
      #Application Details
      details = [
                  ["<b>Date of Deposit</b>","<b>Amount</b>","<b>Receipt No.</b>","<b>Purpose</b>"],
                  [datedeposit.to_s, "$ "+amount.to_s, receipts.to_s, purpose.to_s]
                ]
      table(details, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 8, :size=>10, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
      move_down 20
      donortable = [
                  ["<b>Donor name</b>","<b>Donor Address</b>","<b>Donor IC</b>"],
                  [donorname.to_s, donoradd.to_s, donoric.to_s]
                ]
      table(donortable, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 8, :size=>10, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
      move_down 60
      #Approval Details
      approval = [
                  ["<b>Prepared and verified by</b>","<b>Certified by</b>","<b>Endorsed/Approved by</b>"],
                  [cbdfinsec.to_s, cbdpres.to_s,smusafinsec.to_s],
                  [clubname.to_s+", CBd Finance Secretary",clubname.to_s+", CBd President", cbdname.to_s+", SMUSA Finance Secretary"]
                ]
      table(approval, :width => bounds.width, :cell_style => { :border_color => "FFFFFF", :padding => 6, :size=>10, :inline_format => true})
      if sectors != 1
          
        for i in 1..sectors/2
          
          newapprove = [
            ['<b>Approved by</b>'],[approved2[2*i-2].to_s+', '+approved2[2*i-1]]
          ]
          table(newapprove, :width => bounds.width, :cell_style => { :border_color => "FFFFFF", :padding => 6, :size=>10, :inline_format => true})
        end
      end
      #Footer
      bounding_box [bounds.left-40, bounds.bottom], :width  => bounds.width+80 do
        cell :content => 'Generated Report using the SMUSA Accounting Information System',
             :background_color => 'EEEEEE',
             :width => bounds.width,
             :height => 40,
             :align => :center,
             :text_color => "#202020",
             :borders => [:top],
             :border_width => 2,
             :border_color => "rgb(1, 99, 172)",
             :padding => 12
      end
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
    if !smusasec.nil?
      smusasec = User.find_by_userid(smusasec).fullname
    end
    smusafinsec = current_user.userid
    if !smusafinsec.nil?
      smusafinsec = User.find_by_userid(smusafinsec).fullname
    end
    smusapres = Club.find_by_clubid('smusa').presidentid
    if !smusapres.nil?
      smusapres = User.find_by_userid(smusapres).fullname
    end
    clubcode = Club.find_by_clubid(deposit.clubid).clubcode
    depositid = deposit.id
    clubname = Club.find_by_clubid(deposit.clubid).clubname
    cbdname = session[:club]
    date = Date.today
    approvedby = deposit.approvedby
    if approvedby.nil?
      approvedby = "No OSL staff approval needed"
    end
    approved2 = approvedby.split(',')
    sectors = approved2.size
    Prawn::Document.generate("public/toprint.pdf") do
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
      #Body
      #Applicant Data
      data = [
                ["<b>Deposit ID</b>"," : "+depositid.to_s],
                ['<b>Club Code</b>'," : "+clubcode.to_s],
                [" "," "],
                ['<b>Deposit by</b>'," : "+fullname.to_s],
                ['<b>Contact Number</b>'," : "+contact.to_s],
                [" "," "],
                ["<b>Date</b>"," : "+date.to_s]
              ]
      table(data, :cell_style => { :border_color => "FFFFFF", :padding => 2, :size=>10, :inline_format => true})
      move_down 30
      #Application Details
      details = [
                  ["<b>Date of Deposit</b>","<b>Amount</b>","<b>Receipt No.</b>","<b>Purpose</b>"],
                  [datedeposit.to_s, "$ "+amount.to_s, receipts.to_s, purpose.to_s]
                ]
      table(details, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 8, :size=>10, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
      move_down 20
      donortable = [
                  ["<b>Donor name</b>","<b>Donor Address</b>","<b>Donor IC</b>"],
                  [donorname.to_s, donoradd.to_s, donoric.to_s]
                ]
      table(donortable, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 8, :size=>10, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
      move_down 60
      #Approval Details
      approval = [
                  ["<b>Prepared and verified by</b>","<b>Certified by</b>","<b>Endorsed/Approved by</b>"],
                  [smusasec.to_s,smusapres.to_s, smusafinsec.to_s],
                  [clubname.to_s+", SMUSA Honourary Secretary",clubname.to_s+", SMUSA President", cbdname.to_s+", SMUSA Finance Secretary"]
                ]
      table(approval, :width => bounds.width, :cell_style => { :border_color => "FFFFFF", :padding => 6, :size=>10, :inline_format => true})
      #Footer
      if sectors != 1
          
        for i in 1..sectors/2
          
          newapprove = [
            ['<b>Approved by</b>'],[approved2[2*i-2].to_s+', '+approved2[2*i-1]]
          ]
          table(newapprove, :width => bounds.width, :cell_style => { :border_color => "FFFFFF", :padding => 6, :size=>10, :inline_format => true})
        end
      end
      bounding_box [bounds.left-40, bounds.bottom], :width  => bounds.width+80 do
        cell :content => 'Generated Report using the SMUSA Accounting Information System',
             :background_color => 'EEEEEE',
             :width => bounds.width,
             :height => 40,
             :align => :center,
             :text_color => "#202020",
             :borders => [:top],
             :border_width => 2,
             :border_color => "rgb(1, 99, 172)",
             :padding => 12
      end
    end
    redirect_to '/toprint.pdf'
  end
  
  def deletedeposit
    c = Deposit.find_by_id(params[:id])
    c.delete
    redirect_to :back
  end
  
  def submitosl
    c = Deposit.find_by_id(params[:id])
    status = c.status
    if status == 3
      newstatus = 17
      c.update_attribute(:deposittype, 'club')
    elsif status == 9
      newstatus = 26
      c.update_attribute(:deposittype, 'cbd')
    elsif status == 14
      newstatus = 26
      c.update_attribute(:deposittype, 'smusasec')
    end

    c.update_attribute(:status, newstatus)
    # redirect_to :action => 'viewclaim'
    redirect_to :back
  end
  def oslprocess
    c = Deposit.find_by_id(params[:id])
    amount = c.amount
    status = c.status
    if status == 17
      c.update_attribute(:deposittype, 'club')
    elsif status == 20
      c.update_attribute(:deposittype, 'cbd')
    elsif status == 23
      c.update_attribute(:deposittype, 'smusasec')
    end
    hash2 = {'club'=>18, 'cbd'=>21, 'smusasec'=>24}
    approvedby = c.approvedby
    user = User.find_by_userid(session[:userid]).fullname
    if user.nil?
      user = session[:userid]
    end
    role = session[:role]
    hash = {'osl'=>'OSL Manager', 'oslad' => 'OSL Associate Director', 'osld' => 'OSL Director', 'dos' => 'Dean of Students'}
    person = user + ', '+hash[role] 
    if approvedby.nil?
      c.update_attribute(:approvedby, person)
    else
      c.update_attribute(:approvedby, approvedby + ', ' + person)
    end
    
    if status == 17 || status == 20 || status == 23
      
      c.update_attribute(:status, 26)
    elsif status == 26
      if amount <= 7500
        c.update_attribute(:status, hash2[c.deposittype])
      else
        c.update_attribute(:status, 27)
      end
    elsif status == 27
       if amount <= 10000
        c.update_attribute(:status, hash2[c.deposittype])
      else
        c.update_attribute(:status, 28)
      end
    elsif status == 28
       c.update_attribute(:status, hash2[c.deposittype])
    end
    redirect_to :back
  end
end
