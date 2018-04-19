require "nokogiri"

file = File.open("/Users/ianneubert/Dropbox/Shares/Aaron/Sample/ADK.xml")
contents = file.read

@doc = Nokogiri::XML(contents)

names = Hash.new{|k,v| v = 0}

@doc.xpath("//member").each do |member|
  names[member["name"][0]] += 1
end

puts names.inspect