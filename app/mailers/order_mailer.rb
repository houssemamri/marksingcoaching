class OrderMailer < ApplicationMailer
  default from: 'marksingcoaching.io@gmail.com'

  def user_order_confirmation(user_email, order)
    @user_email = user_email
    @order = order
    mail(to: user_email, subject: 'You have a new order!')
  end

  def customer_order_confirmation(customer_email, order)
    @customer_email = customer_email
    @order = order
    mail(to: customer_email, subject: 'Thank you for your order!')
  end
end
