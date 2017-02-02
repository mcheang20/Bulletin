module TopicsHelper
  def user_is_authorized_for_topics?
      current_user.nil? || current_user || current_user.admin?
  end

  def topic_authorized?
    current_user == @topic.user || current_user.admin?
  end
end
