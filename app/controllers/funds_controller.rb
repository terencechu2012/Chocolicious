class FundsController < ApplicationController
  def newrequest
    @new_request = FundsTransfer.new
    @allClubs = Club.where.not(clubid:"smusa")
  end

  def add
    balance = ExpenditureAccount.find_by_clubid(params[:funds_transfer][:clubidfrom]).Category1Balance
    amount = params[:funds_transfer][:amount].to_d
    if balance < amount
      flash.alert = 'There are insufficient funds in the expenditure account!'
    else
      if params[:cName] == ""
        flash[:error] = "Please select a club!"
      else
        FundsTransfer.create(:userid => session[:userid], :clubidfrom => session[:club], :clubidto => params[:cName], :amount => params[:funds_transfer][:amount], :status => params[:funds_transfer][:status], :purpose => params[:funds_transfer][:purpose])
      end
    end

    redirect_to :action => 'viewrequest'
  end

  def viewrequest
    role = session[:role]
    if (role.include? 'clubfinsec') || (role.include? 'cbdfinsec') || (role.include? 'smusasec')
      @fundsrequests = FundsTransfer.where(clubidfrom:session[:club])
    end

    @fundsrequnderall = FundsTransfer.all
  end

  def editrequest
    @fundsrequest = FundsTransfer.find_by_id(params[:id])
    @own = params[:own]
  end

  def edit
    r = FundsTransfer.find_by_id(params[:funds_transfer][:id])
    r.update_attributes(funds_params)
    redirect_to :action => 'viewrequest'
  end

  def submitrequest
    statuschange = 4
    c = FundsTransfer.find_by_id(params[:id])
    newstatus = c.status + statuschange

    c.update_attribute(:status, newstatus)
    redirect_to :back
  end

  def deleterequest
    c = FundsTransfer.find_by_id(params[:id])
    c.delete
    redirect_to :back
  end

  def approverequest
    r = FundsTransfer.find_by_id(params[:id])
    ramount = r.amount
    clubfrom = r.clubidfrom
    status = r.status

    eFrom = ExpenditureAccount.find_by_clubid(clubfrom)

    if eFrom.Category1Balance > ramount
      newstatus = status + 1
      r.update_attribute(:status, newstatus)

      minus = eFrom.Category1Balance - ramount
      eFrom.update_attribute(:Category1Balance, minus)

      clubto = r.clubidto
      if clubto != 'external'
        eTo = ExpenditureAccount.find_by_clubid(clubto)
        plus1 = eTo.Category1Balance + ramount
        eTo.update_attribute(:Category1Balance, plus1)
        plus2 = eTo.Category2Balance + ramount
        eTo.update_attribute(:Category2Balance, plus2)
      end
    else
    
    #prompt insufficient error message
    balanceStr = eFrom.Category1balance.to_s
    flash[:error] = 'You have insufficient funds. Your balance is ' + balanceStr +'. '

    end
    redirect_to :action => 'viewrequest', :id => r.id
  end

  def addremark
    @rejecttransfer = FundsTransfer.find_by_id(params[:id])
    @status = params[:status]
  end

  def confirmreject
    c = FundsTransfer.find_by_id(params[:funds_transfer][:id])
    c.update_attribute(:remarks, params[:funds_transfer][:remarks])
    c.update_attribute(:status, params[:funds_transfer][:status])
    redirect_to :action => 'viewrequest'
  end

  def resubmitrequest
    c = FundsTransfer.find_by_id(params[:id])

    c.update_attribute(:status, 4)
    c.update_attribute(:remarks, nil)
    
    redirect_to :back
  end

  def funds_params
    params.require(:funds_transfer).permit!
  end

end
