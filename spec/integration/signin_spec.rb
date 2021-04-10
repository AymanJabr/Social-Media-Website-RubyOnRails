require 'rails_helper'

RSpec.describe 'Sign in page', type: :system do
  describe 'index page' do
    it 'shows sign in ' do
      visit users_path
      expect(page).to have_content('Sign in')
    end
    it 'shows Email ' do
      visit users_path
      expect(page).to have_content('Email')
    end
    it 'shows Password ' do
      visit users_path
      expect(page).to have_content('Password')
    end
    it 'shows Sign up ' do
      visit users_path
      expect(page).to have_content('Sign up')
    end
  end
end
