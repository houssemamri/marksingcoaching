module ApplicationHelper
  def bought_by(user)
    if user
      # cp = Payment.find_by(user_id: user.id, course_id: id)
      # As long as we have a charge... we should be good. until we need to
      # have more abstract logic.
      cp ||= Payment.find_by(email: user.email, paid: true)
    end
    cp
  end

  def resource_accessible_by(user)
    bought_by(user) || false
  end
end
