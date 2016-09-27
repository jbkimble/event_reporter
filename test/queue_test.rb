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
    att =  Attendee.new(row)
    q << att

    assert_equal 1, q.final_queue.length
  end

  def test_data_is_able_to_be_cleaned_and_stored_in_queue
    q = Que.new
    row = {first_name: "frank", last_name: "calzone", homephone: "123", zipcode: "", city: "Bellevue", state: nil, email_address: "123@gmail.com", }
    att =  Attendee.new(row)
    q << att

   assert_equal "Calzone", q.final_queue[0].last_name
   assert_equal "0000000123", q.final_queue[0].home_phone
   assert_equal "", q.final_queue[0].state
  end

  def test_count_t_can_count_number_of_items
    q = Que.new
    row1 = {first_name: "Jon", last_name: "kimble", homephone: "0000000000", zipcode: "00000"}
    row2 = {first_name: "Jon", last_name: "kimble", homephone: "0000000000", zipcode: "00000"}
    att1 = Attendee.new(row1)
    att2 = Attendee.new(row2)

    assert_equal 0, q.count

    q << att1
    assert_equal 1, q.count

    q << att2
    assert_equal 2, q.count
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

  def test_queue_can_print_to_terminal
    er = EventReporter.new
    er.load_file

    er.finds_attribute_type("last_name", "Hunt")
    er.queue.print_q
  end

  def test_queue_can_print_sorted_to_terminal
    er = EventReporter.new
    er.load_file

    er.finds_attribute_type("last_name", "Hunt")
    er.queue.print_sorted_by_attribute("first_name")
  end

  def test_queue_can_get_district_data
    er = EventReporter.new
    er.load_file
    er.finds_attribute_type("last_name", "Hunt")
    er.queue.queue_district

    assert_equal "9", er.queue.final_queue[0].district
    assert_equal "4", er.queue.final_queue[1].district
    assert_equal "5", er.queue.final_queue[2].district
  end

  def test_queue_does_not_get_district_data_when_there_are_more_than_9_items_in_queue
    er = EventReporter.new
    er.load_file
    er.finds_attribute_type("first_name", "Mary")
    er.queue.queue_district
    assert_equal nil, er.queue.final_queue[0].district
    assert_equal nil, er.queue.final_queue[1].district
  end

  def test_can_find_attributes_and_save_to_txt
    er = EventReporter.new
    er.load_file
    er.finds_attribute_type("first_name", "Sarah")
    er.queue.save_to_txt("testing_testing.txt")
  end

  def test_can_find_attributes_and_save_to_json
    er = EventReporter.new
    er.load_file
    er.finds_attribute_type("first_name", "Sarah")
    er.queue.save_to_json("testing_testing.json")
  end

  def test_can_find_attributes_and_save_to_xml
    er = EventReporter.new
    er.load_file
    er.finds_attribute_type("first_name", "Sarah")
    er.queue.save_to_xml("testing_testing.xml")
  end

  def test_can_find_attributes_and_save_to_yaml
    er = EventReporter.new
    er.load_file
    er.finds_attribute_type("first_name", "Sarah")
    er.queue.save_to_yaml("testing_testing.yml")
  end

  def test_can_queue_district_after_clearing_queue
    er = EventReporter.new
    er.load_file
    er.finds_attribute_type("first_name", "Sarah")

    er.queue.queue_district
    assert_equal nil, er.queue.final_queue[0].district

    er.finds_attribute_type("first_name", "Frank")
    er.queue.queue_district
    assert_equal "15", er.queue.final_queue[0].district
  end
end
