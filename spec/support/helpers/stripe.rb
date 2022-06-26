module Helpers
  module Stripe
    # FROM: https://gorails.com/blog/fill-in-stripe-elements-js-for-sca-3d-secure-2-and-capybara

    # Fills out the Stripe card element with the provided card details in Capybara
    # You can also provide a custom selector to find the correct iframe
    # By default, we use the ID of "#card-element" which Stripe uses in their documentation
    def fill_stripe_elements(card:, expiry: '1234', cvc: '123', postal: '12345', selector: '#card-element > div > iframe')
      find_frame(selector) do
        card.to_s.chars.each do |piece|
          find_field('cardnumber').send_keys(piece)
        end

        find_field('exp-date').send_keys expiry
        find_field('cvc').send_keys cvc
        find_field('postal').send_keys postal
      end
    end

    # Completes SCA authentication successfully
    def complete_stripe_sca
      find_frame('body > div > iframe') do
        # This helps find the inner iframe in the SCA modal's challenge frame which doesn't load immediately
        sleep 1

        find_frame('#challengeFrame') do
          click_on 'Complete authentication'
        end
      end
    end

    # Fails SCA authentication
    def fail_stripe_sca
      find_frame('body > div > iframe') do
        # This helps find the inner iframe in the SCA modal's challenge frame which doesn't load immediately
        sleep 1

        find_frame('#challengeFrame') do
          click_on 'Fail authentication'
        end
      end
    end

    # Generic helper for finding an iframe
    def find_frame(selector, &block)
      using_wait_time(15) do
        frame = find(selector)
        within_frame(frame) do
          block.call
        end
      end
    end
  end
end
