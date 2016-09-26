require './lib/cleaner'
require 'minitest/autorun'
require 'minitest/pride'

class CleanerTest < Minitest::Test
  def test_can_clean_zipcode
    assert_equal "00000", Cleaner.clean_zipcode(nil)
    assert_equal "00000", Cleaner.clean_zipcode("")
    assert_equal "28920", Cleaner.clean_zipcode("289208140123")
    assert_equal "00048", Cleaner.clean_zipcode("48")
  end

  def test_can_clean_names
    assert_equal "", Cleaner.clean_name(nil)
    assert_equal "Mary", Cleaner.clean_name("mary")
    assert_equal "Marymultiplename", Cleaner.clean_name("mary" "multiple" "name")
    assert_equal "Mary", Cleaner.clean_name("          mary     ")
    assert_equal "Mary Awesomename", Cleaner.clean_name("mary     " " Awesomename")
  end

  def test_can_clean_phone_numbers
    assert_equal "", Cleaner.clean_phone_number(nil)
    assert_equal "0000888555", Cleaner.clean_phone_number("888 555")
    assert_equal "8885551111", Cleaner.clean_phone_number("888-555-1111")
    assert_equal "0000000888", Cleaner.clean_phone_number("888EEEEE")
    assert_equal "8885551111", Cleaner.clean_phone_number("(888)-555-1111")
    assert_equal "8885551111", Cleaner.clean_phone_number("888 555   1111")
    assert_equal "8885551111", Cleaner.clean_phone_number("(8)8---8-555-1111")
  end

  def test_can_clean_address
    assert_equal "", Cleaner.clean_address(nil)
  end

  def test_can_clean_state
    assert_equal "", Cleaner.clean_state(nil)
  end
end
