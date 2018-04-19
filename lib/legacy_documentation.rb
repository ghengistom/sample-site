module LegacyDocumentation
  
  def self.get(id, options = Hash.new)
    Example.where(:product_id => id).each do |e|
      if e.list_type == "method" || e.list_type == "property"
        url = "#{options[:url]}/#{e.title}.html"
        begin
          doc = Nokogiri::HTML(open(url))
          code = doc.css(options[:search])
          
          e.description = clean(code)
          if e.save
            # puts "#{e.title} updated."
          end
        rescue => error
          if url.scan("%20").empty?
            url.gsub!(".html","%20.html")
            retry
          else
            puts "Error: #{url}"
          end
        end
      end
    end
  end
  
  def self.clean(code)
    # clean out font tags that are trying to set code styles
    code.css('font[face="Lucida Console"]').each do |tag|
      tag.name = "span"
      tag.set_attribute("class", "CodeFont")
      tag.remove_attribute("face")
      tag.remove_attribute("style")
    end
  
    # clean out width settings from td tags
    code.css('[width]').each do |tag|
      tag.remove_attribute("width")
    end
    
    # clean up 'a' tags to remove ".html" & change mailto's to links to support site.
    code.css('a').each do |tag|
      tag.set_attribute "href", tag.attribute('href').to_s.gsub(".html", "")
      unless tag.attribute('href').to_s.scan("mailto:").empty?
        tag.set_attribute('href','http://support.activepdf.com')
      end
    end
    
    # remove random tags
    code = code.to_s.gsub('&lt;/:NOTE.NORMAL.END&gt;', "")
    code = code.to_s.gsub('&lt;/!--DXMETADATA&gt;', "")
    
    return code
  end
  
end