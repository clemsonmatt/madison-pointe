module ApplicationHelper
  def permission?(permission)
    @user&.permission?(permission)
  end
end
