# Encoding: UTF-8
class UserMailer < ActionMailer::Base
  default from: "info@kipinform.ru"

  def order_confirmation(client, order, number)
  	@client = client
  	@order = order
  	@number = number
    mail(:to => "kazylyk@mail.ru, kip_k_s3@mail.ru, it@kip-k-s.ru", :subject => "Заказ #{number} от Kipinform.ru")
  end
end