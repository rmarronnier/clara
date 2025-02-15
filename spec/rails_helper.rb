ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'capybara/rspec'
require 'rspec/rails'
require 'capybara/poltergeist'
require 'support/factory_bot'

#custom helpers
require 'support/admin_helper'

Capybara.javascript_driver = :poltergeist

ActiveRecord::Migration.maintain_test_schema!

def expect_all_unchecked(checkbox_or_radio_buttons)
  checkbox_or_radio_buttons.each do |checkbox_or_radio_button|
    expect(checkbox_or_radio_button).not_to be_checked
  end
end

def expect_all_inputs_are_empty(inputs)
  inputs.each do |input|
    expect(input.value).to eq ''
  end
end

def expect_all_checked(checkbox_or_radio_buttons)
  checkbox_or_radio_buttons.each do |checkbox_or_radio_button|
    expect(checkbox_or_radio_button).to be_checked
  end
end

def inject_asker(page, asker)
  page.set_rack_session(:asker => asker.to_yaml)
  page.get_rack_session['asker']
end

def disable_http_service
  http_layer = instance_double("HttpService")
  allow(http_layer).to receive(:get).and_return("unexisting_value")
  allow(http_layer).to receive(:post).and_return("unexisting_value")
  allow(http_layer).to receive(:post_form).and_return("unexisting_value")
  HttpService.set_instance(http_layer)
end
def enable_http_service
  HttpService.set_instance(nil)
end


def enable_qpv_zrr_service
  QpvService.set_instance(nil)
end



def enable_http_service
  HttpService.set_instance(nil)
end

def n(selector)
  res = find_all(selector).length
  if (res == 0 && !page.nil?)
    res = page.all(selector, :visible => false).count
  end
  res
end
def t(selector)
  find(selector).text
end
def tiv(selector)
  res = find(selector).value
end
def tih(selector)
  res = find(selector, visible: false).value
end

def should_have(seen, size, selector, with=nil, with_arg=nil)
  position = 0
  if size.is_a?(Integer)
    expect(seen.css(selector).size).to eq(size)
  elsif size.is_a?(String)
    position = size.to_i - 1
  end
  if with
    if with == :with_text
      expect(seen.css(selector)[position].text.strip).to eq(with_arg)
    elsif with == :with_text_that_include
      expect(seen.css(selector)[position].text.strip).to include(with_arg)
    end
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end
  
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
