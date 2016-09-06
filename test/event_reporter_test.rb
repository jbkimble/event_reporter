gem 'minitest'
require_relative '../lib/event_reporter'
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

    @csv.length,
  end
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
