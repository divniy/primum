class PostDecorator < Draper::Decorator
  delegate_all

  def created_at
    time_format = Date.today == object.created_at.to_date ? :short : :long
    h.l object.created_at, format: time_format
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
