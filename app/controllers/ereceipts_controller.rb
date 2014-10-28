class EreceiptsController < ApplicationController
  def newreceipt
    @newreceipt = Ereceipt.new
  end
  
  def add
      @ereceipt = Ereceipt.create(ereceipt_params)
      ReceiptMailer.send_email(@ereceipt).deliver
      flash[:success] = "Receipt is recorded. An email is sent to receipient's email address."
      redirect_to :back
    
    
  end
  
  def viewsentreceipt
    role = session[:role]
    @receipt = []
    if (role.include? 'smusafinsec') || (role.include? 'osl')
      @receipt = Ereceipt.all
    elsif role.include? 'cbdfinsec'
      @receipt = Ereceipt.where(['clubid in (select clubid from clubs where clubtype = ?)', session[:club]])
      @receipt += Ereceipt.where(clubid: session[:club])
    else
      @receipt = Ereceipt.where(clubid: session[:club])
    end
     
  end
  
  def ereceipt_params
    params.require(:ereceipt).permit!
  end
  
end
