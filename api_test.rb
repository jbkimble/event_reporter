require "rubygems"
require "sunlight"
Sunlight::Base.api_key = "bb3a1ba8af354f1dbfb1769f4cd893bb"

district_info = Sunlight::District.get(:latitude => 33.876145, :longitude => -84.453789)
congresspeople = Sunlight::Legislator.all_for(:address => "123 Fifth Ave New York, NY 10003")
senior_senator = congresspeople[:senior_senator]
require "pry"; binding.pry
