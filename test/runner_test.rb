require './lib/event_reporter'
require './lib/runner'
require 'minitest/autorun'
require 'minitest/pride'

class AttendeeTest < Minitest::Test
  def test_runner_creates_instance_of_event_reporter
    assert_equal EventReporter, er_ob.class
  end
end
