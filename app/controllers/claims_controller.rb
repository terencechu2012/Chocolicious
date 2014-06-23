class ClaimsController < ApplicationController
  def newclaim
    @new_claim = Claim.new
  end

  def editclaim
    @claim = Claim.find_by_id(params[:id])
  end

  def viewclaim
    role = session[:role]
    if role == 'normal' || role == 'smusasec' || role == 'cbdmc'
      @normalclaims = Claim.where(userid:session[:userid], clubid:session[:club])
       
    elsif role == 'clubfinsec'
      @normalclaims = Claim.where(:clubid => session[:club], :status => 1..5)
      
    elsif role == 'cbdfinsec'
      @normalclaims = Claim.where(['clubid in (select clubid from clubs where clubtype = ?) and status > 2 and status < 6', session[:club]])
      @cbdmcclaims = Claim.where(clubid:session[:club], status: 7..11)
    elsif role == 'president'
      @normalclaims = Claim.where(clubid:session[:club], status: 2..5)
      @cbdmcclaims = Claim.where(clubid:session[:club], status: 8..11)
      @claims = @normalclaims + @cbdmcclaims
    elsif role == 'smusafinsec'
      @cbdmcclaims = Claim.where(status: 9..11)
      @smusasecclaims = Claim.where(status: 13..15)
    end
    
   
  end
  
  def add
    Claim.create(claim_params)
    redirect_to :controller => 'admin', :action => 'home'
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
 
end
