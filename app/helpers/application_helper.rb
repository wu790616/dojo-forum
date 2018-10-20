module ApplicationHelper
  include Pagy::Frontend

  def is_active?(paths)
    request.path == paths ? "active" : ""
  end
end
