require './lib/event_reporter'
require './lib/attendee'
require 'minitest/autorun'
require 'minitest/pride'

class AttendeeTest < Minitest::Test
  def test_initialize_loads_instance_variables
    er = EventReporter.new
    a = Attendee.new({:first_name => "bob", :last_name => "Calzone", :email_address => "something@gmail.com",
      :homephone => "206-888-0000", :street => "some address 2222", :city => "Tampa Bay", :state => "FL", :zipcode => "00000", :district => ""})

    assert_equal "Bob", a.first_name
    assert_equal "Calzone", a.last_name
    assert_equal "something@gmail.com", a.email_address
    assert_equal "2068880000", a.home_phone
    assert_equal "some address 2222", a.street
  end

  def test_cleaner_cleans_attributes
    er = EventReporter.new
    a = Attendee.new({:first_name => "bob", :last_name => "calzone", :email_address => "something@gmail.com",
      :homephone => "206-888-0000", :street => "some address 2222", :city => "Tampa Bay", :state => nil, :zipcode => "00000", :district => ""})

    assert_equal "Calzone", a.last_name
    assert_equal "2068880000", a.home_phone
    assert_equal "some address 2222", a.street
    assert_equal "", a.state
  end

end
