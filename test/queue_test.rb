gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/event_reporter'
require './lib/queue'

class QueueTest < Minitest::Test
  def test_queue_is_available_in_queue_class
  tr = EventReporter.new
  tr.load_file
  tr.finds_attribute_type("first_name", "shiyu ")
  p loaded_queue
  end
end
