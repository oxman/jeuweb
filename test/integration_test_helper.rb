ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

Capybara.app = Jeuweb::Application

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def sign_in_as(user)
    visit '/sign_in'
    within 'form' do
      fill_in 'session[name]', with: user.name
      fill_in 'session[password]', with: user.password
      find('[type=submit]').click
    end
  end
end
