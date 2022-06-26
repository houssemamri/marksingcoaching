require 'rails_helper'

xdescribe 'Content Generator' do
  let(:user) { create :user }

  let(:fields) { %w[audience topic outcome problem solution] }
  let(:support_answers) { FactoryBot.build_stubbed(:content_gen_survey_answer) }

  def submit_questions
    fields.each do |field|
      fill_in("content_gen_survey_answer_#{field}", with: support_answers.send(field))
    end

    click_on 'Get Inspired >'
  end

  context 'user (not signed in)' do
    before do
      visit new_content_gen_survey_answer_path
    end

    scenario 'has form' do
      fields.each do |field|
        expect(page).to have_field("content_gen_survey_answer_#{field}")
      end
    end

    scenario 'has name field for form' do
      expect(page).not_to have_field('content_gen_survey_answer_name')
    end

    scenario 'can generate answers' do
      submit_questions

      expect(page).to have_content(
        "10 Best #{support_answers.topic} tips for #{support_answers.audience.pluralize}".titleize
      )
      expect(page).to have_css('table tr', count: 10)
    end

    context 'wants to buy' do
      scenario 'is presented with CTA' do
        submit_questions

        expect(page).to have_css('.btn', text: 'Unlock >')
      end
    end

    scenario 'is not presented with full product' do
      submit_questions

      expect(page).not_to have_css('#paid-tool')
    end
  end

  context 'user is signed in' do
    before do
      sign_in user
    end

    context 'and has bought access' do
      before do
        payment = Payment.create(
          email: user.email,
          products: ['Content Idea Generator'],
          paid: true,
          amount: 4700
        )
        visit new_content_gen_survey_answer_path
      end

      scenario 'is presented with full product' do
        submit_questions

        expect(page).to have_css('#paid-tool')
      end
    end

    scenario 'has name field for form' do
      visit new_content_gen_survey_answer_path

      expect(page).to have_field('content_gen_survey_answer_name')
    end
  end
end
