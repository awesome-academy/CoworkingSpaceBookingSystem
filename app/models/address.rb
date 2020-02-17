class Address < ApplicationRecord
  belongs_to :venue
  geocoded_by :city
  after_validation :geocode
end
