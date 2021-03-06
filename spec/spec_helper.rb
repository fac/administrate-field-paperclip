# start coverage tracking
require 'coveralls'
require 'simplecov'
SimpleCov.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'administrate/field/paperclip'
# config Paperclip for testing purposes
require 'kt-paperclip'
require 'fog'
Paperclip::Attachment.default_options[:storage] = :fog
Paperclip::Attachment.default_options[:fog_credentials] = {
  provider: 'Local',
  local_root: File.join(__FILE__, '../processed_images'),
}
Paperclip::Attachment.default_options[:fog_directory] = ''
Paperclip::Attachment.default_options[:fog_host] = 'http://localhost:3000'

# enable debugging using byebug
require 'byebug'

# start up factory_girl
require 'factory_girl'

# start db and load migrations and everything
require 'active_record'
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
require_relative 'schema'
require_relative 'models'

# config rspec
RSpec.configure do |config|
  # configure factory girl
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end
