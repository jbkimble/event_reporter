require './lib/cleaner'

class Attendee
  include Cleaner

  attr_writer :first_name, :last_name, :email_address, :home_phone, :street, :city, :state, :zipcode, :district
  attr_reader :first_name, :last_name, :email_address, :home_phone, :street, :city, :state, :zipcode, :district

  def initialize(row)
    @first_name = Cleaner.clean_name(row[:first_name])
    @last_name = Cleaner.clean_name(row[:last_name])
    @email_address = row[:email_address]
    @home_phone = Cleaner.clean_phone_number(row[:homephone])
    @street = row[:street]
#
    @city = Cleaner.clean_name(row[:city])

    if row[:state] == nil
      @state = ""
    else
      @state = row[:state]
    end
    
    @zipcode = Cleaner.clean_zipcode(row[:zipcode])
    @district = ""
  end
end
