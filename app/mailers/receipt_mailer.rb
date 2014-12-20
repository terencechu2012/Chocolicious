class ReceiptMailer < ActionMailer::Base
  default from: "terence.chu.2012@sis.smu.edu.sg"
  
  def send_email(ereceipt)
    @ereceipt = ereceipt
    mail(to: @ereceipt.payeemail, subject: 'Your e-receipt')
  end
end
