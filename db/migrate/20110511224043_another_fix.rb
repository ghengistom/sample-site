class AnotherFix < ActiveRecord::Migration
  class Example < ActiveRecord::Base; end
  
  def self.up
    Example.all.each do |e|
      e.code = e.code.gsub("with_wg_wbe", "with_wgw")
      e.code = e.code.gsub("with_dc_wbe", "with_dcw")
      e.code = e.code.gsub("with_wb_wbe", "with_wgw")
      e.code = e.code.gsub("with_wb", "with_wg")
      e.save
    end
  end

  def self.down
  end
end
