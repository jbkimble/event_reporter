require './lib/cleaner'

class Attendee
  include Cleaner

  attr_reader :first_name, :last_name, :email_address, :home_phone, :street, :city, :state, :zipcode
  def initialize(row)
    @first_name = Cleaner.clean_name(row[:first_name])
    @last_name = Cleaner.clean_name(row[:last_name])
    @email_address = row[:email_address]
    @home_phone = Cleaner.clean_phone_number(row[:homephone])
    @street = row[:street]
    @city = row[:city]
    @state = row[:state]
    @zipcode = Cleaner.clean_zipcode(row[:zipcode])
  end
end
