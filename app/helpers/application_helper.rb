module ApplicationHelper

  def title
    base_title = "Calling This Home Cookbook"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
    logo = image_tag("logo2.jpg", :alt => "Calling This Home Cookbook", :class => "round")
  end
end
