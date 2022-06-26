FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :payment do
    factory :payment_for_main_offer do
      amount { 9700 }
      paid { true }
      products { ['Lead Magnets', 'Removed Branding'] }
    end
    factory :payment_for_main_offer_and_oto do
      amount { 12300 }
      paid { true }
      products { ['Lead Magnets', 'Social Media Courses', 'Removed Branding'] }
    end
  end

  factory :course do
    name { FFaker::Name.name }
    factory :lead_course do
      type { 'BonusCourse' }
    end
    factory :one_time_offer_course do
      type { 'OneTimeOfferCourse' }
    end
  end

  factory :lead_magnet do
    title { FFaker::Name.name }
    price { 500 }
  end

  factory :lead do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
  end

  factory :lead_capture_tool do
    name { FFaker::Name.name }
    user { user }
    lead_magnet { lead_magnet }
  end

  # factory :landing_page, parent: :lead_capture_tool, class: 'LandingPage' do
  # end

  factory :checklist do
    name { FFaker::Name.name }
    user { user }
  end

  factory :content_gen_survey_answer do
    audience { 'entreprenuers' }
    topic { 'digital marketing' }
    outcome { 'get tons of traffic' }
    problem { 'lack of resources' }
    solution { 'an easy framework' }
    action_1 { FFaker::Name.name }
    action_2 { FFaker::Name.name }
    action_3 { FFaker::Name.name }
    negative_action_1 { FFaker::Name.name }
    negative_action_2 { FFaker::Name.name }
    negative_action_3 { FFaker::Name.name }
  end
end
