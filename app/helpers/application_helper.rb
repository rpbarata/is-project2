# frozen_string_literal: true

module ApplicationHelper
  def translate_attribute(object = nil, method = nil)
    object && method ? object.model.human_attribute_name(method) : ""
  end
end
