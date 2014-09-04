class ReserveWithdrawalsController < ApplicationController
  def newrequest
    @new_request = ReserveWithdrawal.new
  end

  def viewrequest
    role = session[:role]
    if (role.include? 'clubfinsec') || (role.include? 'cbdfinsec')
      @withdrawrequests = ReserveWithdrawal.where(clubid:session[:club])
    elsif role.include? 'president'
      r1 = ReserveWithdrawal.where(clubid:session[:club], status: 2..5)
      r2 = ReserveWithdrawal.where(clubid:session[:club], status: 8..10)
      @withdrawrequests = r1 + r2
    end
    
    @withdrawrequndercbd = ReserveWithdrawal.where(['clubid in (select clubid from clubs where clubtype = ?) and status > 2 and status < 6', session[:club]])
    r3 = ReserveWithdrawal.where(status: 4..5)
    @withdrawrequnderall = ReserveWithdrawal.where(status: 9..10) + r3
  end

  def editrequest
    @withdrawalrequest = ReserveWithdrawal.find_by_id(params[:id])
    @own = params[:own]
  end

  def edit
    r = ReserveWithdrawal.find_by_id(params[:reserve_withdrawal][:id])
    r.update_attributes(withdrawal_params)
    redirect_to :action => 'viewrequest'
  end

  def deleterequest
    c = ReserveWithdrawal.find_by_id(params[:id])
    c.delete
    redirect_to :back
  end

  def add
    balance = ReserveAccount.find_by_clubid(params[:reserve_withdrawal][:clubid]).balance
    amount = params[:reserve_withdrawal][:amount].to_d
    if balance < amount
      flash.alert = 'There are insufficient funds in the reserve account!'
    else
      ReserveWithdrawal.create(withdrawal_params)
    end
    
    redirect_to :action => 'viewrequest'
  end

  def withdrawal_params
    params.require(:reserve_withdrawal).permit!
  end

  def addremark
    @rejectwithdrawal = ReserveWithdrawal.find_by_id(params[:id])
    @status = params[:status]
  end

  def confirmreject
    c = ReserveWithdrawal.find_by_id(params[:reserve_withdrawal][:id])
    c.update_attribute(:remarks, params[:reserve_withdrawal][:remarks])
    c.update_attribute(:status, params[:reserve_withdrawal][:status])
    redirect_to :action => 'viewrequest'
  end

  def submitrequest
    statuschange = 1
    # if session[:role]=='cbdfinsec' ||session[:role]=='clubfinsec'
    # statuschange = 2
    # elsif session[:role]=='president'
    # statuschange = 5
    # elsif session[:role]=='smusafinsec'
    # statuschange = 2
    # end

    c = ReserveWithdrawal.find_by_id(params[:id])
    newstatus = c.status + statuschange

    c.update_attribute(:status, newstatus)
    # redirect_to :action => 'viewclaim'
    redirect_to :back
  end

  def resubmitrequest
    c = ReserveWithdrawal.find_by_id(params[:id])
    # if c.status == 12
    # newstatus = c.status + 1
    # else
    # newstatus = c.status + 2
    # end
    newstatus = c.status + 2

    c.update_attribute(:status, newstatus)
    c.update_attribute(:remarks, nil)
    # redirect_to :action => 'viewrequest'
    redirect_to :back
  end

  def addremark
    @rejectwithdrawal = ReserveWithdrawal.find_by_id(params[:id])
    @status = params[:status]
  end

  def approverequest
    r = ReserveWithdrawal.find_by_id(params[:id])
    ramount = r.amount
    rclubid = r.clubid
    status = r.status

    t = ReserveAccount.find_by_clubid(rclubid)

    e = ExpenditureAccount.find_by_clubid(rclubid)

    if t.balance > ramount 
      newstatus = status + 1

      r.update_attribute(:status, newstatus)
      minus = t.balance - ramount
      t.update_attribute(:balance, minus)
      plus1 = e.Category1Balance + ramount
      plus2 = e.Category2Balance + ramount
      e.update_attribute(:Category1Balance, plus1)
      e.update_attribute(:Category2Balance, plus2)
      
    else
      
    #prompt insufficient error message
      balanceStr = t.balance.to_s
      flash[:error] = 'You have insufficient funds. Your balance is ' + balanceStr +'. '
     
    end
  redirect_to :action => 'viewbalance', :id => rclubid
  end
  
  def viewbalance
    @withdrawalrequest = ReserveWithdrawal.where(clubid:params[:id])
    @totalwithdrawed=0.00
    t = ReserveAccount.find_by_clubid(params[:id])
    @balance = t.balance
    e = ExpenditureAccount.find_by_clubid(params[:id])
    @ex = e.Category1Balance

  end
  
end
