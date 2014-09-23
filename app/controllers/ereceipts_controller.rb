class EreceiptsController < ApplicationController
  def newreceipt
    @newreceipt = Ereceipt.new
  end
  
  def add
    Ereceipt.create(ereceipt_params)
    
    if params[:ereceipt][:payeename].nil? 
      flash[:error] = "There was a problem adding your claim. Have you updated your NRIC?"
    else 
      flash[:success] = "Receipt is recorded. An email is sent to receipient's email address."
      redirect_to :back
    end
    
  end
  
  def viewsentreceipt
     @receipt = Ereceipt.all
  end
  
  def ereceipt_params
    params.require(:ereceipt).permit!
  end
  
end
