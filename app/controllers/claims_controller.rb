class ClaimsController < ApplicationController
  def newclaim
    @new_claim = Claim.new
  end

  def editclaim
  end

  def viewclaim
    @claims = Claim.all
  end
  
  def add
    Claim.create(claim_params)
    redirect_to :controller => 'admin', :action => 'home'
  end
  def claim_params
    params.require(:claim).permit!
  end
end
