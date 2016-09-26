require 'minitest/autorun'
require 'minitest/pride'
require './lib/queue'
require './lib/attendee'
require './lib/event_reporter'

class QueueTest < Minitest::Test
  def test_starts_as_blank_array
    q = Que.new

    assert_equal 0, q.final_queue.length
  end

  def test_final_queue_can_be_shoveled_into
    q = Que.new
    row = {first_name: "Jon", last_name: "kimble", homephone: "0000000000", zipcode: "00000"}
    att =  e.new(row)
    q << att

    assert_equal 1, q.final_queue.length
  end

  def test_count_t_can_count_number_of_items
    q = Que.new
    row = {first_name: "Jon", last_name: "kimble", homephone: "0000000000", zipcode: "00000"}
    att = Attendee.new(row)

    assert_equal 0, q.count

    q << att
    assert_equal 1, q.count
  end

  def test_clear_empties_the_array
    q = Que.new
    row = {first_name: "Jon", last_name: "kimble", homephone: "0000000000", zipcode: "00000"}
    att = Attendee.new(row)
    q << att

    assert_equal 1, q.count

    q.clear
    assert_equal 0, q.count
  end

  def test_save_to_csv_works
    er = EventReporter.new
    er.load_file
    er.finds_attribute_type("first_name", "Sarah")
    er.queue.save_to_csv("testing_testing.csv")

    assert_equal 78, er.queue.count
    er.load_file("testing_testing.csv")
    er.finds_attribute_type("first_name", "Sarah")

    assert_equal 156, er.queue.count
  end

  def test_export_to_html_works
    er = EventReporter.new
    er.load_file
    er.finds_attribute_type("first_name", "Sarah")
    er.queue.export_queue_to_html("testing_testing.html")
  end
end
