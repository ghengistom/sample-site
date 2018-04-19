namespace :examples do
  desc 'pull descriptions from aPDF website and update examples'
  task :update_description => :environment do
    require 'open-uri'
    
    products = {
      1 => {:url => "http://www.activepdf.com/AltDownloads/Documentation/SV2009_API", :search => "div.Section1"},
      2 => {:url => "http://www.activepdf.com/AltDownloads/Documentation/WGWBE_2010_API", :search => "div.Section1"},
      7 => {:url => "http://www.activepdf.com/AltDownloads/Documentation/TK2011", :search => "div#mainbody > table > tbody > tr > td > table > tbody > tr > td > table"},
      8 => {:url => "http://www.activepdf.com/AltDownloads/Documentation/DCWBE_2010_API", :search => "div#mainbody"},
      13 => {:url => "http://www.activepdf.com/AltDownloads/Documentation/DCE2010_API", :search => "div.Section1"},
      14 => {:url => "http://www.activepdf.com/AltDownloads/Documentation/WebGrabber2009_API", :search => "div.Section1"}
    }
    products.each do |id, options|
      LegacyDocumentation.get(id, options)
    end
    
    puts "Done!"
  end
end

desc 'download the current production database and replace the local development db'
task :reverse_deploy do
   `scp -C ianneub@10.1.10.40:/opt/examples/shared/production.sqlite3 ~/Documents/Code/apdf-examples/db/development.sqlite3`
   `rm -rf ~/Documents/Code/apdf-examples/public/system`
   `scp -Cr ianneub@10.1.10.40:/opt/examples/shared/system ~/Documents/Code/apdf-examples/public/`
   `rm -rf ~/Documents/Code/apdf-examples/public/system/files && mkdir ~/Documents/Code/apdf-examples/public/system/files`
   `scp -Cr ianneub@10.1.10.40:/opt/examples/shared/system/files/* ~/Documents/Code/apdf-examples/public/system/files/`
end