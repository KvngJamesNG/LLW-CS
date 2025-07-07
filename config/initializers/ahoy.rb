class Ahoy::Store < Ahoy::DatabaseStore
end

# set to true for JavaScript tracking
Ahoy.api = false

# set to true for geocoding (and add the geocoder gem to your Gemfile)
# we recommend configuring local geocoding as well
# see https://github.com/ankane/ahoy#geocoding
Ahoy.geocode = false

Ahoy.configure do |config|
  config.geocode = true        # enables IP-based location tracking
  config.track_bots = true   # skip Googlebot, Bingbot, etc.
end
