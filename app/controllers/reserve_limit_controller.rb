class ReserveLimitController < ApplicationController 
  def viewreservelimit
    @new_request = ReserveLimit.new
    clubid = session[:club]
    r = ReserveLimit.find_by_clubid(clubid)
    p clubid
    p r
    if r.nil?
      @test = true
    else
      @ReserveRequest = r
    end
  end
  
  
  def addReserve
    ReserveLimit.create(reservelimit_params)  
    redirect_to :back
  end
  
  def reservelimit_params
    params.require(:reserve_limit).permit!
  end
  
  def viewallreservelimitchangerequest
     if session[:role].include? 'smusafinsec'
      @ReserveRequest = ReserveLimit.all
      end
  end
  
  def accept
    r = ReserveLimit.find_by_clubid(params[:clubid])
    amt = r.amount  

    x = ReserveAccount.find_by_clubid(params[:clubid])
    x.update_attribute(:limit, amt)
    r.delete
    redirect_to :back
   
  end
  
  def reject
    r = ReserveLimit.find_by_clubid(params[:clubid])
    r.delete
    redirect_to :back
    
  end
  
end
