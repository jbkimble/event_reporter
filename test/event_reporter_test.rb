require './lib/event_reporter'
require 'minitest/autorun'
require 'minitest/pride'

class EventReporterTest < Minitest::Test
  def test_event_reporter_class_exists
    tr = EventReporter.new

    assert_equal EventReporter, tr.class
  end

  def test_que_is_initialized
    tr = EventReporter.new

    assert_equal Que, tr.queue.class
  end

  def test_program_can_load_and_store_file
    tr = EventReporter.new

    assert_equal 0, tr.all_attendees.length
    tr.load_file
    assert_equal 5176, tr.all_attendees.length
  end

  def test_program_can_load_or_store_specific_file
    tr = EventReporter.new

    assert_equal 0, tr.all_attendees.length
    tr.load_file("short_event_attendees.csv")
    assert_equal 19, tr.all_attendees.length
  end

  def test_can_find_attribute_type
    tr = EventReporter.new
    tr.load_file

    assert_equal 0, tr.queue.count
    tr.finds_attribute_type("first_name", "Sarah")

    assert_equal 78, tr.queue.count
  end

  def test_clean_data_is_stored
  end

  def test_queue_is_cleared_for_each_search
    tr = EventReporter.new
    tr.load_file

    assert_equal 0, tr.queue.count

    tr.finds_attribute_type("first_name", "Frank")
    assert_equal 1, tr.queue.count

    tr.finds_attribute_type("last_name", "Smith")
    assert_equal 35, tr.queue.count
  end

  def test_can_find_by_first_names
    tr = EventReporter.new
    tr.load_file

    assert_equal 0, tr.queue.count

    tr.finds_attribute_type("first_name", "Sarah")
    assert_equal 78, tr.queue.count
  end

  def test_can_find_by_last_names
    tr = EventReporter.new
    tr.load_file

    tr.finds_attribute_type("last_name", "Smith")
    assert_equal 35, tr.queue.count
  end

  def test_can_find_by_home_phone
    tr = EventReporter.new
    tr.load_file

    tr.finds_attribute_type("home_phone", "7743130000")
    assert_equal 1, tr.queue.count
  end

  def test_can_find_by_email
    tr = EventReporter.new
    tr.load_file

    tr.finds_attribute_type("email_address", "ciy@jumpstartlab.com")
    assert_equal 1, tr.queue.count
  end

  def test_can_find_by_street
    tr = EventReporter.new
    tr.load_file

    tr.finds_attribute_type("street", "1203 made up address")
    assert_equal 0, tr.queue.count

    tr.finds_attribute_type("street", "286 Bragg rd")
    assert_equal 1, tr.queue.count
  end

  def test_can_find_by_city
    tr = EventReporter.new
    tr.load_file

    tr.finds_attribute_type("city", "Seattle")
    assert_equal 26, tr.queue.count
  end

  def test_can_find_by_state
    tr = EventReporter.new
    tr.load_file

    tr.finds_attribute_type("state", "CO")
    assert_equal 29, tr.queue.count
  end

  def test_can_find_by_zipcode
    tr = EventReporter.new
    tr.load_file

    tr.finds_attribute_type("zipcode", "43334")
    assert_equal 1, tr.queue.count
  end

  def test_can_add_attribute_type_to_queue
    tr = EventReporter.new
    tr.load_file

    tr.finds_attribute_type("first_name", "Frank")
    assert_equal 1, tr.queue.count

    tr.adds_attribute_type("first_name", "Mary")
    assert_equal 17, tr.queue.count
  end

  def test_can_add_attribute_type_to_queue
    tr = EventReporter.new
    tr.load_file

    tr.finds_attribute_type("state", "WA")
    assert_equal 50, tr.queue.count

    tr.adds_attribute_type("state", "CO")
    assert_equal 79, tr.queue.count
  end

  def test_can_add_multiple_additional_attribute_types
    tr = EventReporter.new
    tr.load_file

    tr.finds_attribute_type("state", "WA")
    assert_equal 50, tr.queue.count

    tr.adds_attribute_type("state", "CO")
    assert_equal 79, tr.queue.count

    tr.adds_attribute_type("first_name", "Mary")
    assert_equal 95, tr.queue.count

    tr.adds_attribute_type("zipcode", "00000")
    assert_equal 173, tr.queue.count
  end

  def test_can_subtract_attribute_types_from_queue
    tr = EventReporter.new
    tr.load_file

    tr.finds_attribute_type("state", "WA")
    assert_equal 50, tr.queue.count

    tr.subtract_attribute_type("first_name", "Paige")
    assert_equal 49, tr.queue.count
  end

  def test_can_subtract_multiple_attribute_types_from_queue
    tr = EventReporter.new
    tr.load_file

    tr.finds_attribute_type("state", "WA")
    assert_equal 50, tr.queue.count

    tr.subtract_attribute_type("first_name", "Paige")
    assert_equal 49, tr.queue.count

    tr.subtract_attribute_type("last_name", "Davis")
    assert_equal 48, tr.queue.count

    tr.subtract_attribute_type("city", "Seattle")
    assert_equal 24, tr.queue.count

    tr.subtract_attribute_type("home_phone", "3609046000")
    assert_equal 23, tr.queue.count

    tr.subtract_attribute_type("street", "1604 18th Ave")
    assert_equal 22, tr.queue.count

    tr.subtract_attribute_type("zipcode", "99362")
    assert_equal 7, tr.queue.count
  end

  def test_can_add_to_queue_and_still_ping_district
    er = EventReporter.new
    er.load_file

    er.finds_attribute_type("first_name", "Frank")
    assert_equal nil, er.queue.final_queue[0].district

    er.adds_attribute_type("last_name", "Hazlett")
    er.queue.queue_district

    assert_equal "2", er.queue.final_queue[2].district

  end
end
