class PaymentsController < ApplicationController
  def addremark
    @rejectpayment = Payment.find_by_id(params[:id])
    @status = params[:status]
  end

  def newpayment
    @new_payment = Payment.new
    clubid = session[:club]
    control = BudgetControl.find_by_id(2)
    year = control.year
    semester = control.semester
    @events = Budget.where(clubid:clubid, year:year, semester:semester)
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
    @grouped_category = {
      'Internal' => [['Within SMU only/SMU events&competitions (e.g Vivace, school held competitions)','A']],
      'External' => [['Inter-uni/with external organisations (Competitions e.g. taking part in IVP)','B'],['Inter-uni/with external organisations (Non-competitive e.g. tri-uni conferences)','C']],
      'Club-organised activties' => [['Training/Lessons/Internal club events','D'],['Events open to SMU Students only (e.g expeditions, runabout, Waikiki)','E'],['Events open to SMU Students and/or external participants (e.g IVPs, Women football clinics)','F']],
      'Administrative Operations' => [['Meetings, noticeboard decorating etc','G']]
    }
  end

  def editpayment
    @payment = Payment.find_by_id(params[:id])
    clubid = session[:club]
    control = BudgetControl.find_by_id(2)
    year = control.year
    semester = control.semester
    @events = Budget.where(clubid:clubid, year:year, semester:semester)
    @own = params[:own]
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
    @grouped_category = {
      'Internal' => [['Within SMU only/SMU events&competitions (e.g Vivace, school held competitions)','A']],
      'External' => [['Inter-uni/with external organisations (Competitions e.g. taking part in IVP)','B'],['Inter-uni/with external organisations (Non-competitive e.g. tri-uni conferences)','C']],
      'Club-organised activties' => [['Training/Lessons/Internal club events','D'],['Events open to SMU Students only (e.g expeditions, runabout, Waikiki)','E'],['Events open to SMU Students and/or external participants (e.g IVPs, Women football clinics)','F']],
      'Administrative Operations' => [['Meetings, noticeboard decorating etc','G']]
    }
  end
  
  def deletepayment
    c = Payment.find_by_id(params[:id])
    c.delete
    redirect_to :back
  end

  def viewpayment
      @normalpayments = Payment.where(userid:session[:userid], clubid:session[:club])
  end
  
  def clubpayments
    role = session[:role]
    if role.include? 'clubfinsec'
      @normalpayments = Payment.where(:clubid => session[:club], :status => [1..5, 17..19, 26..28])
    elsif role.include? 'cbdfinsec'
      @normalpayments = Payment.where(['clubid in (select clubid from clubs where clubtype = ?) and ((status > 2 and status < 6) or (status>16 and status<20) or (status>25 and status<29))', session[:club]])
      @cbdmcpayments = Payment.where(clubid:session[:club], status: [7..11, 20..22, 26..28])
    elsif role.include? 'president'
      @normalpayments = Payment.where(clubid:session[:club], status: [2..5, 17..19, 26..28])
      @cbdmcpayments = Payment.where(clubid:session[:club], status: [8..11, 20..22, 26..28])
      @payments = @normalpayments + @cbdmcpayments
      
      if session[:club] == 'smusa'
        @thirdpayments = Payment.where(['clubid in (select clubid from clubs where clubtype = ?) and ((status > 12 and status < 17) or (status > 22 and status < 26))', 'smusa'])
        @payments = @normalpayments + @cbdmcpayments + @thirdpayments
      end
      
    elsif role.include? 'smusafinsec'
      @cbdmcpayments = Payment.where(status: [9..11, 20..22]) + Payment.where(status: [26..28], claimtype: 'cbd')
      @smusasecpayments = Payment.where(status: [14..16, 23..25])+ Payment.where(status: [26..28], claimtype: 'smusasec')
    elsif role == 'osl'
      clubs = Club.where(oslstaff: session[:userid]).pluck(:clubid)
      u = User.find_by_userid(session[:userid]).fullname
      if u.nil?
        u = session[:userid]
      end
      @oslpayments = Payment.where(status: [17,20,23,26,27,28], clubid: clubs) | Payment.where(["approvedby LIKE ?", "%"+u+"%"])
    elsif role =='oslad'
      cbds = Club.where(oslstaff: session[:userid]).pluck(:clubid)
      clubs = Club.where(clubtype: cbds).pluck(:clubid) + cbds
      u = User.find_by_userid(session[:userid]).fullname
      if u.nil?
        u = session[:userid]
      end
      @oslpayments = Payment.where(status: [26,27,28], clubid: clubs) | Payment.where(["approvedby LIKE ?", "%"+u+"%"])
    elsif role == 'osld'
      u = User.find_by_userid(session[:userid]).fullname
      if u.nil?
        u = session[:userid]
      end
      @oslpayments = Payment.where(status: [27,28]) | Payment.where(["approvedby LIKE ?", "%"+u+"%"])
    elsif role == 'dos'
      u = User.find_by_userid(session[:userid]).fullname
      if u.nil?
        u = session[:userid]
      end
      @oslpayments = Payment.where(status: [28]) | Payment.where(["approvedby LIKE ?", "%"+u+"%"])
    end
  end

  def add
    test = false
   
    balance = ExpenditureAccount.find_by_clubid(session[:club]).Category1Balance
    amount = params[:payment][:amount]
    if current_user.nric.nil? || current_user.nric.empty?
      flash[:error] = 'There was a problem adding your payment. Have you updated your NRIC?'
      
    elsif amount.to_d > balance
      flash[:error] = 'There are insufficient funds in the expenditure account'
    else
      p 'Hellos!!'
      test = Payment.create(payment_params).valid?
      if !test
        flash[:error] = 'There was a problem adding your payment. Have you attached a supporting document?'
       
      end
    end
  
    redirect_to :action => 'viewpayment'
  end

  def payment_params
    params.require(:payment).permit!
  end

  def edit
    c = Payment.find_by_id(params[:payment][:id])
    c.update_attributes(payment_params)
    redirect_to :action => 'clubpayments'
  end
  
  def editown
    c = Payment.find_by_id(params[:payment][:id])
    c.update_attributes(payment_params)
    redirect_to :action => 'viewpayment'
  end

  def submitpayment
    c = Payment.find_by_id(params[:id])
    newstatus = c.status + 1
    # PaymentTime.create(paymentid: c.id, status: newstatus, date: Date.today)
    c.update_attribute(:status, newstatus)
    # redirect_to :action => 'viewpayment'
    redirect_to :controller => 'vendors', :action => 'newfromsubmit', :id => params[:id]
  end
  
  def completepayment
    c = Payment.find_by_id(params[:id])
    newstatus = c.status + 1
    # PaymentTime.create(paymentid: c.id, status: newstatus,date: Date.today)
    c.update_attribute(:status, newstatus)
    # redirect_to :action => 'viewpayment'
    club = c.clubid
    amount = c.amount
    account = ExpenditureAccount.find_by_clubid(club)
    balance = account.Category1Balance
    balance -= amount
    account.update_attribute(:Category1Balance, balance)
    redirect_to :back
  end

  def resubmitpayment
    c = Payment.find_by_id(params[:id])
    if c.status == 12
    newstatus = c.status + 2
    else
    newstatus = c.status + 2
    end

    c.update_attribute(:status, newstatus)
    c.update_attribute(:remark, nil)
    # redirect_to :action => 'viewpayment'
    redirect_to :back
  end

  def confirmrejectpayment
    c = Payment.find_by_id(params[:payment][:id])

    c.update_attribute(:remark, params[:payment][:remark])
    c.update_attribute(:status, params[:payment][:status])
    c.update_attribute(:approvedby, nil)   
    redirect_to :action => 'clubpayments'
  end

  def endorseclub
    require 'prawn'
    payment = Payment.find_by_id(params[:id])
    payment.update_attribute(:status, 4)
    # PaymentTime.create(paymentid: payment.id, status: 4,date: Date.today)
    paymentV = User.find_by_userid(payment.userid)
    fullname = payment.vendorpayeename
    contact = payment.vendorcontact
    nric = payment.nric
    address = payment.address
    eventname = payment.event
    item = payment.item
    if eventname.nil?
      eventname = '#'+payment.id.to_s+'PM#'
    else
      eventname = eventname+'#'+payment.id.to_s+'PM#'
    end
    eventname = item + ', ' + eventname if !item.nil?
    amount = payment.amount
    category = payment.category
    expense = payment.expense
    clubfinsec = Club.find_by_clubid(payment.clubid).finsecid
    if !clubfinsec.nil?
      clubfinsec = User.find_by_userid(clubfinsec).fullname
    end
    clubcode = Club.find_by_clubid(payment.clubid).clubcode
    
    clubpres = Club.find_by_clubid(payment.clubid).presidentid
    if !clubpres.nil?
      clubpres = User.find_by_userid(clubpres).fullname
    end
    cbdfinsec = current_user.userid
    if !cbdfinsec.nil?
      cbdfinsec = User.find_by_userid(cbdfinsec).fullname
    end
    paymentid = payment.id
    clubname = Club.find_by_clubid(payment.clubid).clubname
    cbdname = session[:club]
    approvedby = payment.approvedby
    if approvedby.nil?
      approvedby = "No OSL staff approval needed"
    end
    approved2 = approvedby.split(',')
    sectors = approved2.size
    date = Date.today
    Prawn::Document.generate("public/toprint.pdf",
                             :page_size => "EXECUTIVE",
                             :page_layout => :landscape) do
      define_grid(:columns => 8, :rows => 8, :gutter => 10)
      # header
      bounding_box [bounds.left - 40, bounds.top + 40], :width  => bounds.width + 80 do
        cell :background_color => 'EEEEEE',
             :width => bounds.width,
             :height => 60,
             :align => :center,
             :text_color => "EEEEEE",
             :borders => [:bottom],
             :border_width => 2,
             :border_color => "rgb(1, 99, 172)",
             :padding => 12
        move_down 10
        image "#{Rails.root}/app/assets/images/smusa-new-logo.png", :at => [35, cursor], :width => 90
      end
      grid([0,0],[1,4]).bounding_box do
        move_down 30
        #Body
        #Applicant Data
        data = [
                  ["<b>Payment ID</b>"," : "+paymentid.to_s+"PM","<b>Date</b>"," : "+date.to_s],
                  ['<b>Club Code</b>'," : "+clubcode.to_s," "," "],
                  ['<b>Payee Name</b>'," : "+fullname.to_s,'<b>Contact Number</b>'," : "+contact.to_s],
                  ['<b>Vendor Mailing Address</b>'," : "+address.to_s," "," "]
                ]
        table(data, :cell_style => { :border_color => "FFFFFF", :padding => 2, :size=>10, :inline_format => true})
      end
      grid([1,5],[1,7]).bounding_box do
        pvsNo = [
                  ["<b>PVS No.</b>"," : _________________________"],
                  ['<b>Date</b>'," : _________________________"]
                ]
        table(pvsNo, :cell_style => { :border_color => "FFFFFF", :padding => 2, :size=>10, :inline_format => true})
      end
      grid([2,0],[7,4]).bounding_box do
        #Application Details
        details = [
                    ["<b>Event Name</b>","<b>Amount</b>","<b>Category</b>","<b>Expense</b>"],
                    [eventname.to_s, "$ "+amount.to_s, category.to_s, expense.to_s]
                  ]
        table(details, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 6, :size=>10, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
        move_down 30
        #Approval Details
        approval = [
                    ["<b>Prepared and verified by</b>","<b>Certified by</b>","<b>Endorsed/Approved by</b>"],
                    [clubfinsec.to_s, clubpres.to_s,cbdfinsec.to_s],
                    [clubname.to_s+", Club Finance Secretary",clubname.to_s+", Club President", cbdname.to_s+", CBd Finance Secretary"]
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
      end
      grid([2,5],[7,7]).bounding_box do
        #Payment Approval
        paymentapprove = [
                            [{:content=>"<b>Payment Approval for Official Use</b>", :colspan=>3}],
                            
                            ["<b>Cost Center</b>", {:content=>"C110 ", :colspan=>2}],
                            ["<b>Amount Code</b>","<b>Amount (S$)</b>","<b>GST (S$)</b>"],
                            ["1800020", " ", " "],
                            [" ", " ", " "],
                            [" ", " ", " "],
                            [" ", " ", " "],
                            [" ", " ", " "],
                            ["<b>Total Amount Payable</b>", {:content=>" ", :colspan=>2}],
                           
                            ["<b>Document No.</b>", {:content=>" ", :colspan=>2}],
                            ["<b>Posting Date</b>", {:content=>" ", :colspan=>2}],
                            ["<b>Cheque No.</b>", {:content=>" ", :colspan=>2}]
                         ]
        table(paymentapprove, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 5, :size=>8, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF", "FFFFFF","FFFFFF", "EEEEEE", "FFFFFF", "FFFFFF","FFFFFF", "FFFFFF", "FFFFFF", "C8C8C8 ", "C8C8C8", "C8C8C8", "C8C8C8", "C8C8C8"])
      end  
      #Footer
      bounding_box [bounds.left-40, bounds.bottom], :width  => bounds.width+80 do
        cell :content => "Generated Report using the SMUSA Accounting Information System.\nThis is electronically approved. No physical signature is required.",
             :background_color => 'EEEEEE',
             :width => bounds.width,
             :height => 160,
             :align => :center,
             :text_color => "#202020",
             :borders => [:top],
             :border_width => 2,
             :border_color => "rgb(1, 99, 172)",
             :padding => 4
      end
    end
    # Prawn::Document.generate("public/toprint.pdf") do
      # # header
      # bounding_box [bounds.left - 40, bounds.top + 40], :width  => bounds.width + 80 do
        # cell :background_color => 'EEEEEE',
             # :width => bounds.width,
             # :height => 100,
             # :align => :center,
             # :text_color => "EEEEEE",
             # :borders => [:bottom],
             # :border_width => 2,
             # :border_color => "rgb(1, 99, 172)",
             # :padding => 12
        # move_down 20
        # image "#{Rails.root}/app/assets/images/smusa-new-logo.png", :at => [35, cursor], :width => 150
      # end
      # move_down 90
      # #Body
      # #Applicant Data
      # data = [
                # ["<b>Payment ID</b>"," : "+paymentid.to_s],
                # ['<b>Club Code</b>'," : "+clubcode.to_s],
                # [" "," "],
                # ['<b>Payee Name</b>'," : "+fullname.to_s],
                # ['<b>Contact Number</b>'," : "+contact.to_s],
                # ['<b>NRIC</b>'," : "+nric.to_s],
                # [" "," "],
                # ["<b>Date</b>"," : "+date.to_s]
              # ]
      # table(data, :cell_style => { :border_color => "FFFFFF", :padding => 2, :size=>10, :inline_format => true})
      # move_down 20
      # #Application Details
      # details = [
                  # ["<b>Event Name</b>","<b>Amount</b>","<b>Category</b>","<b>Expense</b>"],
                  # [eventname.to_s, "$ "+amount.to_s, category.to_s, expense.to_s]
                # ]
      # table(details, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 8, :size=>10, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
      # move_down 30
      # #Approval Details
      # approval = [
                  # ["<b>Prepared and verified by</b>","<b>Certified by</b>","<b>Endorsed/Approved by</b>"],
                  # [clubfinsec.to_s, clubpres.to_s,cbdfinsec.to_s],
                  # [clubname.to_s+", Club Finance Secretary",clubname.to_s+", Club President", cbdname.to_s+", CBd Finance Secretary"]
                # ]
      # table(approval, :width => bounds.width, :cell_style => { :border_color => "FFFFFF", :padding => 10, :inline_format => true})
      # move_down 50
      # #Payment Approval
      # paymentapprove = [
                          # [{:content=>"<b>Payment Approval for Official Use</b>", :colspan=>3}],
                          # ["<b>Purchase Order</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>SAP Vendor No.</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Cost Center</b>", {:content=>"C110 ", :colspan=>2}],
                          # ["<b>Amount Code</b>","<b>Amount (S$)</b>","<b>GST (S$)</b>"],
                          # ["1800020", " ", " "],
                          # [" ", " ", " "],
                          # [" ", " ", " "],
                          # [" ", " ", " "],
                          # [" ", " ", " "],
                          # ["<b>Total Amount Payable</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Approval</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Document No.</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Posting Date</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Cheque No.</b>", {:content=>" ", :colspan=>2}]
                       # ]
      # table(paymentapprove, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 6, :size=>10, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF", "FFFFFF","FFFFFF", "EEEEEE", "FFFFFF", "FFFFFF","FFFFFF", "FFFFFF", "FFFFFF", "C8C8C8 ", "C8C8C8", "C8C8C8", "C8C8C8", "C8C8C8"])
#       
      # #Footer
      # bounding_box [bounds.left-40, bounds.bottom], :width  => bounds.width+80 do
        # cell :content => 'Generated Report using the SMUSA Accounting Information System',
             # :background_color => 'EEEEEE',
             # :width => bounds.width,
             # :height => 40,
             # :align => :center,
             # :text_color => "#202020",
             # :borders => [:top],
             # :border_width => 2,
             # :border_color => "rgb(1, 99, 172)",
             # :padding => 12
      # end
    # end
    redirect_to '/toprint.pdf'
  end

  def endorsecbdmc
    require 'prawn'
    payment = Payment.find_by_id(params[:id])
    payment.update_attribute(:status, 10)
    # PaymentTime.create(paymentid: payment.id, status: 10,date: Date.today)
    paymentV = User.find_by_userid(payment.userid)
    fullname = payment.vendorpayeename
    contact = payment.vendorcontact
    nric = payment.nric
    address = payment.address
    eventname = payment.event
    item = payment.item
    if eventname.nil?
      eventname = '#'+payment.id.to_s+'PM#'
    else
      eventname = eventname+'#'+payment.id.to_s+'PM#'
    end
    eventname = item + ', ' + eventname if !item.nil?
    amount = payment.amount
    category = payment.category
    expense = payment.expense
    cbdfinsec = Club.find_by_clubid(payment.clubid).finsecid
    if !cbdfinsec.nil?
      cbdfinsec = User.find_by_userid(cbdfinsec).fullname
    end
    clubcode = Club.find_by_clubid(payment.clubid).clubcode
    cbdpres = Club.find_by_clubid(payment.clubid).presidentid
    if !cbdpres.nil?
      cbdpres = User.find_by_userid(cbdpres).fullname
    end
    smusafinsec = current_user.userid
    if !smusafinsec.nil?
      smusafinsec = User.find_by_userid(smusafinsec).fullname
    end
    paymentid = payment.id
    clubname = Club.find_by_clubid(payment.clubid).clubname
    approvedby = payment.approvedby
    if approvedby.nil?
      approvedby = "No OSL staff approval needed"
    end
    approved2 = approvedby.split(',')
    sectors = approved2.size
    cbdname = session[:club]
    date = Date.today
    Prawn::Document.generate("public/toprint.pdf",
                             :page_size => "EXECUTIVE",
                             :page_layout => :landscape) do
      define_grid(:columns => 8, :rows => 8, :gutter => 10)
      # header
      bounding_box [bounds.left - 40, bounds.top + 40], :width  => bounds.width + 80 do
        cell :background_color => 'EEEEEE',
             :width => bounds.width,
             :height => 60,
             :align => :center,
             :text_color => "EEEEEE",
             :borders => [:bottom],
             :border_width => 2,
             :border_color => "rgb(1, 99, 172)",
             :padding => 12
        move_down 10
        image "#{Rails.root}/app/assets/images/smusa-new-logo.png", :at => [35, cursor], :width => 90
      end
      grid([0,0],[1,4]).bounding_box do
        move_down 30
        #Body
        #Applicant Data
        data = [
                  ["<b>Payment ID</b>"," : "+paymentid.to_s+"PM","<b>Date</b>"," : "+date.to_s],
                  ['<b>Club Code</b>'," : "+clubcode.to_s," "," "],
                  ['<b>Payee Name</b>'," : "+fullname.to_s,'<b>Contact Number</b>'," : "+contact.to_s],
                  ['<b>Vendor Mailing Address</b>'," : "+address.to_s," "," "]
                ]
        table(data, :cell_style => { :border_color => "FFFFFF", :padding => 2, :size=>10, :inline_format => true})
      end
      grid([1,5],[1,7]).bounding_box do
        pvsNo = [
                  ["<b>PVS No.</b>"," : _________________________"],
                  ['<b>Date</b>'," : _________________________"]
                ]
        table(pvsNo, :cell_style => { :border_color => "FFFFFF", :padding => 2, :size=>10, :inline_format => true})
      end
      grid([2,0],[7,4]).bounding_box do
        #Application Details
        details = [
                    ["<b>Event Name</b>","<b>Amount</b>","<b>Category</b>","<b>Expense</b>"],
                    [eventname.to_s, "$ "+amount.to_s, category.to_s, expense.to_s]
                  ]
        table(details, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 6, :size => 10,:inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
        move_down 30
        #Approval Details
        approval = [
                    ["<b>Prepared and verified by</b>","<b>Certified by</b>","<b>Endorsed/Approved by</b>"],
                    [cbdfinsec.to_s, cbdpres.to_s, smusafinsec.to_s],
                    [clubname.to_s+", CBd Finance Secretary",clubname.to_s+", CBd President", cbdname.to_s+", SMUSA Finance Secretary"]
                  ]
        table(approval, :width => bounds.width, :cell_style => { :border_color => "FFFFFF", :padding => 6, :size=>10,  :inline_format => true})
        if sectors != 1
          
          for i in 1..sectors/2
            
            newapprove = [
              ['<b>Approved by</b>'],[approved2[2*i-2].to_s+', '+approved2[2*i-1]]
            ]
            table(newapprove, :width => bounds.width, :cell_style => { :border_color => "FFFFFF", :padding => 6, :size=>10, :inline_format => true})
          end
        end
      end
      grid([2,5],[7,7]).bounding_box do
        #Payment Approval
        paymentapprove = [
                            [{:content=>"<b>Payment Approval for Official Use</b>", :colspan=>3}],
                            
                            ["<b>Cost Center</b>", {:content=>"C110 ", :colspan=>2}],
                            ["<b>Amount Code</b>","<b>Amount (S$)</b>","<b>GST (S$)</b>"],
                            ["1800020", " ", " "],
                            [" ", " ", " "],
                            [" ", " ", " "],
                            [" ", " ", " "],
                            [" ", " ", " "],
                            ["<b>Total Amount Payable</b>", {:content=>" ", :colspan=>2}],
                          
                            ["<b>Document No.</b>", {:content=>" ", :colspan=>2}],
                            ["<b>Posting Date</b>", {:content=>" ", :colspan=>2}],
                            ["<b>Cheque No.</b>", {:content=>" ", :colspan=>2}]
                         ]
        table(paymentapprove, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 5, :size=>8, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF", "FFFFFF","FFFFFF", "EEEEEE", "FFFFFF", "FFFFFF","FFFFFF", "FFFFFF", "FFFFFF", "C8C8C8 ", "C8C8C8", "C8C8C8", "C8C8C8", "C8C8C8"])
      end  
      #Footer
      bounding_box [bounds.left-40, bounds.bottom], :width  => bounds.width+80 do
        cell :content => "Generated Report using the SMUSA Accounting Information System.\nThis is electronically approved. No physical signature is required.",
             :background_color => 'EEEEEE',
             :width => bounds.width,
             :height => 160,
             :align => :center,
             :text_color => "#202020",
             :borders => [:top],
             :border_width => 2,
             :border_color => "rgb(1, 99, 172)",
             :padding => 4
      end
    end
    # Prawn::Document.generate("public/toprint.pdf") do
      # # header
      # bounding_box [bounds.left - 40, bounds.top + 40], :width  => bounds.width + 80 do
        # cell :background_color => 'EEEEEE',
             # :width => bounds.width,
             # :height => 100,
             # :align => :center,
             # :text_color => "EEEEEE",
             # :borders => [:bottom],
             # :border_width => 2,
             # :border_color => "rgb(1, 99, 172)",
             # :padding => 12
        # move_down 20
        # image "#{Rails.root}/app/assets/images/smusa-new-logo.png", :at => [35, cursor], :width => 150
      # end
      # move_down 90
      # #Body
      # #Applicant Data
      # data = [
                # ["<b>Payment ID</b>"," : "+paymentid.to_s],
                # ['<b>Club Code</b>'," : "+clubcode.to_s],
                # [" "," "],
                # ['<b>Payee Name</b>'," : "+fullname.to_s],
                # ['<b>Contact Number</b>'," : "+contact.to_s],
                # ['<b>NRIC</b>'," : "+nric.to_s],
                # [" "," "],
                # ["<b>Date</b>"," : "+date.to_s]
              # ]
      # table(data, :cell_style => { :border_color => "FFFFFF", :padding => 2, :size=>10, :inline_format => true})
      # move_down 20
      # #Application Details
      # details = [
                  # ["<b>Event Name</b>","<b>Amount</b>","<b>Category</b>","<b>Expense</b>"],
                  # [eventname.to_s, "$ "+amount.to_s, category.to_s, expense.to_s]
                # ]
      # table(details, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 8, :size => 10,:inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
      # move_down 30
      # #Approval Details
      # approval = [
                  # ["<b>Prepared and verified by</b>","<b>Certified by</b>","<b>Endorsed/Approved by</b>"],
                  # [cbdfinsec.to_s, cbdpres.to_s, smusafinsec.to_s],
                  # [clubname.to_s+", CBd Finance Secretary",clubname.to_s+", CBd President", cbdname.to_s+", SMUSA Finance Secretary"]
                # ]
      # table(approval, :width => bounds.width, :cell_style => { :border_color => "FFFFFF", :padding => 6, :size=>10,  :inline_format => true})
      # move_down 50
      # #Payment Approval
      # paymentapprove = [
                          # [{:content=>"<b>Payment Approval for Official Use</b>", :colspan=>3}],
                          # ["<b>Purchase Order</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>SAP Vendor No.</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Cost Center</b>", {:content=>"C110 ", :colspan=>2}],
                          # ["<b>Amount Code</b>","<b>Amount (S$)</b>","<b>GST (S$)</b>"],
                          # ["1800020", " ", " "],
                          # [" ", " ", " "],
                          # [" ", " ", " "],
                          # [" ", " ", " "],
                          # [" ", " ", " "],
                          # ["<b>Total Amount Payable</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Approval</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Document No.</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Posting Date</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Cheque No.</b>", {:content=>" ", :colspan=>2}]
                       # ]
      # table(paymentapprove, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 5, :size=>8, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF", "FFFFFF","FFFFFF", "EEEEEE", "FFFFFF", "FFFFFF","FFFFFF", "FFFFFF", "FFFFFF", "C8C8C8 ", "C8C8C8", "C8C8C8", "C8C8C8", "C8C8C8"])
#       
      # #Footer
      # bounding_box [bounds.left-40, bounds.bottom], :width  => bounds.width+80 do
        # cell :content => 'Generated Report using the SMUSA Accounting Information System',
             # :background_color => 'EEEEEE',
             # :width => bounds.width,
             # :height => 40,
             # :align => :center,
             # :text_color => "#202020",
             # :borders => [:top],
             # :border_width => 2,
             # :border_color => "rgb(1, 99, 172)",
             # :padding => 12
      # end
    # end
    redirect_to '/toprint.pdf'
  end

  def endorsesmusasec
    require 'prawn'
    payment = Payment.find_by_id(params[:id])
    payment.update_attribute(:status, 15)
    # PaymentTime.create(Paymentid: Payment.id, status: 15,date: Date.today)
    paymentV = User.find_by_userid(payment.userid)
    fullname = payment.vendorpayeename
    contact = payment.vendorcontact
    nric = payment.nric
    address = payment.address
    eventname = payment.event
    item = payment.item
    if eventname.nil?
      eventname = '#'+payment.id.to_s+'PM#'
    else
      eventname = eventname+'#'+payment.id.to_s+'PM#'
    end
    eventname = item + ', ' + eventname if !item.nil?
    amount = payment.amount
    category = payment.category
    expense = payment.expense
    smusasec = payment.userid
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
    clubcode = Club.find_by_clubid(payment.clubid).clubcode
    paymentid = payment.id
    clubname = Club.find_by_clubid(payment.clubid).clubname
    cbdname = session[:club]
    date = Date.today
    approvedby = payment.approvedby
    if approvedby.nil?
      approvedby = "No OSL staff approval needed"
    end
    approved2 = approvedby.split(',')
    sectors = approved2.size
    Prawn::Document.generate("public/toprint.pdf",
                             :page_size => "EXECUTIVE",
                             :page_layout => :landscape) do
      define_grid(:columns => 8, :rows => 8, :gutter => 10)
      # header
      bounding_box [bounds.left - 40, bounds.top + 40], :width  => bounds.width + 80 do
        cell :background_color => 'EEEEEE',
             :width => bounds.width,
             :height => 60,
             :align => :center,
             :text_color => "EEEEEE",
             :borders => [:bottom],
             :border_width => 2,
             :border_color => "rgb(1, 99, 172)",
             :padding => 12
        move_down 10
        image "#{Rails.root}/app/assets/images/smusa-new-logo.png", :at => [35, cursor], :width => 90
      end
      grid([0,0],[1,4]).bounding_box do
        move_down 30
        #Body
        #Applicant Data
        data = [
                  ["<b>Payment ID</b>"," : "+paymentid.to_s+"PM","<b>Date</b>"," : "+date.to_s],
                  ['<b>Club Code</b>'," : "+clubcode.to_s," "," "],
                  ['<b>Payee Name</b>'," : "+fullname.to_s,'<b>Contact Number</b>'," : "+contact.to_s],
                  ['<b>Vendor Mailing Address</b>'," : "+address.to_s," "," "]
                ]
        table(data, :cell_style => { :border_color => "FFFFFF", :padding => 2, :size=>10, :inline_format => true})
      end
      grid([1,5],[1,7]).bounding_box do
        pvsNo = [
                  ["<b>PVS No.</b>"," : _________________________"],
                  ['<b>Date</b>'," : _________________________"]
                ]
        table(pvsNo, :cell_style => { :border_color => "FFFFFF", :padding => 2, :size=>10, :inline_format => true})
      end
      grid([2,0],[7,4]).bounding_box do
        #Application Details
        details = [
                    ["<b>Event Name</b>","<b>Amount</b>","<b>Category</b>","<b>Expense</b>"],
                    [eventname.to_s, "$ "+amount.to_s, category.to_s, expense.to_s]
                  ]
        table(details, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 6, :size=>10, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
        #Approval Details
        approval = [
                    ["<b>Prepared and verified by</b>","<b>Certified by</b>","<b>Endorsed/Approved by</b>"],
                    [smusasec.to_s, smusapres.to_s, smusafinsec.to_s],
                    [clubname.to_s+", SMUSA Honourary Secretary",cbdname.to_s+", SMUSA President", cbdname.to_s+", SMUSA Finance Secretary"]
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
      end
      
      grid([2,5],[7,7]).bounding_box do
        #Payment Approval
        paymentapprove = [
                            [{:content=>"<b>Payment Approval for Official Use</b>", :colspan=>3}],
                            
                            ["<b>Cost Center</b>", {:content=>"C110 ", :colspan=>2}],
                            ["<b>Amount Code</b>","<b>Amount (S$)</b>","<b>GST (S$)</b>"],
                            ["1800020", " ", " "],
                            [" ", " ", " "],
                            [" ", " ", " "],
                            [" ", " ", " "],
                            [" ", " ", " "],
                            ["<b>Total Amount Payable</b>", {:content=>" ", :colspan=>2}],
                         
                            ["<b>Document No.</b>", {:content=>" ", :colspan=>2}],
                            ["<b>Posting Date</b>", {:content=>" ", :colspan=>2}],
                            ["<b>Cheque No.</b>", {:content=>" ", :colspan=>2}]
                         ]
        table(paymentapprove, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 5, :size=>8, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF", "FFFFFF","FFFFFF", "EEEEEE", "FFFFFF", "FFFFFF","FFFFFF", "FFFFFF", "FFFFFF", "C8C8C8 ", "C8C8C8", "C8C8C8", "C8C8C8", "C8C8C8"])
      end
      #Footer
      bounding_box [bounds.left-40, bounds.bottom], :width  => bounds.width+80 do
        cell :content => "Generated Report using the SMUSA Accounting Information System.\nThis is electronically approved. No physical signature is required.",
             :background_color => 'EEEEEE',
             :width => bounds.width,
             :height => 160,
             :align => :center,
             :text_color => "#202020",
             :borders => [:top],
             :border_width => 2,
             :border_color => "rgb(1, 99, 172)",
             :padding => 4
      end
    end
    # Prawn::Document.generate("public/toprint.pdf") do
      # # header
      # bounding_box [bounds.left - 40, bounds.top + 40], :width  => bounds.width + 80 do
        # cell :background_color => 'EEEEEE',
             # :width => bounds.width,
             # :height => 100,
             # :align => :center,
             # :text_color => "EEEEEE",
             # :borders => [:bottom],
             # :border_width => 2,
             # :border_color => "rgb(1, 99, 172)",
             # :padding => 12
        # move_down 20
        # image "#{Rails.root}/app/assets/images/smusa-new-logo.png", :at => [35, cursor], :width => 150
      # end
      # move_down 90
      # #Body
      # #Applicant Data
      # data = [
                # ["<b>Payment ID</b>"," : "+paymentid.to_s],
                # ['<b>Club Code</b>'," : "+clubcode.to_s],
                # ['<b>Payee Name</b>'," : "+fullname.to_s],
                # ['<b>Contact Number</b>'," : "+contact.to_s],
                # ['<b>NRIC</b>'," : "+nric.to_s],
                # ["<b>Date</b>"," : "+date.to_s]
              # ]
      # table(data, :cell_style => { :border_color => "FFFFFF", :padding => 2, :size=>10, :inline_format => true})
      # move_down 20
      # #Application Details
      # details = [
                  # ["<b>Event Name</b>","<b>Amount</b>","<b>Category</b>","<b>Expense</b>"],
                  # [eventname.to_s, "$ "+amount.to_s, category.to_s, expense.to_s]
                # ]
      # table(details, :width => bounds.width, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 8, :size=>10, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF"])
      # move_down 30
      # #Approval Details
      # approval = [
                  # ["<b>Prepared and verified by</b>","<b>Certified by</b>","<b>Endorsed/Approved by</b>"],
                  # [smusasec.to_s, smusapres.to_s, smusafinsec.to_s],
                  # [clubname.to_s+", SMUSA Honourary Secretary",cbdname.to_s+", SMUSA President", cbdname.to_s+", SMUSA Finance Secretary"]
                # ]
      # table(approval, :width => bounds.width, :cell_style => { :border_color => "FFFFFF", :padding => 6, :size=>10, :inline_format => true})
      # move_down 50
      # #Payment Approval
      # paymentapprove = [
                          # [{:content=>"<b>Payment Approval for Official Use</b>", :colspan=>3}],
                          # ["<b>Purchase Order</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>SAP Vendor No.</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Cost Center</b>", {:content=>"C110 ", :colspan=>2}],
                          # ["<b>Amount Code</b>","<b>Amount (S$)</b>","<b>GST (S$)</b>"],
                          # ["1800020", " ", " "],
                          # [" ", " ", " "],
                          # [" ", " ", " "],
                          # [" ", " ", " "],
                          # [" ", " ", " "],
                          # ["<b>Total Amount Payable</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Approval</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Document No.</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Posting Date</b>", {:content=>" ", :colspan=>2}],
                          # ["<b>Cheque No.</b>", {:content=>" ", :colspan=>2}]
                       # ]
      # table(paymentapprove, :cell_style => { :border_color => "rgb(1, 99, 172)", :padding => 5, :size=>8, :inline_format => true}, :row_colors => ["EEEEEE", "FFFFFF", "FFFFFF","FFFFFF", "EEEEEE", "FFFFFF", "FFFFFF","FFFFFF", "FFFFFF", "FFFFFF", "C8C8C8 ", "C8C8C8", "C8C8C8", "C8C8C8", "C8C8C8"])
#       
      # #Footer
      # bounding_box [bounds.left-40, bounds.bottom], :width  => bounds.width+80 do
        # cell :content => 'Generated Report using the SMUSA Accounting Information System',
             # :background_color => 'EEEEEE',
             # :width => bounds.width,
             # :height => 40,
             # :align => :center,
             # :text_color => "#202020",
             # :borders => [:top],
             # :border_width => 2,
             # :border_color => "rgb(1, 99, 172)",
             # :padding => 12
      # end
    # end
    redirect_to '/toprint.pdf'
  end
  
  def submitosl
    c = Payment.find_by_id(params[:id])
    status = c.status
    if status == 3
      newstatus = 17
      c.update_attribute(:claimtype, 'club')
    elsif status == 9
      newstatus = 26
      c.update_attribute(:claimtype, 'cbd')
    elsif status == 14
      newstatus = 26
      c.update_attribute(:claimtype, 'smusasec')
    end

    c.update_attribute(:status, newstatus)
    # redirect_to :action => 'viewpayment'
    redirect_to :back
  end
  
  
  def oslprocess
    c = Payment.find_by_id(params[:id])
    amount = c.amount
    status = c.status
    if status == 17
      c.update_attribute(:claimtype, 'club')
    elsif status == 20
      c.update_attribute(:claimtype, 'cbd')
    elsif status == 23
      c.update_attribute(:claimtype, 'smusasec')
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
        c.update_attribute(:status, hash2[c.claimtype])
      else
        c.update_attribute(:status, 27)
      end
    elsif status == 27
       if amount <= 10000
        c.update_attribute(:status, hash2[c.claimtype])
      else
        c.update_attribute(:status, 28)
      end
    elsif status == 28
       c.update_attribute(:status, hash2[c.claimtype])
    end
    redirect_to :back
  end

end
