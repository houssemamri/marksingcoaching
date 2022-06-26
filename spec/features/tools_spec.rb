require 'rails_helper'

describe 'Tools Dashboard' do
  let(:user) { create :user }

  context 'index' do
    before do
      sign_in user
      visit tools_path
    end

    scenario 'has content' do
      expect(page).to have_content 'Embeddables'
      expect(page).to have_content 'Landing Pages'
    end
  end
end
