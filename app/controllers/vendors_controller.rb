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
    
    if companyname.nil?
      flash[:error] = "Please enter the vendor's name (company name)"
    else
      Vendor.create(vendor_params).valid?
      redirect_to :back
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
    redirect_to :back
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
end
