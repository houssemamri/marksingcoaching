# frozen_string_literal: true

module Header
  class Component < ViewComponent::Base
    def initialize(title:)
      @title = title
    end
  end
end
