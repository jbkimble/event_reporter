module Cleaner
  def self.clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def self.clean_name(name)
    name.strip.split.map{|word| word.capitalize}.join(' ')
  end

  def self.clean_phone_number(phonenumber)
    phonenumber.delete(' ()-.E').rjust(10, "0")
  end
end
