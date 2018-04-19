class FixNameChangeBug < ActiveRecord::Migration
  class Example < ActiveRecord::Base; end
  
  def self.up
    Example.all.each do |e|
      e.code = e.code.gsub("with_webgrabber", "with_wg")
      e.code = e.code.gsub("with_webgrabber_wbe", "with_wgw")
      e.save
    end
  end

  def self.down
  end
end
