class ReceiptMailer < ActionMailer::Base
  default from: "smuais2012@gmail.com"
  
  def send_email(ereceipt)
    @ereceipt = ereceipt
    mail(to: @ereceipt.payeemail, subject: 'Your e-receipt')
  end
end
