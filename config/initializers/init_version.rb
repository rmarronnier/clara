major = ENV["MAJOR_VERSION"] || 14
minor = ENV["MINOR_VERSION"] || 6
build = ENV["BUILD_VERSION"] || 0



ARA_VERSION = "#{[major.to_s, minor.to_s, build.to_s].join('.')}"
ARA_EXT_URL = ENV.to_h.select { |key, value| key.to_s.match(/^ARA_URL/) }
