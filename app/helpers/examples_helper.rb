module ExamplesHelper
  def language_options_for_select(selected)
    options_for_select(languages, selected)
  end
  
  def example_languages_paths(options = {})
    example = Example.find(options[:example_id])
    options[:version] ||= example.versions.order("sort_order ASC").last.name
    urls = Hash.new
    Example.all_languages.each do |name,value|
      urls[value] = examples_path(:product => example.product.name, :version => options[:version], :title => example.title, :language => value)
    end
    return urls
  end
  
  def example_list_item_class(type)
    case type
    when "method"
      "example_list_item_method"
    when "property"
      "example_list_item_property"
    when "advanced"
      "example_list_item_advanced"
    else
      ""
    end
  end
end