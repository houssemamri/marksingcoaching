# frozen_string_literal: true

module Ok
  class Component < ViewComponent::Base
    def initialize(title:)
      @title = title
    end
  end
end
