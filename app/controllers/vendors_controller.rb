class VendorsController < ApplicationController
  def new

    @new_vendor = Vendor.new
  end

  def edit
    @new_vendor = Vendor.new
    @vendors = Vendor.all
  end

  def add 
    companyname = params[:vendor][:name]
    v = Vendor.find_by_name(companyname)
    
    if !v.nil?
      flash[:error] = "This vendor has been previously entered. Please go to 'Add rating for existing vendor' instead."
      redirect_to :controller => 'admin', :action => 'home'
    else
      Vendor.create(vendor_params).valid?
      redirect_to :controller => 'admin', :action => 'home'
      flash[:success] = 'Vendor successfully added'
    end

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
    flash[:success] = 'Vendor review successfully added'

  end

  def vendor_params
    params.require(:vendor).permit!
  end

  def recommend

  end

  def recommend2
    creditlimit = params[:creditlimit]
    category = params[:category]
    @result = Vendor.find_by_sql(['select * from vendors where creditlimit =? and category = ? order by price * ? + quality*?+punctuality*?+customerservice*?+overall*? desc', creditlimit, category, params[:price], params[:quality], params[:punctuality],params[:customerservice],params[:overall]])
    @number = params[:results].to_i
  end
  
  def newfromsubmit
    id = params[:id]
    p = Payment.find_by_id(id)
    vendorname = p.vendorpayeename
    vendor = Vendor.find_by_name(vendorname)
    if vendor.nil?
      @type = 'new'
      @new_vendor = Vendor.new
      @name = vendorname
      @contact = p.vendorcontact
      @address = p.address
    else
      @type = 'existing'
      @new_vendor = Vendor.new
      @id = vendor.id
    end
  end
end
