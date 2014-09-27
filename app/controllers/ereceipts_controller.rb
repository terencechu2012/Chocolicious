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
     @receipt = Ereceipt.all
  end
  
  def ereceipt_params
    params.require(:ereceipt).permit!
  end
  
end
