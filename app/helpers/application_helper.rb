module ApplicationHelper
  def managing_tags?
    user_signed_in? && user_session[:managing_tags] == true
  end

  def tag_manager_button
    button_state = ('active' if managing_tags?) || ''
    link_to 'Manage Tags', tag_categories_path(toggle_managing_tags: true), remote: true,
            class: "manage-tags btn btn-small btn-block #{button_state}", data: { toggle: 'button' }
  end
end
