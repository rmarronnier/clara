require 'uri'
require 'net/http'
require 'json'

class IsZrr

  def call(citycode)
    str_val = citycode.to_s
    five_digits_only = /\A\d{5}\z/
    has_5_digits = !!str_val.match(five_digits_only)
    return nil unless has_5_digits
    zrrs = Rails.cache.fetch("zrrs") do
      Zrr.first ? Zrr.first.value  : ""
    end
    zrrs && zrrs.include?(citycode) ? "oui" : "non"
  end
  
end
