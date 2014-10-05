class VendorsController < ApplicationController
  def new
    
    @new_vendor = Vendor.new
  end
  
  def edit
    @new_vendor = Vendor.new
    @vendors = Vendor.all
  end
  def add
    Vendor.create(vendor_params)
    redirect_to :controller => 'admin', :action => 'home'
    flash.alert = 'Vendor successfully added'
  end
  
  def edit2
    v = Vendor.find_by_id(params[:vendor][:id])
    reviewers = v.reviewers
    price = (v.price * reviewers + params[:vendor][:price].to_d)/(reviewers+1)
    quality = (v.quality * reviewers + params[:vendor][:quality].to_d)/(reviewers+1)
    punctuality = (v.punctuality * reviewers + params[:vendor][:punctuality].to_d)/(reviewers+1)
    customerservice = (v.customerservice * reviewers + params[:vendor][:customerservice].to_d)/(reviewers+1)
    overall = (v.overall * reviewers + params[:vendor][:overall].to_d)/(reviewers+1)
    v.update_attributes(:price=>price, :quality=>quality, :punctuality=>punctuality, :customerservice=>customerservice,:overall=>overall, :reviewers=>reviewers+1)
    redirect_to :controller => 'admin', :action => 'home'
    flash.alert = 'Vendor successfully added'
  end
  def vendor_params
    params.require(:vendor).permit!
  end
  def recommend
   
  end
  def recommend2
    category = params[:category]
    @result = Vendor.find_by_sql(['select * from vendors where category = ? order by price * ? + quality*?+punctuality*?+customerservice*?+overall*? desc', category, params[:price], params[:quality], params[:punctuality],params[:customerservice],params[:overall]])
    @number = params[:results].to_i
  end
end
