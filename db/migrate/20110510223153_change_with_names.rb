class ChangeWithNames < ActiveRecord::Migration
  class Example < ActiveRecord::Base; end
  
  def self.up
    Example.all.each do |e|
      e.code = e.code.gsub("with_server", "with_svr")
      e.code = e.code.gsub("with_webgrabber", "with_wb")
      e.code = e.code.gsub("with_webgrabber_wbe", "with_wbw")
      e.code = e.code.gsub("with_docconverter", "with_dc")
      e.code = e.code.gsub("with_docconverter_wbe", "with_dcw")
      e.code = e.code.gsub("with_toolkit", "with_tk")
      e.save
    end
  end

  def self.down
  end
end
