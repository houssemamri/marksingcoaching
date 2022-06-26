# require 'rails_helper'

# describe 'Build Page' do
#   before do
#     visit build_path
#   end

#   scenario 'sees starter form' do
#     expect(page).to have_css('input#lead_capture_tool_type-widget')
#     expect(page).to have_css('input#lead_capture_tool_type-pop-up')
#     expect(page).to have_css('input#lead_capture_tool_type-landing-page')
#   end

#   # scenario 'name is required' do
#   #   choose 'lead_capture_tool_type-widget'
#   #   click_on 'Build'
#   #   expect(page).to have_content('Please enter a name and select a type to continue.')
#   # end

#   scenario 'type is required' do
#     click_on 'Build'
#     expect(page).to have_content('Please select a Type to continue.')
#   end

#   # context 'an unregistered user' do
#   #   before do
#   #     fill_in 'lead_capture_tool_name', with: 'Name'
#   #     click_on 'Build'
#   #   end

#   #   context 'picks a blank Lead Magnet' do
#   #     scenario 'is taken to the new Lead Magnet page upon sign up' do
#   #     end
#   #   end

#   #   context 'picks a custom Lead Magnet' do
#   #     scenario 'has their first custom Lead Magnet created upon sign up' do
#   #     end
#   #   end

#   #   context 'picks a 123 Lead Magnet' do
#   #     scenario 'is redirected to the 123 LM show page for that type of Lead Capture Tool upon sign up' do
#   #     end
#   #   end
#   # end
# end
