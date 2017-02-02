module TopicsHelper
  def user_is_authorized_for_topics?
      current_user.nil? == false
  end
end
