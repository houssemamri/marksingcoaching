require 'rails_helper'

RSpec.describe LeadCaptureTool do
  it 'has slugs off name scoped to the user' do
    lead_magnet = create :lead_magnet
    first_user = create :user
    second_user = create :user
    first_user_first_lead_capture_tool = create(
      :lead_capture_tool,
      user: first_user,
      lead_magnet: lead_magnet,
      name: 'Tool Name'
    )
    first_user_second_lead_capture_tool = create(
      :lead_capture_tool,
      user: first_user,
      lead_magnet: lead_magnet,
      name: 'Tool Name'
    )
    second_user_lead_capture_tool = create(
      :lead_capture_tool,
      user: second_user,
      lead_magnet: lead_magnet,
      name: 'Tool Name'
    )

    expect(first_user_first_lead_capture_tool.slug).to eq('tool-name')
    expect(first_user_second_lead_capture_tool.slug).not_to eq('tool-name')
    expect(first_user_second_lead_capture_tool.slug).to match('tool-name')
    expect(second_user_lead_capture_tool.slug).to eq('tool-name')
  end
  # it 'only allows widget, pop up, and landing page as tool_type options' do
  #   instance = LeadCaptureTool.new
  #   instance.tool_type = 'invalid'
  #   expect(instance).to be_invalid
  # end
end
