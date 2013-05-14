module ApplicationHelper
  def toggle_link_to(name, options, session_key, html_options = {})
    active_state = user_signed_in? && user_session[session_key] == true
    data = { 'toggle' => 'button', 'toggle-session' => session_key }

    html_options.merge! remote: true
    if active_state
      html_options[:class] ||= {}
      html_options[:class].push('active')
    end
    html_options.deep_merge! data: data

    link_to(name, options, html_options)
  end
end
