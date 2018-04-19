class JsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  layout false
  before_filter :js_content_type
  before_filter :process_parameters
  
  caches_action :list, :cache_path => proc {|c| c.params}, :unless => proc {|c| can?(:manage, :all)}, :expires_in => 4.hours

  def js_content_type
   response.headers['Content-type'] = 'text/javascript; charset=utf-8'
  end
  
  def process_parameters
    @sort_order = params[:sort_order].to_i
    @product_id = params[:product_id].to_i
    @example = params[:example] ? params[:example].downcase : nil
  end
  
  def list
    @examples_methods = ['o87w4altiybk3u']
    @examples_properties = ['o87w4altiybk3u']
    @aPDFMeth_current = 'o87w4altiybk3u'
    @aPDFProp_current = 'o87w4altiybk3u'
    
    @examples_methods << Example.find_all_by_product_id_and_version_sort_order(@product_id, @sort_order).is_method.collect{|e| e.title.downcase }
    @examples_properties << Example.find_all_by_product_id_and_version_sort_order(@product_id, @sort_order).is_property.collect{|e| e.title.downcase }

    @examples_methods << Example.find_all_by_product_id_and_version_sort_order(@product_id, @sort_order).is_method.collect{|e| e.display_title.downcase.gsub('.','\.') rescue nil }
    @examples_properties << Example.find_all_by_product_id_and_version_sort_order(@product_id, @sort_order).is_property.collect{|e| e.display_title.downcase.gsub('.','\.') rescue nil }
    
    @examples_methods.flatten!
    @examples_methods.delete_if{|a| a.nil?}
    @examples_properties.flatten!
    @examples_properties.delete_if{|a| a.nil?}
    
    if @example
      if @examples_methods.reject!{|i| i == @example}
        @aPDFMeth_current = @example
      elsif @examples_properties.reject!{|i| i == @example}
        @aPDFProp_current = @example
      end
    else
      render :text => "// Example not found"
    end
  end

end
