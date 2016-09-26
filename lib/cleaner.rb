module Cleaner
  def self.clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def self.clean_name(name)
    if name == nil
      name = ""
    else
      name.strip.split.map{|word| word.capitalize}.join(' ')
    end
  end

  def self.clean_phone_number(phonenumber)
    if phonenumber == nil
      phonenumber = ""
    else
      phonenumber.delete(' ()-.E').rjust(10, "0")
    end
  end

  def self.clean_address(address)
    if address == nil
      address = ""
    else
      address.gsub!('#,/', ' ')
    end
  end

  def self.clean_state(state=nil)
    if state == nil
      return ""
    else
      return state
    end
  end
end
