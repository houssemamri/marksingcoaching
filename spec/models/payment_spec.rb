require 'rails_helper'

RSpec.describe Payment do
  it 'should downcase email before save' do
    payment = Payment.new(email: 'CAP@gmail.com')
    payment.save!
    expect(payment.email).to eq 'cap@gmail.com'
  end
end
