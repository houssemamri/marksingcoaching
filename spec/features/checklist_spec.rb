# require 'rails_helper'

# describe 'Checklist' do
#   let(:user) { create :user }

#   before do
#     sign_in user
#     visit create_path
#   end

#   context 'new' do
#     before do
#       visit create_path
#     end

#     scenario 'provides Check List' do
#       expect(page).to have_content 'Checklist'
#       click_on 'create a checklist'
#       expect(page).to have_field :checklist_name
#     end

#     scenario 'can create a Check List' do
#       click_on 'create a checklist'
#       fill_in(:checklist_name, with: 'NAME')
#       click_on 'Create Checklist'
#       expect(page).to have_css(:h1, text: 'NAME')
#     end
#   end

#   context 'edit' do
#     let(:checklist) { FactoryBot.create :checklist, user: user }

#     before do
#       visit edit_checklist_path(checklist)
#     end

#     scenario 'provides form' do
#       expect(page).to have_field :checklist_name
#     end

#     scenario 'can update a Check List' do
#       fill_in(:checklist_name, with: 'yo')
#       click_on 'Update Checklist'
#       expect(page).to have_css(:h1, text: 'yo')
#     end
#   end

#   context 'index' do
#     let!(:checklist) { FactoryBot.create :checklist, user: user }

#     scenario 'is viewable on /checklists' do
#       visit checklists_path
#       expect(page).to have_content(checklist.name)
#     end

#     scenario 'is viewable on /library' do
#       visit library_path
#       find('tr p', text: checklist.name, wait: 20)
#       expect(page).to have_content(checklist.name)
#       expect(page).to have_content('Checklist')
#     end
#   end
# end
