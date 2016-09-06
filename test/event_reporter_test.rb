gem 'minitest'
require './lib/event_reporter'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
#require './lib/runner'

class EventReporterTest < Minitest::Test
  def test_event_reporter_class_exists
    tr = EventReporter.new

    assert_equal EventReporter, tr.class
  end

  def test_csv_file_loads_correctly
    tr = EventReporter.new

    binding.pry
    assert_equal 19, tr.load_file.length
  end

  def test_it_cleans_names
    tr = EventReporter.new

    assert_equal "Mary", tr.clean_name("MArY")
    assert_equal "Mary", tr.clean_name(" maRy ")
  end

  def test_it_cleans_phone_numbers
    tr = EventReporter.new

    assert_equal "9820000000", tr.clean_phone_number("9.82E+00")
    assert_equal "6798638000", tr.clean_phone_number("(679)-863.8000")
  end

  def test_it_cleans_zipcodes
    tr = EventReporter.new

    assert_equal "02703", tr.clean_zipcode("2703")
    assert_equal "00924", tr.clean_zipcode("924")
    assert_equal "00000", tr.clean_zipcode("")
  end

  def test_it_can_find_a_name
    tr = EventReporter.new
    tr.load_file
    tr.finds_attribute_type("first_name", "shiyu ")

    assert_equal 1, tr.queue.count
  end

  #   assert_equal  clean_zipcode(zipcode)
  #   assert_equal  clean_zipcode(zipcode)
  #   assert_equalclean_phone_number(phonenumber)
  #   clean_phone_number(phonenumber)
  #   clean_phone_number(phonenumber)
  # end


  #
  # def test_program_can_take_user_input
  #
  #   assert_equal
  # end
  #
  # def test_user_command_is_split
  #   tr = EventReporter.new
  #
  #   assert_equal ["test", "this", "method"], tr.take_user_input
  # end

  # def test_program_can_load_and_store_file
  #   tr = EventReporter.new
  #   tr.load_file
  #
  #   assert load_file.contents != nil, tr.load_file
  # end
end
