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
    role = session[:role]
    if role == 'normal' || role == 'smusasec' || role == 'cbdmc'
      @normalclaims = Claim.where(userid:session[:userid], clubid:session[:club])
       
    elsif role == 'clubfinsec'
      if params[:status].nil? || params[:status] == 'all'
        @normalclaims = Claim.where(:clubid => session[:club], :status => 1..5)
      elsif params[:status]=='unsubmitted'
        @normalclaims = Claim.where(:clubid => session[:club], :status => 1, :remarks => nil)
      elsif params[:status]=='submitted'
        @normalclaims = Claim.where(:clubid => session[:club], :status => 2..5, :remarks => nil)
      elsif params[:status]=='rejected'
        @normalclaims = Claim.where(:clubid => session[:club], :status => 1).where.not(:remarks => nil)
        @hideremarks = true
      end
      
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
    
    test = Claim.create(claim_params).valid?
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
  
end
