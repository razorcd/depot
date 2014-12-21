module ApplicationHelper
  def hidden_div_if (contidion, attributes = {}, &block)
    if contidion
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end
end
