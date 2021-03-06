module ApplicationHelper
  def smartnav
    links = ''
    links += shuffla
    links += " | "
    if @current_user.present?
      links += "<li>"
      links += link_to('Logout', login_path, :data => {:method => :delete, :confirm => 'Really logout?'})
      links += "</li>"
      links += " | "
      links += "<li>"
      links += link_to("Welcome #{@current_user.name}", user_path(@current_user))
      links += "</li>"
    else
      links += "<li>#{ link_to('Sign up', new_user_path) }</li>"
      links += " | "
      links += "<li>#{ link_to('Sign in', login_path) }</li>"
    end

    links
  end

  def shuffla
    "<li>#{ link_to('Shuffla', root_path) }</li>"
  end
end
