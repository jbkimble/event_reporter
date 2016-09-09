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

  def test_can_find_attribute_type
    tr = EventReporter.new
    tr.load_file

    assert_equal 0, tr.queue.count
    tr.finds_attribute_type("first_name", "Sarah")

    assert_equal 78, tr.queue.count
  end
end
