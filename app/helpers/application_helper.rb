# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def with_loading
    {
      :loading => "Element.show('loading')",
      :loaded => "Element.hide('loading')"
    }
  end

end
