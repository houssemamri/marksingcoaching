module Embeddable
  #   extend ActiveSupport::Concern

  #   included do
  #   end

  #   def display_url
  #     "#{ENV['HOST_URL']}page/#{slug}"
  #   end

  #   def embed_url(user)
  #     if user
  #       "#{ENV['HOST_URL']}v1/widget/#{user.id}/#{self.class.to_s.downcase}/#{id}"
  #     else
  #       user = User.find_by(email: 'lewaabahmad@gmail.com')
  #       "#{ENV['HOST_URL']}v1/widget/#{user.id}/#{self.class.to_s.downcase}/#{id}"
  #     end
  #   end

  #   def embed_code(user)
  #     "<div style='width:100%;'><iframe src='#{embed_url(user)}' style='border:none;width:100%;height:240px;'></iframe></div>"
  #   end

  #   def pop_up_link(user)
  #     "<button onClick='MarkSingCoaching.launchPopUp(#{embed_url(user).dump})'>Get Now</button>"
  #   end

  #   def time_out_code(user)
  #     "<script>setTimeout(function() { MarkSingCoaching.launchPopUp(#{embed_url(user).dump}) }, 5000)</ script>"
  #   end

  #   def landing_page_url(user)
  #     if user
  #       "#{ENV['HOST_URL']}landing/#{user.id}/#{id}"
  #     else
  #       user = User.find_by(email: 'lewaabahmad@gmail.com')
  #       "#{ENV['HOST_URL']}landing/#{user.id}/#{id}"
  #     end
  #   end
end
