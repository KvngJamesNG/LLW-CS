class Ahoy::Store < Ahoy::DatabaseStore
end

# set to true for JavaScript tracking
Ahoy.api = true

# set to true for geocoding (and add the geocoder gem to your Gemfile)
# we recommend configuring local geocoding as well
# see https://github.com/ankane/ahoy#geocoding
 # Enable JS tracking
Ahoy.geocode = true   # Disable geocoding (or true if you want it)
Ahoy.track_bots = true # Exclude bots (set to true if you want to track them)